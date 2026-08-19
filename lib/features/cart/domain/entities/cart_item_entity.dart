import 'package:resto/features/home/domain/entities/product_entity.dart';

class CartItemEntity {
  final String? id;
  final String? productId;
  final ProductEntity? product;
  final int? quantity;
  final int? price;

  const CartItemEntity({
    this.id,
    this.productId,
    this.product,
    this.quantity,
    this.price,
  });
}
