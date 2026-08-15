part of 'categories_cubit.dart';

@immutable
abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
  final List<CategoryEntity> categories;
  CategoriesSuccess(this.categories);
}

class CategoriesFailure extends CategoriesState {
  final String? errorMessage;
  CategoriesFailure({this.errorMessage});
}
