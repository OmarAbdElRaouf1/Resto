import 'package:flutter/material.dart';
import 'package:resto/core/theme/app_colors.dart';
import 'package:resto/core/widgets/custom_text.dart';

extension StrikeThroughText on CustomText {
  Widget withStrikeThrough(bool enabled) {
    if (!enabled) return this;
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        this,
        Positioned(
          left: 0,
          right: 0,
          child: Divider(color: color ?? AppColors.lightTextMuted, height: 1),
        ),
      ],
    );
  }
}
