import 'package:flutter/material.dart';
import '../models/weather_model.dart';

// Hava durumu bilgilerini (nem, rüzgar, hissedilen sıcaklık) gösteren kart bileşeni.
// 3 sütun şeklinde veriler simge açıklama değer olarak gösterilir.
class WeatherInfoCard extends StatelessWidget {
  final Weather weather; // Dışarıdan gelen hava durumu modeli

  const WeatherInfoCard({required this.weather, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),

      // Kartın görsel düzenlemesi
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      // 3 sütun: Nem, rüzgar, hissedilen sıcaklık
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Nem bilgisi
          _buildColumn(
            Icons.water_drop_outlined,
            "Humidity",
            "${weather.humidity}%",
            Colors.blue,
          ),

          // Rüzgar hızı
          _buildColumn(
            Icons.air,
            "Wind",
            "${weather.windSpeed.toStringAsFixed(1)} m/s",
            Colors.grey,
          ),

          // Hissedilen sıcaklık
          _buildColumn(
            Icons.thermostat,
            "Feels like",
            "${weather.feelsLike.toStringAsFixed(0)}°C",
            Colors.orange,
          ),
        ],
      ),
    );
  }

  // Kart içindeki her veri sütununu oluşturan yardımcı widget.
  // İkon açıklama metni değer bilgisi
  Widget _buildColumn(IconData icon, String label, String value, Color iconColor) {
    return Column(
      children: [
        Icon(icon, size: 24, color: iconColor),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 20, color: Colors.black54),
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
