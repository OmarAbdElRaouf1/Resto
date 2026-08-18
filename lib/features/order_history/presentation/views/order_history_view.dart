import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto/core/di/di.dart';
import 'package:resto/features/order_history/presentation/manager/cubit/order_history_cubit.dart';
import 'package:resto/features/order_history/presentation/views/widgets/order_history_view_body.dart';

class OrderHistoryView extends StatefulWidget {
  const OrderHistoryView({super.key});

  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {
  @override
  void initState() {
    super.initState();
    getIt<OrderHistoryCubit>().getMyOrders();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<OrderHistoryCubit>(),
      child: const OrderHistoryViewBody(),
    );
  }
}
