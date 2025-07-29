import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/weather_model.dart';

class WeatherService {
  final String? _apiKey = dotenv.env['OPENWEATHER_API_KEY'];
  final String? _baseUrl = dotenv.env['OPENWEATHER_BASE_URL'];

  // Anlık hava durumu
  Future<Weather> fetchWeather(String cityName) async {
    final url = Uri.parse(
      '$_baseUrl/weather?q=$cityName&appid=$_apiKey&units=metric&lang=en',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else if (response.statusCode == 401) {
      throw Exception('API anahtarı geçersiz.');
    } else if (response.statusCode == 404) {
      throw Exception('Şehir bulunamadı: $cityName');
    } else {
      throw Exception('Hata kodu: ${response.statusCode}');
    }
  }

  // 4 günlük tahmini veri
  Future<List<Weather>> fetchForecastByCity(String cityName) async {
    final url = Uri.parse(
      '$_baseUrl/forecast?q=$cityName&appid=$_apiKey&units=metric&lang=en',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List list = data['list'];

      // Günde 8 veri geliyor, biz her 24 saatte bir olanları alıyoruz
      final filtered = [list[0], list[8], list[16], list[24]];

      return filtered.map((item) => Weather.fromForecastJson(item)).toList();
    } else {
      throw Exception('Forecast alınamadı: ${response.statusCode}');
    }
  }
}