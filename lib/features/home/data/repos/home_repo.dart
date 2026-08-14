import 'package:resto/core/network/api_edpoints.dart';
import 'package:resto/core/network/api_service.dart';
import 'package:resto/features/home/data/models/products_model.dart';

abstract class HomeRepo {
  Future<List<ProductModel>> getProducts({String? categoryId});
  Future<List<CategoryModel>> getCategories();
}

class HomeRepoImpl extends HomeRepo {
  final ApiService apiService = ApiService();
  @override
  Future<List<ProductModel>> getProducts({String? categoryId}) async {
    try {
      final response = await apiService.get(
        ApiEdpoints.products,
        param: categoryId != null ? {'category': categoryId} : null,
      );
      return (response as List).map((e) => ProductModel.fromJson(e)).toList();
    } on Exception catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await apiService.get(ApiEdpoints.categories);
      return (response as List).map((e) => CategoryModel.fromJson(e)).toList();
    } on Exception catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }
}
