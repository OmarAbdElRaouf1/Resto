part of 'products_cubit.dart';

@immutable
abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsSuccess extends ProductsState {
  final List<ProductModel> products;
  ProductsSuccess(this.products);
}

class ProductsFailure extends ProductsState {
  final String? errorMessage;
  ProductsFailure({this.errorMessage});
}
