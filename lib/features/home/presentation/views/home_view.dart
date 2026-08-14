import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:resto/core/di/di.dart';
import 'package:resto/features/home/presentation/manager/categories/categories_cubit.dart';
import 'package:resto/features/home/presentation/manager/products/products_cubit.dart';
import 'package:resto/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ProductsCubit>()..getProducts()),
        BlocProvider(create: (_) => getIt<CategoriesCubit>()..getCategories()),
      ],
      child: const HomeViewBody(),
    );
  }
}
