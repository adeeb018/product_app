part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {}

class FetchProducts extends ProductsEvent {}

class FetchProductsWithCategory extends ProductsEvent {
  final int catId;

  FetchProductsWithCategory({required this.catId});
}