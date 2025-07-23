import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/weather_model.dart';

class WeatherService {
  final String? _apiKey = dotenv.env['OPENWEATHER_API_KEY'];
  final String? _baseUrl = dotenv.env['OPENWEATHER_BASE_URL'];

  Future<Weather> fetchWeather(String cityName) async {
    final url = Uri.parse(
      '$_baseUrl/weather?q=$cityName&appid=$_apiKey&units=metric&lang=en',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else if (response.statusCode == 401) {
      throw Exception('API anahtarı geçersiz veya yetki hatası.');
    } else if (response.statusCode == 404) {
      throw Exception('Şehir bulunamadı: $cityName');
    } else {
      throw Exception(
        'Hava durumu alınamadı (HTTP ${response.statusCode}): ${response.reasonPhrase}',
      );
    }
  }
}
