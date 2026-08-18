import 'package:resto/features/order_history/domain/entities/order_item_entity.dart';

const _months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

String formatOrderDate(DateTime? date) {
  if (date == null) return '';

  final local = date.toLocal();
  final now = DateTime.now();
  final isToday =
      local.year == now.year &&
      local.month == now.month &&
      local.day == now.day;

  final hour12 = local.hour % 12 == 0 ? 12 : local.hour % 12;
  final minute = local.minute.toString().padLeft(2, '0');
  final period = local.hour >= 12 ? 'PM' : 'AM';
  final time = '$hour12:$minute $period';

  if (isToday) return 'Today, $time';
  return '${_months[local.month - 1]} ${local.day}, $time';
}

int orderItemsQuantity(List<OrderItemEntity>? items) {
  if (items == null || items.isEmpty) return 0;
  return items.fold<int>(0, (sum, item) => sum + (item.quantity ?? 0));
}

String orderItemsSummary(List<OrderItemEntity>? items) {
  if (items == null || items.isEmpty) return 'No items';
  return items
      .map((item) => '${item.quantity ?? 0}x ${item.name ?? 'Item'}')
      .join(', ');
}

String shortOrderId(String? id) {
  if (id == null || id.isEmpty) return '------';
  return id.length <= 6 ? id : id.substring(id.length - 6);
}
