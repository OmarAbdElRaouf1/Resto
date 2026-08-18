import 'package:resto/features/cart/domain/entities/cart_item_entity.dart';
import 'package:resto/features/home/data/models/products_model.dart';

class CartItemModel extends CartItemEntity {
  CartItemModel({super.productId, super.product, super.quantity, super.price});

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final productJson = json['product'];

    if (productJson is String) {
      return CartItemModel(
        productId: productJson,
        quantity: json['quantity'],
        price: json['price'],
      );
    }

    if (productJson is Map<String, dynamic>) {
      final product = ProductModel.fromJson(productJson);

      return CartItemModel(
        productId: product.id,
        product: product,
        quantity: json['quantity'],
        price: json['price'],
      );
    }

    return CartItemModel(quantity: json['quantity'], price: json['price']);
  }
}
