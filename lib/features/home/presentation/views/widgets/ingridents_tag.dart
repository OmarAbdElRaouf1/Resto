import 'package:flutter/material.dart';
import 'package:resto/core/widgets/custom_text.dart';

class Tag extends StatelessWidget {
  const Tag({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: CustomText(
        text: label,
        size: 12,
        weight: FontWeight.w500,
        color: color,
      ),
    );
  }
}
