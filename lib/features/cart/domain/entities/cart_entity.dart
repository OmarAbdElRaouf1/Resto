import 'package:resto/features/cart/domain/entities/cart_item_entity.dart';

class CartEntity {
  final String? id;
  final String? user;
  final List<CartItemEntity>? items;
  final String? createdAt;
  final String? updatedAt;

  const CartEntity({
    this.id,
    this.user,
    this.items,
    this.createdAt,
    this.updatedAt,
  });
}
