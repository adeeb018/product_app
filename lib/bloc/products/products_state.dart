part of 'products_bloc.dart';

@immutable
sealed class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<dynamic> products;

  ProductsLoaded({required this.products});
}

class ProductsToCategoryLoaded extends ProductsState {
  final List<dynamic> products;

  ProductsToCategoryLoaded({required this.products});
}

class ProductsError extends ProductsState {
  final String error;

  ProductsError({required this.error});
}

class ProductLoadedEmpty extends ProductsState {}
