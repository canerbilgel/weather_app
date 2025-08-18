import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/greeting_header.dart';
import '../components/weather_main_card.dart';
import '../components/weather_info_card.dart';
import '../components/forecast_card.dart';

import '../models/weather_model.dart';
import '../services/weather_service.dart';
import '../utils/gradient_helper.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/weather_type.dart';

/// Ana hava durumu ekranı.
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Weather? _weather;
  List<Weather>? _forecast;
  final WeatherService _weatherService = WeatherService();

  final Map<String, Weather> _weatherCache = {};
  final Map<String, List<Weather>> _forecastCache = {};

  String greeting = "";

  @override
  void initState() {
    super.initState();
    fetchWeather(AppStrings.defaultCity);
    setGreeting();
  }

  void setGreeting() {
    final hour = DateTime.now().hour;
    setState(() {
      if (hour >= 5 && hour < 12) {
        greeting = AppStrings.goodMorning;
      } else if (hour >= 12 && hour < 17) {
        greeting = AppStrings.goodAfternoon;
      } else if (hour >= 17 && hour < 21) {
        greeting = AppStrings.goodEvening;
      } else {
        greeting = AppStrings.goodNight;
      }
    });
  }

  void fetchWeather(String cityName) async {
    if (_weatherCache.containsKey(cityName) &&
        _forecastCache.containsKey(cityName)) {
      setState(() {
        _weather = _weatherCache[cityName];
        _forecast = _forecastCache[cityName];
      });
      return;
    }

    try {
      final data = await _weatherService.fetchWeather(cityName);
      final forecast = await _weatherService.fetchForecastByCity(cityName);

      _weatherCache[cityName] = data;
      _forecastCache[cityName] = forecast;

      setState(() {
        _weather = data;
        _forecast = forecast;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${AppStrings.errorPrefix}$e")),
      );
    }
  }

  void showSearchDialog(BuildContext context) {
    String cityName = '';
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text(AppStrings.enterCityTitle),
          content: TextField(
            decoration: const InputDecoration(hintText: AppStrings.enterCityHint),
            onChanged: (value) => cityName = value,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                fetchWeather(cityName.trim());
              },
              child: const Text(AppStrings.search),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
    DateFormat(AppStrings.datePattern).format(DateTime.now());

    return Scaffold(
      body: Stack(
        children: [
          // Arka plan gradyanı (null durumda fallback)
          Container(
            decoration: BoxDecoration(
              gradient: _weather != null
                  ? getGradientByWeather(
                weatherTypeFromMain(_weather!.main),
              )
                  : const LinearGradient(
                colors: [AppColors.bgLight1, AppColors.bgLight2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Güneş efekti
          Positioned(
            top: 300,
            right: -150,
            child: Container(
              width: 350,
              height: 350,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [AppColors.sunOuter, AppColors.sunInner],
                  radius: 1.0,
                ),
              ),
            ),
          ),

          // Sayfa içeriği
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GreetingHeader(
                      greeting: greeting,
                      formattedDate: formattedDate,
                      onSearchPressed: () => showSearchDialog(context),
                    ),
                    const SizedBox(height: 8),

                    if (_weather != null) ...[
                      WeatherMainCard(weather: _weather!),
                      const SizedBox(height: 20),
                      WeatherInfoCard(weather: _weather!),
                      const SizedBox(height: 20),
                      if (_forecast != null) ForecastCard(forecast: _forecast!),
                    ] else
                      const Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
