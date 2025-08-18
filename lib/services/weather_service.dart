import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/weather_model.dart';

class WeatherService {
  final http.Client _client;
  final String _apiKey;
  final String _baseUrl;

  WeatherService({
    http.Client? client,
    String? apiKey,
    String? baseUrl,
  })  : _client = client ?? http.Client(),
        _apiKey = apiKey ?? (dotenv.env['OPENWEATHER_API_KEY'] ?? ''),
        _baseUrl = baseUrl ?? (dotenv.env['OPENWEATHER_BASE_URL'] ?? '');

  // Anlık hava durumu
  Future<Weather> fetchWeather(String cityName) async {
    final url = Uri.parse(
      '$_baseUrl/weather?q=$cityName&appid=$_apiKey&units=metric&lang=en',
    );

    final response = await _client.get(url);

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

  // 4 günlük tahmin
  Future<List<Weather>> fetchForecastByCity(String cityName) async {
    final url = Uri.parse(
      '$_baseUrl/forecast?q=$cityName&appid=$_apiKey&units=metric&lang=en',
    );

    final response = await _client.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List list = data['list'];

      // 0, 8, 16, 24. indexleri al (3 saatlik veriden günde 8 adet var)
      final indices = [0, 8, 16, 24].where((i) => i < list.length).toList();
      return indices
          .map<Weather>((i) => Weather.fromForecastJson(list[i]))
          .toList();
    } else if (response.statusCode == 401) {
      throw Exception('API anahtarı geçersiz.');
    } else if (response.statusCode == 404) {
      throw Exception('Şehir bulunamadı: $cityName');
    } else {
      throw Exception('Forecast alınamadı: ${response.statusCode}');
    }
  }

  void dispose() {
    _client.close();
  }
}
