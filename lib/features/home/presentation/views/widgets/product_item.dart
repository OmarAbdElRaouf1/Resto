import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:gap/gap.dart';
import 'package:resto/core/theme/app_colors.dart';
import 'package:resto/core/widgets/custom_text.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.image,
    required this.text,
    required this.desc,
    required this.rate,
    required this.heroTag,
    this.onTap,
  });
  final String image, text, desc, rate;
  final Object heroTag;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 500),
        child: Card(
          color: Colors.white,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Image
                  Center(
                    child: Hero(
                      tag: heroTag,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          image,
                          width: 200,
                          height: 140,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  Gap(15.h),

                  /// Details
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: text,
                          weight: FontWeight.w300,
                          size: 18,
                          color: Colors.green.shade900,
                        ),
                        Gap(5),
                        CustomText(
                          text: desc,
                          size: 12,
                          color: AppColors.primaryColor,
                          weight: FontWeight.w300,
                        ),
                        Gap(10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
