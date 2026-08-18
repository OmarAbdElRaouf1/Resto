import 'package:resto/features/order_history/domain/entities/order_item_entity.dart';

enum OrderStatus { pending, preparing, outForDelivery, delivered, cancelled }

extension OrderStatusX on OrderStatus {
  bool get isActive =>
      this == OrderStatus.pending ||
      this == OrderStatus.preparing ||
      this == OrderStatus.outForDelivery;
}

OrderStatus orderStatusFromApi(String? raw) {
  switch (raw) {
    case 'pending':
      return OrderStatus.pending;
    case 'preparing':
      return OrderStatus.preparing;
    case 'out_for_delivery':
      return OrderStatus.outForDelivery;
    case 'cancelled':
      return OrderStatus.cancelled;
    case 'delivered':
    default:
      return OrderStatus.delivered;
  }
}

class OrderEntity {
  const OrderEntity({
    this.id,
    this.items,
    this.totalPrice,
    this.status,
    this.deliveryAddress,
    this.phone,
    this.paymentMethod,
    this.createdAt,
  });

  final String? id;
  final List<OrderItemEntity>? items;
  final num? totalPrice;
  final OrderStatus? status;
  final String? deliveryAddress;
  final String? phone;
  final String? paymentMethod;
  final DateTime? createdAt;
}
