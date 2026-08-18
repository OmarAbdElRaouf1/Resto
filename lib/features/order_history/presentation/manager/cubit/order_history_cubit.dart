import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:resto/features/order_history/domain/entities/order_entity.dart';
import 'package:resto/features/order_history/domain/repositories/order_history_repo.dart';

part 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  OrderHistoryCubit({required this.orderHistoryRepo})
    : super(OrderHistoryInitial());

  final OrderHistoryRepo orderHistoryRepo;

  Future<void> getMyOrders() async {
    emit(GetOrderHistoryLoadingState());
    try {
      final response = await orderHistoryRepo.getMyOrders();
      emit(GetOrderHistorySuccessState(response));
    } catch (e) {
      emit(GetOrderHistoryErrorState(e.toString()));
    }
  }
}
