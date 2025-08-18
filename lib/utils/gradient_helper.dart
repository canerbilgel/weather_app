import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/weather_type.dart';

/// Hava durumuna göre uygun LinearGradient döner.
/// Renkler AppColors'tan alınır.
LinearGradient getGradientByWeather(WeatherType type) {
  switch (type) {
    case WeatherType.clear:
      return const LinearGradient(
        colors: [AppColors.clear1, AppColors.clear2],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case WeatherType.clouds:
      return const LinearGradient(
        colors: [AppColors.clouds1, AppColors.clouds2],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case WeatherType.rain:
    case WeatherType.drizzle:
      return const LinearGradient(
        colors: [AppColors.rain1, AppColors.rain2],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case WeatherType.thunderstorm:
      return const LinearGradient(
        colors: [AppColors.thunderstorm1, AppColors.thunderstorm2],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case WeatherType.snow:
      return const LinearGradient(
        colors: [AppColors.snow1, AppColors.snow2],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case WeatherType.mist:
    case WeatherType.fog:
    case WeatherType.haze:
      return const LinearGradient(
        colors: [AppColors.mist1, AppColors.mist2],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case WeatherType.smoke:
    case WeatherType.dust:
    case WeatherType.sand:
    case WeatherType.ash:
      return const LinearGradient(
        colors: [AppColors.smoke1, AppColors.smoke2],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case WeatherType.squall:
      return const LinearGradient(
        colors: [AppColors.squall1, AppColors.squall2],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case WeatherType.tornado:
      return const LinearGradient(
        colors: [AppColors.tornado1, AppColors.tornado2],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case WeatherType.unknown:
      return const LinearGradient(
        colors: [AppColors.default1, AppColors.default2],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
  }
}
