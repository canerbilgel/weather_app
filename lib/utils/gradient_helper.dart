import 'package:flutter/material.dart';

// Hava durumuna göre değişen arka plan fonksiyonu
LinearGradient getGradientByWeather(String weatherMain) {
  switch (weatherMain.toLowerCase()) {
    case 'clear':
      return const LinearGradient(
        colors: [Color(0xFFfceabb), Color(0xFFf8b500)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case 'clouds':
      return const LinearGradient(
        colors: [Color(0xFFbdc3c7), Color(0xFF2c3e50)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case 'rain':
    case 'drizzle':
      return const LinearGradient(
        colors: [Color(0xFF4b79a1), Color(0xFF283e51)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case 'thunderstorm':
      return const LinearGradient(
        colors: [Color(0xFF141E30), Color(0xFF243B55)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case 'snow':
      return const LinearGradient(
        colors: [Color(0xFF83a4d4), Color(0xFFb6fbff)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case 'mist':
    case 'fog':
    case 'haze':
      return const LinearGradient(
        colors: [Color(0xFFcfd9df), Color(0xFFe2ebf0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case 'smoke':
    case 'dust':
    case 'sand':
    case 'ash':
      return const LinearGradient(
        colors: [Color(0xFFb79891), Color(0xFF94716b)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case 'squall':
      return const LinearGradient(
        colors: [Color(0xFF485563), Color(0xFF29323c)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case 'tornado':
      return const LinearGradient(
        colors: [Color(0xFF3a3a3a), Color(0xFF000000)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    default:
      return const LinearGradient(
        colors: [Color(0xFFd7d2cc), Color(0xFF304352)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
  }
}