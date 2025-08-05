import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/weather_model.dart';

// Tahmin kartı bileşeni.
// Bu widget, gelecek günlere ait hava durumu tahminlerini liste olarak gösterir.
// Her satırda: hava durumu ikonu, sıcaklık ve tarih bilgisi yer alır.
class ForecastCard extends StatelessWidget {
  final List<Weather> forecast;

  const ForecastCard({required this.forecast, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(16),

      // Arka plan görünümü
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),

      // İçerik: Başlık tahmin listesi
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık
          const Text(
            "Next days",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // Tahmin verilerinin her biri için satır
          for (var day in forecast)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  // Hava durumu ikonu
                  Image.network(
                    'https://openweathermap.org/img/wn/${day.iconCode}@2x.png',
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(width: 12),

                  // Sıcaklık
                  Text(
                    "${day.temperature.toStringAsFixed(0)}°",
                    style: const TextStyle(fontSize: 22),
                  ),
                  const SizedBox(width: 20),

                  // Tarih bilgisi
                  Expanded(
                    child: Text(
                      DateFormat('EEEE, d MMM').format(day.date!),
                      style: const TextStyle(fontSize: 18, color: Colors.black87),
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
