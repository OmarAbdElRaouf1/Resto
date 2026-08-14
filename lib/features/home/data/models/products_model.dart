class ProductModel {
  String? sId;
  String? name;
  String? description;
  int? price;
  String? image;
  CategoryModel? category;
  List<String>? ingredients;
  bool? isAvailable;
  bool? isSpicy;
  int? rating;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ProductModel({
    this.sId,
    this.name,
    this.description,
    this.price,
    this.image,
    this.category,
    this.ingredients,
    this.isAvailable,
    this.isSpicy,
    this.rating,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
    category = json['category'] != null
        ? CategoryModel.fromJson(json['category'])
        : null;
    ingredients = json['ingredients'].cast<String>();
    isAvailable = json['isAvailable'];
    isSpicy = json['isSpicy'];
    rating = json['rating'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}

class CategoryModel {
  String? sId;
  String? name;

  CategoryModel({this.sId, this.name});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }
}
