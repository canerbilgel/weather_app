import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/weather_model.dart';
import '../constants/app_strings.dart';
import '../constants/app_colors.dart';

class ForecastCard extends StatelessWidget {
  final List<Weather> forecast;

  const ForecastCard({required this.forecast, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.panelTint.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow05(),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.nextDays,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          for (final day in forecast)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Image.network(
                    '${AppStrings.iconBaseUrl}${day.iconCode}@2x.png',
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(width: 12),

                  Text(
                    '${day.temperature.toStringAsFixed(0)}${AppStrings.tempUnitC}',
                    style: const TextStyle(fontSize: 22),
                  ),
                  const SizedBox(width: 20),

                  Expanded(
                    child: Text(
                      DateFormat(AppStrings.datePatternLong).format(day.date!),
                      style: const TextStyle(fontSize: 18, color: AppColors.textPrimary),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
