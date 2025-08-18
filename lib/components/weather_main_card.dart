import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../constants/app_strings.dart';
import '../constants/app_colors.dart';

class WeatherMainCard extends StatelessWidget {
  final Weather weather;

  const WeatherMainCard({required this.weather, super.key});

  String _capitalizeSafe(String? s) {
    if (s == null || s.isEmpty) return "";
    return s[0].toUpperCase() + s.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final city = weather.cityName ?? '';
    final desc = _capitalizeSafe(weather.description);
    // iconCode non-nullable, bu yüzden ?? kullanma
    final icon = weather.iconCode;

    return Column(
      children: [
        // Şehir adı
        Text(
          city,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 2),

        // Hava durumu ikonu
        Image.network(
          '${AppStrings.iconBaseUrl}$icon@2x.png',
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),

        const SizedBox(height: 1),

        // Sıcaklık
        Text(
          '${weather.temperature.toStringAsFixed(0)}${AppStrings.tempUnitC}',
          style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w600),
        ),

        const SizedBox(height: 5),

        // Açıklama
        Text(
          desc,
          style: const TextStyle(fontSize: 20, color: AppColors.textMuted),
        ),
      ],
    );
  }
}
