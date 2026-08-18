class OrderItemEntity {
  const OrderItemEntity({this.productId, this.name, this.quantity, this.price});

  final String? productId;
  final String? name;
  final int? quantity;
  final num? price;
}
