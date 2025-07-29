import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
// import '../pages/rainy_page.dart';

class WeatherPage extends StatefulWidget { // StatefulWidget: Değişken veri ile çalışacağımız bir ekran bileşeni (hava durumu değiştiğinde ekran güncellencek)
  const WeatherPage({super.key}); // bu widget başka yerden çağrılması için kullanılır ve parametre alacaksan örneğin WeatherPage(city: "Ankara")) kullanılır const: yapı

  @override // Bu satır, üst sınıftan gelen bir metodu yeniden tanımladığımızı (override ettiğimizi) belirtir
  State<WeatherPage> createState() => _WeatherPageState(); // createState: Widget'a ait 'State' nesnesini oluşturur, yani bu widget'ın durumunu '_WeatherPageState' sınıfı yönetecek
}

//
class _WeatherPageState extends State<WeatherPage> { // Asıl ekran mantığı burada yazılır. '_WeatherPageState', WeatherPage widget'ının state (durum) sınıfıdır.
  Weather? _weather; // API'den gelen hava durumu verilerini saklamak için kullanılan nullable değişken
  List<Weather>? _forecast; // _forecast: Tahmini hava durumu
  final WeatherService _weatherService = WeatherService(); // OpenWeather API’den veri çekmek için kullanılan servis sınıfı.

  @override
  void initState() { // initState metodunu override ediyoruz, yani Widget ilk yüklendiğinde çalışacak kodları buraya yazacağız
    super.initState();
    fetchWeather("Istanbul") ; // Üst sınıfın initState metodunu çağırıyoruz.
  }

  void fetchWeather(String cityName) async { // Şehir adına göre hava durumu verilerini getiren asenkron fonksiyon
    try {
      final data = await _weatherService.fetchWeather(cityName); // Anlık hava durumu verisini API'den çek
      final forecast = await _weatherService.fetchForecastByCity(cityName); // 4 günlük tahmini veriyi API'den çek
      setState(() { // Ekranı güncellemek için state'i değiştir
        /*
        if (!context.mounted) return;
        final weatherType = data.main.toLowerCase(); // örnek:rain durumu

        if (weatherType == 'rain') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RainyPage(weather: data, forecast: forecast),
            ),
          );
        }
        */
        _weather = data; // Anlık hava durumu verisini _weather değişkenine ata
        _forecast = forecast; // Tahmini veriyi _forecast değişkenine ata
      });
    } catch (e) {  // Hata olursa burası çalışır
      debugPrint("Hava durumu alınamadı: $e"); // Hata mesajını konsola yazdır
      ScaffoldMessenger.of(context).showSnackBar( // Kullanıcıya Snackbar ile hata mesajı göster
        SnackBar(content: Text("Hata: $e")),  // Snackbar içeriği: hata mesajı
      );
    }
  }

