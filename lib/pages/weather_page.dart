import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Weather? _weather;
  final WeatherService _weatherService = WeatherService();

  @override
  void initState() {
    super.initState();
  }

  // API anroid stuidoda direk commit ve psubölümü
  void fetchWeather(String cityName) async {
    try {
      final data = await _weatherService.fetchWeather(cityName);
      setState(() {
        _weather = data;
      });
    } catch (e) {
      debugPrint("Hava durumu alınamadı: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hata: $e")),
      );
    }
  }

  void showSearchDialog(BuildContext context) {
    String cityName = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter city name"),
          content: TextField(
            decoration: const InputDecoration(hintText: "e.g. Istanbul"),
            onChanged: (value) {
              cityName = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                fetchWeather(cityName);
              },
              child: const Text("Search"),
            ),
          ],
        );
      },
    );
  }

  // Bugünün Tarihini aldığım yer
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('EEE, d MMM').format(DateTime.now());

    return Scaffold(
      body: Stack(
        children: [
          // Arka plan ayarı
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFCCE4F6), Color(0xFFE6F0FA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          //  Güneş efektini kullandığım yer
          Positioned(
            top: 300,
            right: -150,
            child: Container(
              width: 350,
              height: 350,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0xFFFFD54F), Color(0xFFFF8A65)],
                  radius: 1.0,
                ),
              ),
            ),
          ),

          // İçerik kısmı
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Üst Şerit ayarlama kısmı
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Good Morning",
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                            ),
                            IconButton(
                              icon: const Icon(Icons.travel_explore, size: 32, color: Colors.black87),
                              onPressed: () => showSearchDialog(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          formattedDate,
                          style: const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Hava Durumu Verisinin olduğu kısım
                  _weather != null
                      ? Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              _weather!.cityName,
                              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 2),
                            // İkon kodları
                            Image.network(
                              'https://openweathermap.org/img/wn/${_weather!.iconCode}@2x.png',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 1),
                            //
                            //  Sıcaklık
                            Text(
                              "${_weather!.temperature.toStringAsFixed(0)}°C",
                              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 5),

                            // Açıklama
                            Text(
                              _weather!.description[0].toUpperCase() +
                                  _weather!.description.substring(1),
                              style: const TextStyle(fontSize: 20, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Bilgi Kartları (Humidity, Wind Speed)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                        margin: const EdgeInsets.symmetric(horizontal: 12),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            // Humidity
                            Column(
                              children: [
                                const Icon(Icons.water_drop_outlined, size: 24, color: Colors.blue),
                                const SizedBox(height: 6),
                                const Text("Humidity", style: TextStyle(fontSize: 20, color: Colors.black54)),
                                const SizedBox(height: 2),
                                Text("${_weather!.humidity}%", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ],
                            ),

                            // Wind Speed
                            Column(
                              children: [
                                const Icon(Icons.air, size: 24, color: Colors.grey),
                                const SizedBox(height: 6),
                                const Text("Wind", style: TextStyle(fontSize: 20, color: Colors.black54)),
                                const SizedBox(height: 2),
                                Text("${_weather!.windSpeed.toStringAsFixed(1)} m/s", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                      : const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
