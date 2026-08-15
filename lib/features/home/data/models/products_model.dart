import 'package:resto/features/home/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    super.id,
    super.name,
    super.description,
    super.price,
    super.image,
    super.category,
    super.ingredients,
    super.isAvailable,
    super.isSpicy,
    super.rating,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  final String? createdAt;
  final String? updatedAt;
  final int? iV;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'])
          : null,
      ingredients: (json['ingredients'] as List?)?.cast<String>(),
      isAvailable: json['isAvailable'],
      isSpicy: json['isSpicy'],
      rating: json['rating'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      iV: json['__v'],
    );
  }
}

class CategoryModel extends CategoryEntity {
  CategoryModel({super.id, super.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(id: json['_id'], name: json['name']);
  }
}
