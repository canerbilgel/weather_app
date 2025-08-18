import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../constants/app_strings.dart';
import '../constants/app_colors.dart';

// Nem, rüzgar, hissedilen sıcaklığı gösterir.
class WeatherInfoCard extends StatelessWidget {
  final Weather weather;

  const WeatherInfoCard({required this.weather, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),

      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow05(),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildColumn(
            Icons.water_drop_outlined,
            AppStrings.humidity,
            "${weather.humidity}%",
            AppColors.iconBlue,
          ),
          _buildColumn(
            Icons.air,
            AppStrings.wind,
            "${weather.windSpeed.toStringAsFixed(1)} ${AppStrings.windUnitMs}",
            AppColors.iconGrey,
          ),
          _buildColumn(
            Icons.thermostat,
            AppStrings.feelsLike,
            "${weather.feelsLike.toStringAsFixed(0)}${AppStrings.tempUnitC}",
            AppColors.iconOrange,
          ),
        ],
      ),
    );
  }

  Widget _buildColumn(IconData icon, String label, String value, Color iconColor) {
    return Column(
      children: [
        Icon(icon, size: 24, color: iconColor),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 20, color: AppColors.textMuted),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

