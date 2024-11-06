
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/bloc/login/login_bloc.dart';
import 'package:product_app/data/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../bloc/category/category_bloc.dart';
import '../bloc/products/products_bloc.dart';
import '../widgets/product.dart';
import '../widgets/shimmer.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final AuthRepository authRepository = AuthRepository();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CategoryBloc>().add(FetchCategory());
      context.read<ProductsBloc>().add(FetchProducts(context: context));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: Column(
        children: [
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5, // Arbitrary count for shimmer placeholders
                    itemBuilder: (context, index) => ShimmerCategoryChip(),
                  ),
                );
              } else if (state is CategoryLoaded) {
                return SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            if (category.id == -1) {
                              context.read<ProductsBloc>().add(FetchProducts(context: context)); // Fetch All products
                            } else {
                              context.read<ProductsBloc>().add(
                                  FetchProductsWithCategory(
                                      catId: category.id, context: context));
                            }
                          },
                          child: Chip(
                            label: Text(category.name),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is CategoryError) {
                return Text(state.message);
              }
              return SizedBox();
            },
          ),

          Expanded(
            child: BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                if (state is ProductsLoading) {
                  return ListView.builder(
                    itemCount: 5, // Arbitrary count for shimmer placeholders
                    itemBuilder: (context, index) => ShimmerProductCard(),
                  );
                } else if (state is ProductsLoaded) {
                  return ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return ProductCard(product: product);
                    },
                  );
                } else if (state is ProductsToCategoryLoaded) {
                  return ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ProductCard(product: product);
                      },
                  );
                } else if (state is ProductLoadedEmpty) {
                  return const Center(
                    child: Text('No products to Display'),
                  );
                }
                else if (state is ProductsError) {
                  return Center(child: Text(state.error));
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar homeAppBar(BuildContext context) {
    return AppBar(
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) async {
            if (value == 'profile') {
              // navigate to profile screen
              Navigator.pushNamed(context, '/profile');
            } else if (value == 'logout') {
              context.read<LoginBloc>().add(LogOutEvent());
              // After clearing the token, navigate to the login screen
              Navigator.pushReplacementNamed(context, '/login');
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem<String>(
                value: 'profile',
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.black87), // Add profile icon
                    SizedBox(width: 10),
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87, // Dark text for visibility
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app, color: Colors.black87), // Add logout icon
                    SizedBox(width: 10),
                    Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87, // Dark text for visibility
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
        ),
      ],
        title: const Text(
          'ProductApp',
          style: TextStyle(
            fontSize: 24,              // Font size for the title
            fontWeight: FontWeight.bold, // Bold text style
            color: Colors.black,        // White color for the title text
            letterSpacing: 1.2,         // Slight letter spacing for readability
            fontFamily: 'Roboto',       // You can use any custom font here
          ),
        ),
    );
  }
}
