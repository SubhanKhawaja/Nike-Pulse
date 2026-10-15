import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/product/category_chip.dart';

class CatalogFilterBar extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;
  final int resultCount;

  const CatalogFilterBar({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.resultCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 44,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: AppConstants.categories.length,
            itemBuilder: (context, index) {
              final cat = AppConstants.categories[index];
              return CategoryChip(
                label: cat,
                isSelected: cat == selectedCategory,
                onTap: () => onCategoryChanged(cat),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$resultCount Results',
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
              Row(
                children: [
                  Icon(Icons.swap_vert_rounded, size: 16, color: Theme.of(context).colorScheme.secondary),
                  const SizedBox(width: 4),
                  Text(
                    'Sort by: Featured',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
