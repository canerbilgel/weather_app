import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

// Üst karşılama bileşeni
class GreetingHeader extends StatelessWidget {
  final String greeting;
  final String formattedDate;
  final VoidCallback onSearchPressed;

  const GreetingHeader({
    required this.greeting,
    required this.formattedDate,
    required this.onSearchPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow05(),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Selamlama + arama
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                greeting,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              IconButton(
                tooltip: AppStrings.searchTooltip,
                icon: const Icon(Icons.travel_explore, size: 32, color: AppColors.iconPrimary),
                onPressed: onSearchPressed,
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Tarih
          Text(
            formattedDate,
            style: const TextStyle(fontSize: 16, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
