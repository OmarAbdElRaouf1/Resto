import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:resto/features/cart/domain/entities/cart_entity.dart';
import 'package:resto/features/cart/domain/repositories/cart_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({required this.cartRepo}) : super(CartInitial());
  final CartRepo cartRepo;
  // addItemToCart
  Future<void> addItemToCart(String productId, int quantity) async {
    emit(AddItemToCartLoadingState());
    try {
      final response = await cartRepo.addItemToCart(
        productId: productId,
        quantity: quantity,
      );
      emit(AddItemToCartSuccessState(response));
    } catch (e) {
      emit(AddItemToCartErrorState(e.toString()));
    }
  }

  // getMyCart
  Future<void> getMyCart() async {
    emit(GetCartLoadingState());
    try {
      final response = await cartRepo.getMyCart();
      emit(GetCartSuccessState(response));
    } catch (e) {
      emit(GetCartErrorState(e.toString()));
    }
  }
}
