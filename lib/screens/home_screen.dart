// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/category/category_bloc.dart';
import '../bloc/products/products_bloc.dart';
import '../widgets/product.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProductsBloc>().add(FetchProducts());
      context.read<CategoryBloc>().add(FetchCategory());

    });
    super.initState();
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token'); // Clear the access token

    // You can add more preferences to clear if needed, like user info.

    // After clearing the token, navigate to the login screen
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'profile') {
                // Navigate to settings screen
                Navigator.pushNamed(context, '/profile');
              } else if (value == 'logout') {
                _logout(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'profile',
                  child: Text('Profile'),
                ),
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
        title: Text('Home'),
      ),
      body: Column(
        children: [
// Categories Section
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return CircularProgressIndicator();
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
                              context.read<ProductsBloc>().add(FetchProducts());
                            } else {
                              context.read<ProductsBloc>().add(
                                  FetchProductsWithCategory(
                                      catId: category.id));
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
                  return Center(child: CircularProgressIndicator());
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
                  return Center(
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
}


// // lib/screens/home_screen.dart
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/category/category_bloc.dart';
// import '../bloc/products/products_bloc.dart';
// import '../models/category.dart';
// import '../models/product.dart';
// import '../data/products_repository.dart';
// import '../widgets/product.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int? selectedCategoryId;
//   late CategoryBloc categoriesBloc;
//   late ProductsBloc productsBloc;
//
//   @override
//   void initState() {
//     super.initState();
//     categoriesBloc = BlocProvider.of<CategoryBloc>(context);
//     productsBloc = BlocProvider.of<ProductsBloc>(context);
//     categoriesBloc.add(FetchCategory());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: Column(
//         children: [
//           BlocBuilder<CategoryBloc, CategoryState>(
//             builder: (context, state) {
//               if (state is CategoryLoading) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (state is CategoryLoaded) {
//                 return DropdownButton<int>(
//                   value: selectedCategoryId,
//                   hint: Text('Select Category'),
//                   items: state.categories.map((Category category) {
//                     return DropdownMenuItem<int>(
//                       value: category.id,
//                       child: Text(category.catName),
//                     );
//                   }).toList(),
//                   onChanged: (int? value) {
//                     setState(() {
//                       selectedCategoryId = value;
//                     });
//                     productsBloc.add(FetchProductsByCategory(value!));
//                   },
//                 );
//               } else if (state is CategoryError) {
//                 return Text('Error: ${state.message}');
//               }
//               return Container();
//             },
//           ),
//           Expanded(
//             child: BlocBuilder<ProductsBloc, ProductsState>(
//               builder: (context, state) {
//                 if (state is ProductsLoading) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (state is ProductsLoaded) {
//                   final filteredProducts = state.products
//                       .where((product) =>
//                   product.partsCat == selectedCategoryId)
//                       .toList();
//                   return GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio: 0.75,
//                       crossAxisSpacing: 8,
//                       mainAxisSpacing: 8,
//                     ),
//                     itemCount: filteredProducts.length,
//                     itemBuilder: (context, index) {
//                       return ProductCard(product: filteredProducts[index]);
//                     },
//                   );
//                 } else if (state is ProductsError) {
//                   return Text('Error: ${state.error}');
//                 }
//                 return Container();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
