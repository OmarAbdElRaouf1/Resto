import 'package:resto/core/network/api_endpoints.dart';
import 'package:resto/core/network/api_service.dart';
import 'package:resto/features/order_history/data/models/order_model.dart';
import 'package:resto/features/order_history/domain/entities/order_entity.dart';
import 'package:resto/features/order_history/domain/repositories/order_history_repo.dart';

class OrderHistoryRepoImpl implements OrderHistoryRepo {
  final ApiService apiService;

  OrderHistoryRepoImpl(this.apiService);

  @override
  Future<List<OrderEntity>> getMyOrders() async {
    final response = await apiService.get(ApiEndpoints.myOrders);

    return (response as List)
        .map((order) => OrderModel.fromJson(order))
        .toList();
  }
}
