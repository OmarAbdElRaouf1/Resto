import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:gap/gap.dart';
import 'package:resto/core/helpers/shared_prefs.dart';
import 'package:resto/core/theme/app_colors.dart';
import 'package:resto/features/home/presentation/manager/products/products_cubit.dart';
import 'package:resto/features/home/presentation/views/widgets/categories_bloc_builder.dart';
import 'package:resto/features/home/presentation/views/widgets/home_app_bar.dart';
import 'package:resto/features/home/presentation/views/widgets/product_bloc_bulder.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  String? selectedCategoryId;

  String userName = 'Guest';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final savedName = await SharedPrefs.getUserName();
    if (!mounted || savedName == null) return;
    setState(() => userName = savedName);
  }

  void _selectCategory(String? categoryId) {
    setState(() => selectedCategoryId = categoryId);
    context.read<ProductsCubit>().getProducts(categoryId: categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color.alphaBlend(
          AppColors.primaryColor.withValues(alpha: 0.1),
          Colors.white,
        ),
        body: CustomScrollView(
          clipBehavior: Clip.none,
          slivers: [
            // Header
            HomeAppBar(
              userName: userName,
              userImage:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvts5aHBstDkR8PigS4RmZkbZy78zpZoSuOw&s',
              searchController: TextEditingController(),
              onSearchChanged: (_) {},
            ),

            SliverToBoxAdapter(child: Gap(3.h)),

            // Categories
            CategoriesBlocBuilder(
              selectedCategoryId: selectedCategoryId,
              selectCategory: _selectCategory,
            ),

            // Products UI
            ProductBlocBuilder(selectedCategoryId: selectedCategoryId),
          ],
        ),
      ),
    );
  }
}
