import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:resto/core/network/api_error.dart';
import 'package:resto/features/cart/domain/entities/cart_entity.dart';
import 'package:resto/features/cart/domain/repositories/cart_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({required this.cartRepo}) : super(CartInitial());
  final CartRepo cartRepo;

  CartEntity? currentCart;

  String _getErrorMessage(dynamic error) {
    if (error is ApiError) {
      return error.message;
    }
    final msg = error.toString();
    if (msg.startsWith('Exception: ')) {
      return msg.substring('Exception: '.length);
    }
    return msg;
  }

  // addItemToCart
  Future<void> addItemToCart(String productId, int quantity) async {
    emit(AddItemToCartLoadingState());
    try {
      await cartRepo.addItemToCart(
        productId: productId,
        quantity: quantity,
      );
      final populatedCart = await cartRepo.getMyCart();
      currentCart = populatedCart;
      emit(AddItemToCartSuccessState(populatedCart));
    } catch (e) {
      emit(AddItemToCartErrorState(_getErrorMessage(e)));
    }
  }

  // getMyCart
  Future<void> getMyCart() async {
    emit(GetCartLoadingState());
    try {
      final response = await cartRepo.getMyCart();
      currentCart = response;
      emit(GetCartSuccessState(response));
    } catch (e) {
      emit(GetCartErrorState(_getErrorMessage(e)));
    }
  }

  // updateCartItem
  Future<void> updateCartItem(String cartItemId, int quantity) async {
    emit(UpdateCartItemLoadingState());
    try {
      await cartRepo.updateCartItem(
        cartItemId: cartItemId,
        quantity: quantity,
      );
      final populatedCart = await cartRepo.getMyCart();
      currentCart = populatedCart;
      emit(UpdateCartItemSuccessState(populatedCart));
    } catch (e) {
      emit(UpdateCartItemErrorState(_getErrorMessage(e)));
    }
  }

  // removeItemFromCart
  Future<void> removeItemFromCart(String cartItemId) async {
    emit(RemoveItemFromCartLoadingState());
    try {
      await cartRepo.removeItemFromCart(
        cartItemId: cartItemId,
      );
      final populatedCart = await cartRepo.getMyCart();
      currentCart = populatedCart;
      emit(RemoveItemFromCartSuccessState(populatedCart));
    } catch (e) {
      emit(RemoveItemFromCartErrorState(_getErrorMessage(e)));
    }
  }
}
