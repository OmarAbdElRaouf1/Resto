import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:gap/gap.dart';
import 'package:resto/core/theme/app_colors.dart';
import 'package:resto/core/widgets/custom_button.dart';
import 'package:resto/core/widgets/custom_text.dart';
import 'package:resto/features/home/domain/entities/product_entity.dart';
import 'package:resto/features/home/presentation/views/widgets/ingridents_tag.dart';
import 'package:resto/features/home/presentation/views/widgets/product_reviews_section.dart';
import 'package:resto/features/home/presentation/views/widgets/rating_badge.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
          child: CustomButton(
            text: 'Add to Cart',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.name ?? 'Item'} added to cart'),
                ),
              );
            },
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 300.h,
            backgroundColor: AppColors.primaryColor,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: product.id ?? product.image ?? '',
                child: Image.network(product.image ?? '', fit: BoxFit.cover),
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
                          size: 22.sp,
                          weight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      RatingBadge(rating: product.rating ?? 0),
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
                            const Tag(label: 'Spicy', color: Colors.red),
                          if (product.isAvailable == false)
                            const Tag(label: 'Unavailable', color: Colors.grey),
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
                          Tag(label: ingredient, color: AppColors.primaryColor),
                      ],
                    ),
                  ],

                  Gap(24.h),

                  const ProductReviewsSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
