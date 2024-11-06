import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../data/products_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository productsRepository;

  ProductsBloc(this.productsRepository) : super(ProductsInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductsLoading());
      try {
        final products = await productsRepository.fetchProducts(event.context);
        emit(ProductsLoaded(products: products));
      } catch (error) {
        emit(ProductsError(error: error.toString()));
      }
    });

    on<FetchProductsWithCategory>((event, emit) async {
      emit(ProductsLoading());
      try {
        final products = await productsRepository.fetchProducts(event.context);

        final filteredProducts = products.where((product) => product.partsCat == event.catId).toList();
        if (filteredProducts.isEmpty) {
          emit (ProductLoadedEmpty());
        } else {
          emit(ProductsToCategoryLoaded(products: filteredProducts));
        }
      } catch(error) {
        emit(ProductsError(error: error.toString()));
      }
    });
  }
}
