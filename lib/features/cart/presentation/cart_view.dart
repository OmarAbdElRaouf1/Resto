import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:gap/gap.dart';
import 'package:resto/core/di/di.dart';
import 'package:resto/core/functions/app_snack_bar.dart';
import 'package:resto/core/theme/app_colors.dart';
import 'package:resto/features/cart/domain/entities/cart_entity.dart';
import 'package:resto/features/cart/presentation/manager/cubit/cart_cubit.dart';
import 'package:resto/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:resto/features/cart/presentation/widgets/cart_skeleton.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<CartCubit>(),
      child: const CartViewBody(),
    );
  }
}

class CartViewBody extends StatefulWidget {
  const CartViewBody({super.key});

  @override
  State<CartViewBody> createState() => _CartViewBodyState();
}

class _CartViewBodyState extends State<CartViewBody> {
  CartEntity? _currentCart;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CartCubit>();
    _currentCart = cubit.currentCart;
    cubit.getMyCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(
        AppColors.primaryColor.withValues(alpha: 0.05),
        Colors.white,
      ),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Cart',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is GetCartSuccessState) {
            _currentCart = state.cart;
          } else if (state is UpdateCartItemSuccessState) {
            _currentCart = state.cart;
          } else if (state is RemoveItemFromCartSuccessState) {
            _currentCart = state.cart;
          } else if (state is AddItemToCartSuccessState) {
            _currentCart = state.cart;
          } else if (state is UpdateCartItemErrorState) {
            showAnimatedSnackbar(
              context,
              message: state.error,
              type: AnimatedSnackBarType.error,
            );
          } else if (state is RemoveItemFromCartErrorState) {
            showAnimatedSnackbar(
              context,
              message: state.error,
              type: AnimatedSnackBarType.error,
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
          if (state is GetCartLoadingState && _currentCart == null) {
            return const CartSkeleton();
          }

          if (state is GetCartErrorState && _currentCart == null) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 64.r,
                      color: Colors.red.shade400,
                    ),
                    Gap(16.h),
                    Text(
                      'Failed to load cart',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Gap(8.h),
                    Text(
                      state.error,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Gap(24.h),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<CartCubit>().getMyCart();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 12.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          CartEntity? cart = _currentCart;
          if (state is GetCartSuccessState) {
            cart = state.cart;
            _currentCart = state.cart;
          } else if (state is UpdateCartItemSuccessState) {
            cart = state.cart;
            _currentCart = state.cart;
          } else if (state is RemoveItemFromCartSuccessState) {
            cart = state.cart;
            _currentCart = state.cart;
          } else if (state is AddItemToCartSuccessState) {
            cart = state.cart;
            _currentCart = state.cart;
          }

          final items = cart?.items ?? [];

          if (items.isEmpty && state is! GetCartLoadingState) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(32.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(24.r),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        size: 72.r,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Gap(20.h),
                    Text(
                      'Your Cart is Empty',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Gap(8.h),
                    Text(
                      'Explore our delicious menu and add food to your cart!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Gap(24.h),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<CartCubit>().getMyCart();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 12.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        elevation: 0,
                      ),
                      icon: const Icon(Icons.refresh_rounded, size: 18),
                      label: Text(
                        'Refresh Cart',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // Calculate total price
          final totalPrice = items.fold<num>(
            0,
            (sum, item) =>
                sum +
                ((item.price ?? item.product?.price ?? 0) *
                    (item.quantity ?? 1)),
          );

          final isActionLoading =
              state is UpdateCartItemLoadingState ||
              state is RemoveItemFromCartLoadingState;

          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      color: AppColors.primaryColor,
                      onRefresh: () => context.read<CartCubit>().getMyCart(),
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                        itemCount: items.length,
                        separatorBuilder: (context, index) => Gap(12.h),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final product = item.product;
                          final targetId =
                              (item.id != null && item.id!.isNotEmpty)
                              ? item.id!
                              : (item.productId ?? product?.id ?? '');
                          final currentQty = item.quantity ?? 1;

                          return CartItemCard(
                            title: product?.name ?? 'Food Item',
                            subtitle: product?.description ?? '',
                            imageUrl: product?.image ?? '',
                            price: item.price ?? product?.price,
                            quantity: currentQty,
                            onIncrease: () {
                              if (targetId.isNotEmpty) {
                                context.read<CartCubit>().updateCartItem(
                                  targetId,
                                  currentQty + 1,
                                );
                              }
                            },
                            onDecrease: () {
                              if (targetId.isNotEmpty && currentQty > 1) {
                                context.read<CartCubit>().updateCartItem(
                                  targetId,
                                  currentQty - 1,
                                );
                              }
                            },
                            onRemove: () {
                              if (targetId.isNotEmpty) {
                                context.read<CartCubit>().removeItemFromCart(
                                  targetId,
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),

                  // Bottom Total and Checkout Bar
                  _buildCheckoutBar(context, items.length, totalPrice),
                ],
              ),

              if (isActionLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.white.withValues(alpha: 0.35),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCheckoutBar(
    BuildContext context,
    int itemCount,
    num totalPrice,
  ) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 100.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total ($itemCount items)',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
              ),
              Gap(4.h),
              Text(
                '$totalPrice EGP',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              showAnimatedSnackbar(
                context,
                message: 'Checkout completed successfully!',
                type: AnimatedSnackBarType.success,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              elevation: 0,
            ),
            child: Text(
              'Checkout',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
