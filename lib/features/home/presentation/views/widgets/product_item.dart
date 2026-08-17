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
      borderRadius: BorderRadius.circular(20.r),
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.zero,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20.r),
          child: Padding(
            padding: EdgeInsets.all(6.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Image
                Expanded(
                  child: Center(
                    child: Hero(
                      tag: heroTag,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Image.network(
                          image,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          cacheWidth: 300,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.broken_image,
                                  size: 36.r, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                Gap(8.h),

                /// Details
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: text,
                        weight: FontWeight.w600,
                        size: 15.sp,
                        maxLines: 1,
                        color: Colors.green.shade900,
                      ),
                      Gap(4.h),
                      CustomText(
                        text: desc,
                        size: 11.sp,
                        maxLines: 2,
                        color: AppColors.primaryColor,
                        weight: FontWeight.w300,
                      ),
                      Gap(4.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
