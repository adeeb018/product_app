part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {}

class FetchProducts extends ProductsEvent {
  final BuildContext context;

  FetchProducts({required this.context});
}

class FetchProductsWithCategory extends ProductsEvent {
  final int catId;
  final BuildContext context;

  FetchProductsWithCategory({required this.catId, required this.context});
}