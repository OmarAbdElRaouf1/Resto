import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:resto/features/home/domain/entities/product_entity.dart';
import 'package:resto/features/home/domain/repositories/home_repo.dart';

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
