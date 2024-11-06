import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/bloc/category/category_bloc.dart';
import 'package:product_app/data/categories_repository.dart';
import 'package:product_app/screens/product_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/login/login_bloc.dart';
import 'bloc/products/products_bloc.dart';
import 'data/auth_repository.dart';
import 'data/products_repository.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('access_token');
  runApp(MyApp(accessToken: accessToken,));
}

class MyApp extends StatelessWidget {
  final String? accessToken;

  const MyApp({super.key, required this.accessToken});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) => LoginBloc(AuthRepository()),
        ),
        BlocProvider<ProductsBloc>(
          create: (_) => ProductsBloc(ProductsRepository()),
        ),
        BlocProvider<CategoryBloc>(
          create: (_) => CategoryBloc(CategoriesRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: accessToken != null && accessToken!.isNotEmpty? HomeScreen() : LoginScreen(),
        routes: {
          '/home': (_) => HomeScreen(),
          '/profile': (_) => ProfileScreen(accessToken: accessToken!,),
          '/login' : (_) => LoginScreen(),
          '/product-details': (_) => ProductDetailsPage(),
        },
      ),
    );
  }
}

