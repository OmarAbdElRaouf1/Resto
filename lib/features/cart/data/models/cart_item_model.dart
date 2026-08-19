import 'package:resto/features/cart/domain/entities/cart_item_entity.dart';
import 'package:resto/features/home/data/models/products_model.dart';

class CartItemModel extends CartItemEntity {
  CartItemModel({
    super.id,
    super.productId,
    super.product,
    super.quantity,
    super.price,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final id = (json['_id'] ?? json['id'])?.toString();
    final productJson = json['product'] ?? json['productId'];

    ProductModel? product;
    String? productId;

    final rawQty = json['quantity'];
    final quantity = rawQty is num
        ? rawQty.toInt()
        : int.tryParse(rawQty?.toString() ?? '1') ?? 1;

    final rawPrice = json['price'];
    int? parsedItemPrice = rawPrice is num
        ? rawPrice.toInt()
        : int.tryParse(rawPrice?.toString() ?? '');

    if (productJson is Map<String, dynamic>) {
      final parsedProduct = ProductModel.fromJson(productJson);
      productId = parsedProduct.id ?? json['productId']?.toString() ?? id;
      final name = parsedProduct.name ?? json['name']?.toString();
      final image = parsedProduct.image ?? json['image']?.toString();
      final desc = parsedProduct.description ?? json['description']?.toString();
      final productPrice = parsedProduct.price ?? parsedItemPrice;

      product = ProductModel(
        id: productId,
        name: name,
        description: desc,
        price: productPrice,
        image: image,
        category: parsedProduct.category,
        ingredients: parsedProduct.ingredients,
        isAvailable: parsedProduct.isAvailable,
        isSpicy: parsedProduct.isSpicy,
        rating: parsedProduct.rating,
      );

      parsedItemPrice ??= productPrice;
    } else if (productJson is String) {
      productId = productJson;
      final name = json['name']?.toString();
      final image = json['image']?.toString();
      final desc = json['description']?.toString();

      product = ProductModel(
        id: productJson,
        name: name,
        description: desc,
        price: parsedItemPrice,
        image: image,
      );
    } else {
      final name = json['name']?.toString();
      final image = json['image']?.toString();
      final desc = json['description']?.toString();

      product = ProductModel(
        id: id,
        name: name,
        description: desc,
        price: parsedItemPrice,
        image: image,
      );
    }

    return CartItemModel(
      id: id ?? productId,
      productId: productId ?? id,
      product: product,
      quantity: quantity,
      price: parsedItemPrice ?? product.price ?? 0,
    );
  }
}
