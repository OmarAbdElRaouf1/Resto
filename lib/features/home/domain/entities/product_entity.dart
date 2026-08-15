class ProductEntity {
  const ProductEntity({
    this.id,
    this.name,
    this.description,
    this.price,
    this.image,
    this.category,
    this.ingredients,
    this.isAvailable,
    this.isSpicy,
    this.rating,
  });

  final String? id;
  final String? name;
  final String? description;
  final int? price;
  final String? image;
  final CategoryEntity? category;
  final List<String>? ingredients;
  final bool? isAvailable;
  final bool? isSpicy;
  final int? rating;
}

class CategoryEntity {
  const CategoryEntity({this.id, this.name});

  final String? id;
  final String? name;
}
