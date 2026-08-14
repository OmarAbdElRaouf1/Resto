import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:gap/gap.dart';
import 'package:resto/core/theme/app_colors.dart';
import 'package:resto/core/widgets/custom_text.dart';
import 'package:resto/features/home/data/models/products_model.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 280.h,
            backgroundColor: AppColors.primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                product.image ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomText(
                          text: product.name ?? '',
                          size: 22,
                          weight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      _RatingBadge(rating: product.rating ?? 0),
                    ],
                  ),

                  Gap(8.h),

                  CustomText(
                    text: product.category?.name ?? '',
                    size: 13,
                    weight: FontWeight.w400,
                    color: Colors.grey.shade600,
                  ),

                  Gap(16.h),

                  CustomText(
                    text: '\$${product.price ?? 0}',
                    size: 20,
                    weight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),

                  Gap(16.h),

                  if (product.isSpicy == true || product.isAvailable == false)
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Wrap(
                        spacing: 8,
                        children: [
                          if (product.isSpicy == true)
                            const _Tag(label: 'Spicy', color: Colors.red),
                          if (product.isAvailable == false)
                            const _Tag(
                              label: 'Unavailable',
                              color: Colors.grey,
                            ),
                        ],
                      ),
                    ),

                  CustomText(
                    text: 'Description',
                    size: 16,
                    weight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),

                  Gap(8.h),

                  Text(
                    product.description ?? '',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),

                  if (product.ingredients?.isNotEmpty == true) ...[
                    Gap(20.h),
                    CustomText(
                      text: 'Ingredients',
                      size: 16,
                      weight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                    Gap(8.h),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final ingredient in product.ingredients!)
                          _Tag(label: ingredient, color: AppColors.primaryColor),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingBadge extends StatelessWidget {
  const _RatingBadge({required this.rating});

  final int rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.amber.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
          const Gap(4),
          CustomText(
            text: rating.toString(),
            size: 13,
            weight: FontWeight.w600,
            color: Colors.amber.shade900,
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label, required this.color});

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
      child: CustomText(text: label, size: 12, weight: FontWeight.w500, color: color),
    );
  }
}
