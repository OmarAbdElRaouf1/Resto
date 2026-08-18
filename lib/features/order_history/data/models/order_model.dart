import 'package:resto/features/order_history/data/models/order_item_model.dart';
import 'package:resto/features/order_history/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    super.id,
    super.items,
    super.totalPrice,
    super.status,
    super.deliveryAddress,
    super.phone,
    super.paymentMethod,
    super.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'],
      items: (json['items'] as List?)
          ?.map((item) => OrderItemModel.fromJson(item))
          .toList(),
      totalPrice: json['totalPrice'],
      status: orderStatusFromApi(json['status']),
      deliveryAddress: json['deliveryAddress'],
      phone: json['phone'],
      paymentMethod: json['paymentMethod'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? ''),
    );
  }
}
