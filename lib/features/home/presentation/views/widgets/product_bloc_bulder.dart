import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:gap/gap.dart';
import 'package:resto/core/widgets/custom_text.dart';
import 'package:resto/features/home/presentation/manager/products/products_cubit.dart';
import 'package:resto/features/home/presentation/views/widgets/card_item.dart';
import 'package:resto/features/home/presentation/views/widgets/product_skeleton.dart';

class ProductBlocBuilder extends StatelessWidget {
  const ProductBlocBuilder({super.key, required this.selectedCategoryId});

  final String? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsFailure) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: state.errorMessage ?? 'Something went wrong',
                    size: 14,
                    weight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                  Gap(12.h),
                  TextButton(
                    onPressed: () => context.read<ProductsCubit>().getProducts(
                      categoryId: selectedCategoryId,
                    ),
                    child: const CustomText(
                      text: 'Retry',
                      size: 14,
                      weight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final products = state is ProductsSuccess ? state.products : null;
        final itemCount = products?.length ?? 6;

        return SliverPadding(
          padding: EdgeInsets.only(
            left: 10.w,
            right: 10.w,
            top: 20.h,
            bottom: 120.h,
          ),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              if (products == null) {
                return const ProductSkeleton();
              }
              final product = products[index];
              return CardItem(
                image: product.image ?? '',
                text: product.name ?? '',
                desc: product.description ?? '',
                rate: (product.rating ?? 0).toString(),
              );
            }, childCount: itemCount),
          ),
        );
      },
    );
  }
}
