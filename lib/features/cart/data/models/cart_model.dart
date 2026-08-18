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
    return CartModel(
      id: json['_id'],
      user: json['user'],
      items: (json['items'] as List?)
          ?.map((item) => CartItemModel.fromJson(item))
          .toList(),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
