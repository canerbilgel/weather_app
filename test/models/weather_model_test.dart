import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/models/weather_model.dart';

void main() {
  // Bu test, fromJson metodu ile normal JSON verisinin doğru okunup okunmadığını kontrol eder
  test('Weather.fromJson → temel alanlar doğru parse edilir', () {
    // API'den gelmiş gibi örnek JSON verisi
    final map = {
      "name": "Istanbul",
      "weather": [
        {"main": "Clear", "description": "clear sky", "icon": "01d"}
      ],
      "main": {"temp": 27, "feels_like": 28.2, "humidity": 40},
      "wind": {"speed": 3}
    };

    // JSON verisini Weather nesnesine çevir
    final w = Weather.fromJson(map);

    // Beklediğimiz değerleri tek tek kontrol et
    expect(w.cityName, 'Istanbul');
    expect(w.main, 'Clear');
    expect(w.description, 'clear sky');
    expect(w.iconCode, '01d');
    expect(w.temperature, 27.0);
    expect(w.feelsLike, 28.2);
    expect(w.humidity, 40);
    expect(w.windSpeed, 3.0);
    expect(w.date, isNull); // Burada tarih bilgisi yok
  });

  // Bu test, fromJson metodunun string JSON ile de çalışıp çalışmadığını kontrol eder
  test('Weather.fromJson → JSON stringten de çalışır', () {
    // JSON verisini string olarak yazdık
    const s = '''
    {"name":"Ankara",
     "weather":[{"main":"Clouds","description":"broken clouds","icon":"04d"}],
     "main":{"temp":22.5,"feels_like":22.9,"humidity":55},
     "wind":{"speed":5.4}}
    ''';

    // String JSON'u önce decode edip sonra Weather nesnesine çevir
    final w = Weather.fromJson(json.decode(s));

    // Bazı alanların doğru olup olmadığını kontrol et
    expect(w.cityName, 'Ankara');
    expect(w.main, 'Clouds');
    expect(w.temperature, 22.5);
  });

  // Bu test, fromForecastJson metodunun tahmin (forecast) verisini doğru okuyup okumadığını kontrol eder
  test('Weather.fromForecastJson → dt_txt tarihini ve alanları okur', () {
    // Tahmin verisi örneği
    final map = {
      "dt_txt": "2024-03-09 12:00:00",
      "main": {"temp": 20, "feels_like": 20.3, "humidity": 60},
      "weather": [{"main": "Rain", "description": "light rain", "icon": "10d"}],
      "wind": {"speed": 2}
    };

    // Forecast JSON verisini Weather nesnesine çevir
    final w = Weather.fromForecastJson(map);

    // Alanların doğru olup olmadığını kontrol et
    expect(w.cityName, isNull); // Forecast verisinde cityName yok
    expect(w.main, 'Rain');
    expect(w.description, 'light rain');
    expect(w.iconCode, '10d');
    expect(w.temperature, 20.0);
    expect(w.feelsLike, 20.3);
    expect(w.humidity, 60);
    expect(w.windSpeed, 2.0);
    expect(w.date, DateTime.parse("2024-03-09 12:00:00")); // Tarih stringten DateTime'a çevrilir
  });
}
