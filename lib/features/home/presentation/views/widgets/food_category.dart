import 'package:flutter/material.dart';
import 'package:resto/core/theme/app_colors.dart';

/// One chip in the categories row. [id] is what gets sent to the API
/// (null for "All"), [name] is what the user sees.
class CategoryItem {
  const CategoryItem({required this.id, required this.name});
  final String? id;
  final String name;
}

class FoodCategory extends StatelessWidget {
  const FoodCategory({
    super.key,
    required this.categories,
    required this.selectedId,
    required this.onCategoryTap,
  });

  final List<CategoryItem> categories;
  final String? selectedId;
  final ValueChanged<String?> onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((item) {
          final isSelected = item.id == selectedId;
          return GestureDetector(
            onTap: () => onCategoryTap(item.id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                color: isSelected
                    ? AppColors.primaryColor
                    : const Color(0xffF3F4F6),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? Colors.white
                      : AppColors.lightTextSecondary,
                ),
                child: Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
