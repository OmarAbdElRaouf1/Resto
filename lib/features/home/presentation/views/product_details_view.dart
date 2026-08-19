import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:gap/gap.dart';
import 'package:resto/core/functions/app_snack_bar.dart';
import 'package:resto/core/theme/app_colors.dart';
import 'package:resto/core/widgets/custom_button.dart';
import 'package:resto/core/widgets/custom_text.dart';
import 'package:resto/features/cart/presentation/manager/cubit/cart_cubit.dart';
import 'package:resto/features/home/domain/entities/product_entity.dart';
import 'package:resto/features/home/presentation/views/widgets/ingredients_tag.dart';
import 'package:resto/features/home/presentation/views/widgets/product_reviews_section.dart';
import 'package:resto/features/home/presentation/views/widgets/rating_badge.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.product});

  final ProductEntity product;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Quantity selector
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(
                        minWidth: 32.r,
                        minHeight: 32.r,
                      ),
                      icon: Icon(
                        Icons.remove,
                        size: 18.r,
                        color: _quantity > 1
                            ? AppColors.primaryColor
                            : Colors.grey,
                      ),
                      onPressed: _quantity > 1
                          ? () => setState(() => _quantity--)
                          : null,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(
                        '$_quantity',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(
                        minWidth: 32.r,
                        minHeight: 32.r,
                      ),
                      icon: Icon(
                        Icons.add,
                        size: 18.r,
                        color: AppColors.primaryColor,
                      ),
                      onPressed: () => setState(() => _quantity++),
                    ),
                  ],
                ),
              ),

              Gap(12.w),

              // Add to Cart Button
              Expanded(
                child: BlocConsumer<CartCubit, CartState>(
                  listener: (context, state) {
                    if (state is AddItemToCartSuccessState) {
                      showAnimatedSnackbar(
                        context,
                        message:
                            '${product.name ?? 'Item'} added to cart successfully!',
                        type: AnimatedSnackBarType.success,
                      );
                    } else if (state is AddItemToCartErrorState) {
                      showAnimatedSnackbar(
                        context,
                        message: state.error,
                        type: AnimatedSnackBarType.error,
                      );
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state is AddItemToCartLoadingState;

                    return CustomButton(
                      text: isLoading ? 'Adding...' : 'Add to Cart',
                      widget: isLoading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : null,
                      gap: isLoading ? 10 : 0,
                      onTap: isLoading
                          ? null
                          : () {
                              final productId = product.id;
                              if (productId != null && productId.isNotEmpty) {
                                context
                                    .read<CartCubit>()
                                    .addItemToCart(productId, _quantity);
                              } else {
                                showAnimatedSnackbar(
                                  context,
                                  message: 'Product ID is missing',
                                  type: AnimatedSnackBarType.error,
                                );
                              }
                            },
                    );
                  },
                ),
              ),
            ],
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
              background: Image.network(product.image ?? '', fit: BoxFit.cover),
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
                    color: AppColors.lightTextSecondary,
                  ),

                  Gap(16.h),

                  CustomText(
                    text: '${product.price ?? 0} EGP',
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

                  const CustomText(
                    text: 'Description',
                    size: 16,
                    weight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),

                  Gap(8.h),

                  Text(
                    product.description ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.lightTextSecondary,
                    ),
                  ),

                  if (product.ingredients?.isNotEmpty == true) ...[
                    Gap(20.h),
                    const CustomText(
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
