import 'package:flutter/material.dart';
import 'package:new_app/common/app_colors.dart';

class CategoriesWidget extends StatefulWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoriesWidget({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - _animation.value)),
          child: Opacity(
            opacity: _animation.value,
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: widget.categories.length,
                itemBuilder: (context, index) {
                  final category = widget.categories[index];
                  final isSelected = widget.selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12, left: 4),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      child: ChoiceChip(
                        label: Text(
                          category,
                          style: TextStyle(
                            color: isSelected 
                                ? AppColors.textLight 
                                : AppColors.textPrimary,
                            fontWeight: isSelected 
                                ? FontWeight.bold 
                                : FontWeight.normal,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: AppColors.primary,
                        backgroundColor: AppColors.surface,
                        side: BorderSide(
                          color: isSelected 
                              ? AppColors.primary 
                              : AppColors.greyLight,
                          width: 1,
                        ),
                        elevation: isSelected ? 4 : 1,
                        shadowColor: AppColors.primary.withOpacity(0.3),
                        onSelected: (_) {
                          widget.onCategorySelected(category);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
