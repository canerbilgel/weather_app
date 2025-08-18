import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/models/weather_model.dart';

void main() {
  // Testlerde kullanacağımız sahte base URL ve API key
  const baseUrl = 'https://api.example.com';
  const apiKey = 'KEY';

  // Bu test, fetchWeather metodunun 200 (başarılı) cevabı doğru işleyip işlemediğini kontrol eder
  test('fetchWeather → 200 başarılı olursa Weather döner', () async {
    // MockClient ile sahte HTTP isteği tanımlıyoruz
    final mockClient = MockClient((request) async {
      // Doğru endpoint çağrılmış mı kontrol et
      expect(request.url.path, '/weather');

      // 200 durum kodu ile sahte JSON verisi döndür
      return http.Response(jsonEncode({
        "name": "Istanbul",
        "weather": [
          {"main": "Clear", "description": "clear sky", "icon": "01d"}
        ],
        "main": {"temp": 27, "feels_like": 28.2, "humidity": 40},
        "wind": {"speed": 3}
      }), 200, headers: {'content-type': 'application/json'});
    });

    // Servisi sahte client ile başlat
    final service = WeatherService(client: mockClient, baseUrl: baseUrl, apiKey: apiKey);

    // fetchWeather metodunu çağır
    final w = await service.fetchWeather('Istanbul');

    // Dönen veri Weather tipinde mi ve değerler doğru mu kontrol et
    expect(w, isA<Weather>());
    expect(w.main, 'Clear');
    expect(w.temperature, 27.0);
  });

  // Bu test, fetchWeather metodunun 404 (bulunamadı) cevabında hata fırlatıp fırlatmadığını kontrol eder
  test('fetchWeather → 404 olursa Exception fırlatır', () async {
    // MockClient 404 dönecek şekilde ayarlandı
    final mockClient = MockClient((_) async => http.Response('not found', 404));

    // Servisi sahte client ile başlat
    final service = WeatherService(client: mockClient, baseUrl: baseUrl, apiKey: apiKey);

    // fetchWeather çağrıldığında hata fırlatmalı
    expect(() => service.fetchWeather('NoCity'), throwsException);
  });

  // Bu test, fetchForecastByCity metodunun 200 cevabında 4 günlük tahmin listesini doğru döndürdüğünü kontrol eder
  test('fetchForecastByCity → 200 olursa 4 kayıt döner (0,8,16,24)', () async {
    // 25 öğelik sahte forecast listesi oluşturuyoruz (3 saatlik dilimlerle)
    List<Map<String, dynamic>> list = List.generate(25, (i) {
      final dt = DateTime(2024, 1, 1, 0).add(Duration(hours: 3 * i));
      final dtTxt =
          '${dt.year.toString().padLeft(4, '0')}-'
          '${dt.month.toString().padLeft(2, '0')}-'
          '${dt.day.toString().padLeft(2, '0')} '
          '${dt.hour.toString().padLeft(2, '0')}:00:00';

      return {
        "dt": (dt.millisecondsSinceEpoch ~/ 1000),
        "dt_txt": dtTxt,
        "main": {
          "temp": 20 + i.toDouble(),
          "feels_like": 20 + i.toDouble(),
          "humidity": 50
        },
        "weather": [
          {"main": "Clouds", "description": "cloudy", "icon": "04d"}
        ],
        "wind": {"speed": 2}
      };
    });

    // MockClient ile forecast endpoint'ine istek geldiğinde sahte listeyi döndür
    final mockClient = MockClient((request) async {
      expect(request.url.path, '/forecast');
      return http.Response(jsonEncode({"cod": "200", "list": list}), 200,
          headers: {'content-type': 'application/json'});
    });

    // Servisi sahte client ile başlat
    final service = WeatherService(client: mockClient, baseUrl: baseUrl, apiKey: apiKey);

    // Forecast verisini çek
    final items = await service.fetchForecastByCity('Istanbul');

    // 4 öğe dönmeli (0, 8, 16, 24. indexler)
    expect(items.length, 4);
    expect(items[0].temperature, 20.0); // index 0
    expect(items[1].temperature, 28.0); // index 8 -> 20 + 8
    expect(items[2].temperature, 36.0); // index 16
    expect(items[3].temperature, 44.0); // index 24
  });
}
