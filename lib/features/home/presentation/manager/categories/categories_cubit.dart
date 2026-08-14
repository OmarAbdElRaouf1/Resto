import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:resto/features/home/data/models/products_model.dart';
import 'package:resto/features/home/data/repos/home_repo.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.homeRepo) : super(CategoriesInitial());
  final HomeRepo homeRepo;

  Future<void> getCategories() async {
    emit(CategoriesLoading());
    try {
      final categories = await homeRepo.getCategories();
      emit(CategoriesSuccess(categories));
    } catch (e) {
      emit(CategoriesFailure(errorMessage: e.toString()));
    }
  }
}
