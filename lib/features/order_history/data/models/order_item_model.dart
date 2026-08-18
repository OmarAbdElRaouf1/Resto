import 'package:resto/features/order_history/domain/entities/order_item_entity.dart';

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    super.productId,
    super.name,
    super.quantity,
    super.price,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json['product'] is String ? json['product'] : null,
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }
}
