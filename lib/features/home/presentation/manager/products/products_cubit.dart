import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:resto/features/home/data/models/products_model.dart';
import 'package:resto/features/home/data/repos/home_repo.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.homeRepo) : super(ProductsInitial());
  final HomeRepo homeRepo;

  Future<void> getProducts({String? categoryId}) async {
    emit(ProductsLoading());
    try {
      final products = await homeRepo.getProducts(categoryId: categoryId);
      emit(ProductsSuccess(products));
    } catch (e) {
      emit(ProductsFailure(errorMessage: e.toString()));
    }
  }
}
