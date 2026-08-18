import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:gap/gap.dart';
import 'package:resto/core/theme/app_colors.dart';
import 'package:resto/features/order_history/domain/entities/order_entity.dart';
import 'package:resto/features/order_history/presentation/manager/cubit/order_history_cubit.dart';
import 'package:resto/features/order_history/presentation/views/widgets/empty_order_placeholder.dart';
import 'package:resto/features/order_history/presentation/views/widgets/order_history_card.dart';

class OrdersListView extends StatelessWidget {
  const OrdersListView({super.key, required this.orders});

  final List<OrderEntity> orders;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) return const EmptyOrdersPlaceholder();

    return RefreshIndicator(
      color: AppColors.primaryColor,
      onRefresh: () => context.read<OrderHistoryCubit>().getMyOrders(),
      child: ListView.separated(
        padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
        itemCount: orders.length,
        separatorBuilder: (context, index) => Gap(16.h),
        itemBuilder: (context, index) {
          return OrderHistoryCard(order: orders[index]);
        },
      ),
    );
  }
}
