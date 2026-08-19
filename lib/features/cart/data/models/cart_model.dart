import 'package:resto/features/cart/data/models/cart_item_model.dart';
import 'package:resto/features/cart/domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  CartModel({
    super.id,
    super.user,
    super.items,
    super.createdAt,
    super.updatedAt,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : (json['cart'] is Map<String, dynamic>
            ? json['cart'] as Map<String, dynamic>
            : json);

    final rawItems = data['items'] ?? json['items'];

    return CartModel(
      id: data['_id']?.toString() ?? data['id']?.toString(),
      user: data['user']?.toString(),
      items: (rawItems as List?)
          ?.whereType<Map<String, dynamic>>()
          .map((item) => CartItemModel.fromJson(item))
          .toList() ?? [],
      createdAt: data['createdAt']?.toString(),
      updatedAt: data['updatedAt']?.toString(),
    );
  }
}
