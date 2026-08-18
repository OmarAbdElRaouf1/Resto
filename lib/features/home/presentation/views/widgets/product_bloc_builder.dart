import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:resto/core/helpers/extensions.dart';
import 'package:resto/core/routing/routes.dart';
import 'package:resto/core/widgets/error_retry_view.dart';
import 'package:resto/features/home/presentation/manager/categories/categories_cubit.dart';
import 'package:resto/features/home/presentation/manager/products/products_cubit.dart';
import 'package:resto/features/home/presentation/views/widgets/product_item.dart';
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
            child: Center(
              child: ErrorRetryView(
                message: state.errorMessage ?? 'Something went wrong',
                onRetry: () {
                  context.read<ProductsCubit>().getProducts(
                    categoryId: selectedCategoryId,
                  );
                  context.read<CategoriesCubit>().getCategories();
                },
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
              childAspectRatio: 0.68,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              if (products == null) {
                return const ProductSkeleton();
              }
              final product = products[index];
              return ProductItem(
                image: product.image ?? '',
                text: product.name ?? '',
                desc: product.description ?? '',
                rate: (product.rating ?? 0).toString(),
                entranceDelay: Duration(milliseconds: 40 * (index % 10)),
                onTap: () => context.pushNamed(
                  Routes.productDetailsView,
                  arguments: product,
                ),
              );
            }, childCount: itemCount),
          ),
        );
      },
    );
  }
}