  void showSearchDialog(BuildContext context) { // Şehir arama kutusunu (dialog) ekrana getiren fonksiyon
    String cityName = '';  // Kullanıcının yazacağı şehir adını tutacak değişken

    showDialog( // Flutter'da modal (popup) bir pencere açar
      context: context, // Mevcut ekranın context’i (görsel hiyerarşi)
      builder: (context) { // Dialog’un içeriğini oluşturur
        return AlertDialog( // Kutu şeklinde bir uyarı penceresi oluşturur
          title: const Text("Enter city name"), // Dialog başlığı
          content: TextField( // Kullanıcının şehir adını yazacağı giriş alanı
            decoration: const InputDecoration(hintText: "e.g. Istanbul"), // İçine örnek ipucu (placeholder)
            onChanged: (value) { // Kullanıcı yazdıkça çalışır
              cityName = value; // cityName değişkenini günceller
            },
          ),
          actions: [ // Dialog altındaki butonlar
            TextButton( // Buton oluşturur
              onPressed: () { // Butona basıldığında yapılacak işlem
                Navigator.of(context).pop(); // Dialog’u kapat
                fetchWeather(cityName); // Girilen şehir için hava durumu verilerini getir
              },
              child: const Text("Search"), // Buton üzerinde yazan metin
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) { // Widget'ın görsel arayüzünü oluşturur.
    String formattedDate = DateFormat('EEE, d MMM').format(DateTime.now()); // Şu anki tarihi biçimlendirerek bir string'e çevirir, örneğin "Mon, 28 Jul"

    return Scaffold(  // Sayfanın temel iskeletini oluşturan widget (app bar, body, vb. için çerçeve)
      body: Stack( // Ekrandaki widget'ları üst üste bindirmeye yarayan yapı (arka plan, içerik, ikon vs.)
        children: [
          Container( // Arka planı oluşturan widget
            decoration: const BoxDecoration( // Görsel süsleme (renk, gradyan, köşe yuvarlama vs.)
              gradient: LinearGradient( // Renk geçişli (gradyan) arka plan oluşturur
                colors: [Color(0xFFCCE4F6), Color(0xFFE6F0FA)],// Açık mavi tonlarında iki renk (üst ve alt)
                begin: Alignment.topLeft, // Gradyan sol üstten başlar
                end: Alignment.bottomRight, // Gradyan sağ alt köşeye kadar devam eder
              ),
            ),
          ),
          Positioned( // Stack içinde bir widget'ı belirli konuma yerleştirmek için kullanılır
            top: 300, // Üstten 300 piksel aşağı yerleştir
            right: -150, // Sağ kenardan -150 piksel dışarı kaydır (ekran dışına doğru çıkar)
            child: Container( // Yerleştirilecek olan içerik: daire şeklinde bir kutu (güneş efekti gibi)
              width: 350, // Genişlik: 350 piksel
              height: 350, // Yükseklik: 350 piksel
              decoration: const BoxDecoration( // Görsel süsleme: yuvarlak ve gradyanlı
                shape: BoxShape.circle, // Şekil: daire (kutu değil!)
                gradient: RadialGradient( // Merkezden dışa doğru renk geçişli gradyan
                  colors: [Color(0xFFFFD54F), Color(0xFFFF8A65)], // Sarımsı ve turuncumsu renkler (güneş efekti)
                  radius: 1.0, // Gradyan yayılma oranı
                ),
              ),
            ),
          ),

          SafeArea( // Cihazın çentik, status bar, navigasyon çubuğu gibi alanlarından uzak durulmasını sağlar
            child: Padding( // İçerik ile ekran kenarları arasında boşluk bırakmak için kullanılır
              padding: const EdgeInsets.all(20), // Her kenardan 20 piksel boşluk
              child: SingleChildScrollView( // Ekran içeriği taşarsa kaydırılabilir hale getirir
                child: Column( // Widget’ları dikey olarak alt alta dizer
                  crossAxisAlignment: CrossAxisAlignment.start, // Sütun içindeki öğeleri sola yasla
                  children: [
                    Container( // Üst kısımdaki bilgi kutusu (örneğin: karşılama yazısı ve tarih için)
                      width: double.infinity, // Ekran genişliğini tamamen kapla
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1), // Yatayda 20, dikeyde 1 boşluk
                      decoration: BoxDecoration( // Kutu süslemesi
                        color: Colors.white.withOpacity(0.9), // Beyaz arka plan, %90 opaklık
                        borderRadius: BorderRadius.circular(16), // Köşeleri 16 birim yuvarlat
                        boxShadow: [ // Hafif gölge efekti
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05), // Gölge rengi: siyah ve %5 opak
                            blurRadius: 6, // Gölgenin yayılma derecesi
                            offset: const Offset(0, 2), // Gölge aşağı doğru 2 piksel kaydırılır
                          ),
                        ],
                      ),

                      child: Column( // Widget’ları dikey (alt alta) sıralamak için kullanılır
                        crossAxisAlignment: CrossAxisAlignment.start, // Sütundaki öğeleri sola hizalar
                        children: [
                          Row( // Yatay (satır) düzende içerikleri yerleştirir
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Row içindeki öğeleri iki uca (sağ ve sol) yayar
                            children: [
                              const Text( // Sol tarafta görünen metin
                                "Good Morning", // Karşılaşma Yazısı
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600), // Yazı boyutu büyük ve kalın
                              ),
                              IconButton( // Sağ tarafta görünen buton ()
                                icon: const Icon(Icons.travel_explore, size: 32, color: Colors.black87), // Keşfet simgesi
                                onPressed: () => showSearchDialog(context), // Tıklanınca şehir arama popup'ını açar
                              ),
                            ],
                          ),
                          const SizedBox(height: 4), // İki öğe arasında 4 birim dikey boşluk bırakır
                          Text( // Alt satırda tarih bilgisi gösterilir
                            formattedDate, // Yukarıda oluşturduğun 'EEE, d MMM' formatındaki tarih
                            style: const TextStyle(fontSize: 16, color: Colors.grey), // Daha küçük ve gri renkte yazı
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8), // Üstteki içerik ile arasında 8 birim boşluk bırakır

                    _weather != null // Eğer hava durumu verisi varsa...
                        ? Column( // Veriyi göstermek için bir sütun (dikey liste) oluştur
                      children: [
                        Center( // Ortalayarak içerik yerleştir
                          child: Column( // Alt alta: şehir adı, ikon, sıcaklık, açıklama
                            children: [
                              Text(
                                _weather!.cityName ?? '', // Şehir adı (boşsa boş string döner)
                                style: const TextStyle(
                                  fontSize: 32, // Büyük font
                                  fontWeight: FontWeight.bold, // Kalın yazı
                                ),
                              ),
                              const SizedBox(height: 2), // Şehir adı ile ikon arasında 2 birim boşluk
                              Image.network( // Hava durumu ikonu
                                'https://openweathermap.org/img/wn/${_weather!.iconCode}@2x.png', // ikon adresi
                                width: 100, // genişlik 100px
                                height: 100, // yükseklik 100px
                                fit: BoxFit.cover, // ikon görüntüsünü kutuya sığdır
                              ),
                              const SizedBox(height: 1), // İkon ile sıcaklık arası 1 birim boşluk
                              Text(
                                "${_weather!.temperature.toStringAsFixed(0)}°C", // Sıcaklık değeri
                                style: const TextStyle(
                                  fontSize: 60, // Çok büyük font
                                  fontWeight: FontWeight.w600, // Yarı kalın yazı
                                ),
                              ),
                              const SizedBox(height: 5), // Sıcaklık ile açıklama arası boşluk
                              Text(
                                _weather!.description[0].toUpperCase() + // Açıklamanın ilk harfi büyük yapılır
                                    _weather!.description.substring(1),     // geri kalanı aynen eklenir
                                style: const TextStyle(
                                  fontSize: 20, // Orta boy metin
                                  color: Colors.black54, // Açık siyah
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20), // Önceki içerikle bu kutu arasında 20 birim dikey boşluk bırakır

                        Container( // Nem, rüzgar ve hissedilen sıcaklık değerlerini gösteren kutu (kart)
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18), // İçeriğin iç kenar boşlukları (üst-alt: 16, sağ-sol: 12)
                          margin: const EdgeInsets.symmetric(horizontal: 12), // Dış kenar boşlukları (sağ-sol: 12)
                          decoration: BoxDecoration( // Kutunun görsel süslemeleri
                            color: Colors.white, // Arka plan rengi: beyaz
                            borderRadius: BorderRadius.circular(20), // Köşeleri 20 birim yuvarlat
                            boxShadow: [ // Gölge efekti
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05), // Çok hafif siyah gölge (%5 opak)
                                blurRadius: 8, // Gölge yumuşaklığı
                                offset: const Offset(0, 4), // Gölgeyi aşağıya doğru 4 piksel kaydır
                              ),
                            ],
                          ),
                          child: Row( // Kart içinde yatayda 3 sütun gösterecek: nem, rüzgar, hissedilen sıcaklık
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Sütunlar arası eşit boşluk bırak
                            children: [
                              Column( // İlk sütun: nem bilgisi
                                children: [
                                  const Icon( // Su damlası simgesi (nem göstergesi)
                                    Icons.water_drop_outlined,
                                    size: 24,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(height: 6), // İkon ile metin arasında boşluk
                                  const Text(
                                    "Humidity", // Etiket metni
                                    style: TextStyle(fontSize: 20, color: Colors.black54),
                                  ),
                                  const SizedBox(height: 2), // Etiket ile veri arası boşluk
                                  Text(
                                    "${_weather!.humidity}%", // Gerçek nem değeri
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              Column( // Sütun: Dikeyde alt alta öğeler gösterilecek
                                children: [
                                  const Icon(Icons.air, size: 24, color: Colors.grey), // Rüzgâr simgesi
                                  const SizedBox(height: 6), //  İkon ile yazı arası boşluk
                                  const Text("Wind", //  Etiket: "Wind"
                                      style: TextStyle(fontSize: 20, color: Colors.black54)),
                                  const SizedBox(height: 2), // Etiket ile değer arası boşluk
                                  Text("${_weather!.windSpeed.toStringAsFixed(1)} m/s", //  Rüzgâr hızı verisi
                                      style: const TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Column( //  Hissedilen sıcaklık bilgisi sütunu
                                children: [
                                  const Icon(Icons.thermostat, size: 24, color: Colors.orange), // Termometre ikonu
                                  const SizedBox(height: 6), // İkon ile metin arası boşluk
                                  const Text("Feels like", // Etiket: Hissedilen sıcaklık
                                      style: TextStyle(fontSize: 20, color: Colors.black54)),
                                  const SizedBox(height: 2), // Etiket ile değer arası boşluk
                                  Text("${_weather!.feelsLike.toStringAsFixed(0)}°C", //  Hissedilen sıcaklık
                                      style: const TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20), //  Alt içeriklerle arasında boşluk

                        if (_forecast != null) //Tahmin verisi varsa göster
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12), // Sağ-sol kenar boşlukları
                            padding: const EdgeInsets.all(16), //İçerik ile kutu kenarı arası boşluk
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9), // Açık beyaz kutu
                              borderRadius: BorderRadius.circular(20), // Köşeleri yuvarlat
                              boxShadow: [ //  Hafif gölge efekti
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column( // İçeriği dikey sırala
                              crossAxisAlignment: CrossAxisAlignment.start, // Sola hizala
                              children: [
                                const Text(
                                  "Next days", // Başlık: "Next days"
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10), // Başlıkla tahmin verisi arası boşluk
                                for (var day in _forecast!) //  Forecast listesinden her gün için widget oluştur
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8), // Her gün için dikey boşluk
                                    child: Row( // Her tahmin satırı yatayda gösterilir
                                      children: [
                                        Image.network( //  Günlük hava durumu ikonu
                                          'https://openweathermap.org/img/wn/${day.iconCode}@2x.png',
                                          width: 40, //  İkon genişliği
                                          height: 40, // İkon yüksekliği
                                        ),
                                        const SizedBox(width: 12), // İkon ile sıcaklık arası boşluk
                                        Text(
                                          "${day.temperature.toStringAsFixed(0)}°", // Günlük sıcaklık
                                          style: const TextStyle(fontSize: 22),
                                        ),
                                        const SizedBox(width: 20), // Sıcaklık ile tarih arası boşluk
                                        Expanded( //  Tarih yazısını geri kalan alana yay
                                          child: Text(
                                            DateFormat('EEEE, d MMM').format(day.date!), // Gün ve tarih formatı
                                            style: const TextStyle(
                                                fontSize: 18, color: Colors.black87),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          ),
                      ],
                    )
                        : const Center(child: CircularProgressIndicator()), // _weather null ise yükleniyor göstergesi

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