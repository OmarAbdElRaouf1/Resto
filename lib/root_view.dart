import 'package:flutter/material.dart';
import 'package:glass_bottom_navigation/nav_style.dart';
import 'package:resto/core/theme/app_colors.dart';
import 'package:resto/features/cart/presentation/cart_view.dart';
import 'package:resto/features/home/presentation/views/home_view.dart';
import 'package:resto/features/profile/profile_view.dart';

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> with TickerProviderStateMixin {
  late final List<Widget> screens;

  late final List<AnimationController> iconControllers;

  int currentScreen = 0;

  @override
  void initState() {
    super.initState();

    screens = const [HomeView(), CartView(), Placeholder(), ProfileView()];

    iconControllers = List.generate(
      screens.length,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );

    iconControllers[currentScreen].forward();
  }

  @override
  void dispose() {
    for (final controller in iconControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  void _onTabTapped(int index) {
    if (index == currentScreen) return;

    iconControllers[currentScreen].reverse();

    setState(() {
      currentScreen = index;
    });

    iconControllers[index].forward();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBody: true,

        body: IndexedStack(index: currentScreen, children: screens),

        bottomNavigationBar: GlassBottomBar(
          items: const [
            GlassBarItem(
              icon: Icons.home_rounded,

              label: 'Home',
              nativeSymbolName: 'house.fill',
            ),
            GlassBarItem(
              icon: Icons.shopping_cart_rounded,
              label: 'Cart',
              nativeSymbolName: 'cart.fill',
            ),
            GlassBarItem(
              icon: Icons.history,
              label: 'History',
              nativeSymbolName: 'clock.fill',
            ),
            GlassBarItem(
              icon: Icons.person_rounded,
              label: 'Profile',
              nativeSymbolName: 'person.fill',
            ),
          ],
          currentIndex: currentScreen,
          onTap: _onTabTapped,

          style: const GlassBottomNavStyle(
            widthFactor: 1.0,
            height: 80,
            accent: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
