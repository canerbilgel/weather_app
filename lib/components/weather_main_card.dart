import 'package:flutter/material.dart';
import '../models/weather_model.dart';

// Ana hava durumu kartı.
// Şehir adı, hava durumu ikonu, sıcaklık ve açıklama gibi temel bilgileri gösterir.
// Uygulamanın en üstteki görsel odak noktasıdır.
class WeatherMainCard extends StatelessWidget {
  final Weather weather; // Dışarıdan gelen hava durumu modeli

  const WeatherMainCard({required this.weather, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //  Şehir adı
        Text(
          weather.cityName ?? '',
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 2),

        //  Hava durumu ikonu
        Image.network(
          'https://openweathermap.org/img/wn/${weather.iconCode}@2x.png',
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),

        const SizedBox(height: 1),

        // Sıcaklık değeri
        Text(
          "${weather.temperature.toStringAsFixed(0)}°C",
          style: const TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 5),

        // Açıklama
        Text(
          weather.description[0].toUpperCase() + weather.description.substring(1),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
