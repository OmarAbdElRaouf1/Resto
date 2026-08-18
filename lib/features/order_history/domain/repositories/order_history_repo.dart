import 'package:resto/features/order_history/domain/entities/order_entity.dart';

abstract class OrderHistoryRepo {
  Future<List<OrderEntity>> getMyOrders();
}
