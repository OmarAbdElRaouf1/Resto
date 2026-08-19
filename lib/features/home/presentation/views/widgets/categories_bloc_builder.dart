import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:resto/features/home/presentation/manager/categories/categories_cubit.dart';
import 'package:resto/features/home/presentation/views/widgets/food_category.dart';

class CategoriesBlocBuilder extends StatelessWidget {
  const CategoriesBlocBuilder({
    super.key,
    this.selectedCategoryId,
    required this.selectCategory,
  });
  final String? selectedCategoryId;
  final void Function(String?) selectCategory;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        final categories = [
          if (state is CategoriesSuccess)
            for (final category in state.categories)
              CategoryItem(id: category.id, name: category.name ?? ''),
        ];

        return SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: 10.h, left: 15.w, right: 15.w),
            child: FoodCategory(
              categories: categories,
              selectedId: selectedCategoryId,
              onCategoryTap: selectCategory,
            ),
          ),
        );
      },
    );
  }
}
