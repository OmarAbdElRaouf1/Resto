part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class GetCartLoadingState extends CartState {}

final class GetCartSuccessState extends CartState {
  final CartEntity cart;
  GetCartSuccessState(this.cart);
}

final class GetCartErrorState extends CartState {
  final String error;
  GetCartErrorState(this.error);
}

final class AddItemToCartLoadingState extends CartState {}

final class AddItemToCartSuccessState extends CartState {
  final CartEntity cart;
  AddItemToCartSuccessState(this.cart);
}

final class AddItemToCartErrorState extends CartState {
  final String error;
  AddItemToCartErrorState(this.error);
}
