import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/greeting_header.dart';
import '../components/weather_main_card.dart';
import '../components/weather_info_card.dart';
import '../components/forecast_card.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import '../utils/gradient_helper.dart';

// Ana hava durumu ekranı.
// Bu sayfa şehir bazlı hava durumu verisini API'den çeker, cache'ler ve kullanıcıya gösterir.
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Weather? _weather;
  List<Weather>? _forecast;
  final WeatherService _weatherService = WeatherService();

  // Aynı şehir için tekrar tekrar API çağrısı yapmamak adına cache
  final Map<String, Weather> _weatherCache = {};
  final Map<String, List<Weather>> _forecastCache = {};

  // Günün saatine göre "Good Morning", "Good Afternoon"  mesajı
  String greeting = "";

  // Uygulama ilk açıldığında gösterilecek veri
  @override
  void initState() {
    super.initState();
    fetchWeather("Istanbul");
    setGreeting();
  }

  // Saat bazlı selamlamayı ayarlayan yardımcı fonksiyon
  void setGreeting() {
    final hour = DateTime.now().hour;
    setState(() {
      if (hour >= 5 && hour < 12) {
        greeting = "Good Morning";
      } else if (hour >= 12 && hour < 17) {
        greeting = "Good Afternoon";
      } else if (hour >= 17 && hour < 21) {
        greeting = "Good Evening";
      } else {
        greeting = "Good Night";
      }
    });
  }

  // Şehir adına göre hava durumu ve tahmini verisini çeken fonksiyon
  void fetchWeather(String cityName) async {
    // Eğer daha önce bu şehir için veri alındıysa cache'den getir
    if (_weatherCache.containsKey(cityName) && _forecastCache.containsKey(cityName)) {
      setState(() {
        _weather = _weatherCache[cityName];
        _forecast = _forecastCache[cityName];
      });
      return;
    }

    // API'den veri çekme
    try {
      final data = await _weatherService.fetchWeather(cityName);
      final forecast = await _weatherService.fetchForecastByCity(cityName);

      // Cache'e kaydet
      _weatherCache[cityName] = data;
      _forecastCache[cityName] = forecast;

      setState(() {
        _weather = data;
        _forecast = forecast;
      });
    } catch (e) {
      // Hata durumunda snackbar ile kullanıcıya mesaj göster
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  // Kullanıcının şehir girmesi için dialog gösteren fonksiyon
  void showSearchDialog(BuildContext context) {
    String cityName = '';
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Enter city name"),
          content: TextField(
            decoration: const InputDecoration(hintText: "e.g. Istanbul"),
            onChanged: (value) => cityName = value,
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

  // Sayfanın UI yapısı
  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('EEE, d MMM').format(DateTime.now());

    return Scaffold(
      body: Stack(
        children: [
          // Arka plan gradyanı (null değeri için)
          Container(
            decoration: BoxDecoration(
              gradient: _weather != null
                  ? getGradientByWeather(_weather!.main)
                  : const LinearGradient(
                colors: [Color(0xFFCCE4F6), Color(0xFFE6F0FA)],
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
                  colors: [Color(0xFFFFD54F), Color(0xFFFF8A65)],
                  radius: 1.0,
                ),
              ),
            ),
          ),

          // Sayfa içeriği (üst başlık hava durumu tahminler)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Selamlama ve tarih alanı - şehir arama
                    GreetingHeader(
                      greeting: greeting,
                      formattedDate: formattedDate,
                      onSearchPressed: () => showSearchDialog(context),
                    ),
                    const SizedBox(height: 8),

                    // Eğer hava durumu verisi geldiyse göster
                    if (_weather != null) ...[
                      WeatherMainCard(weather: _weather!),
                      const SizedBox(height: 20),
                      WeatherInfoCard(weather: _weather!),
                      const SizedBox(height: 20),
                      if (_forecast != null)
                        ForecastCard(forecast: _forecast!),
                    ] else
                    // Veri yüklenene kadar gösterilen animasyon
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
