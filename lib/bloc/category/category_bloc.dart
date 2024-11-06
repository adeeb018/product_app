import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../data/categories_repository.dart';
import '../../models/category.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoriesRepository categoriesRepository;

  CategoryBloc(this.categoriesRepository) : super(CategoryInitial()) {
    on<FetchCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        final categories = await categoriesRepository.fetchCategories();
        categories.insert(0,Category(id: -1, name: "All"));
        emit(CategoryLoaded(categories));
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });
  }
}
