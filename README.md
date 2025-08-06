# Flutter Hava Durumu Uygulaması

Bu Flutter uygulaması, OpenWeatherMap API kullanarak bir şehir için anlık hava durumu ve 4 günlük tahmin verilerini görsel olarak sunar. Uygulama, kullanıcı dostu bir arayüz ve modüler mimari ile geliştirilmiştir.

---

## Uygulamayı Çalıştırma Adımları

1. **Depoyu klonlayın:**

```bash
git clone https://github.com/canerbilgel/weather_app.git
cd weather_app
```

2. **Bağımlılıkları yükleyin:**

```bash
flutter pub get
```

3. **API Anahtarını ayarlayın:**
   Proje kök dizinine bir `.env` dosyası oluşturun ve aşağıdaki içeriği ekleyin:

```env
OPENWEATHER_API_KEY=**************************
OPENWEATHER_BASE_URL=*************************
```

4. **Uygulamayı çalıştırın:**

```bash
flutter run
```

---

## Özellikler

* Şehir ismine göre hava durumu arama
* Anlık sıcaklık, açıklama, nem, rüzgar hızı, hissedilen sıcaklık gösterimi
* 4 günlük hava durumu tahmini
* Hava durumuna göre otomatik değişen gradyan arka plan
* Saat bazlı karşılama mesajı (Good Morning, Afternoon, Evening, Night)
* Responsive arayüz
* OpenWeather hava durumu ikonları
* API verileri için cacheleme desteği
* Bileşen tabanlı modüler mimari

---

## Proje Klasör Yapısı

```
lib/
├── components/          // Yeniden kullanılabilir bileşenler
├── models/              // Veri modelleri 
├── pages/               // Ana sayfa (WeatherPage)
├── services/            // API servisleri
├── utils/               // Yardımcı fonksiyonlar (gradyan)
├── main.dart            // Giriş noktaları
```

---

## Teknik ve Tasarımsal Tercihler
* WeatherPage sayfasının yapısı bileşenlere ayrılarak modüler hale getirildi. Bu sayede kodun okunabilirliği, bakımı ve geliştirilebilirliği artırıldı.
* gradient_helper.dart dosyası ile hava durumuna bağlı olarak arka plan gradyanı dinamik şekilde belirleniyor. Her hava durumu için özel renk kombinasyonları kullanıldı.
* Saatlik selamlama ("Good Morning", "Good Afternoon", vb.) dinamik olarak gösterilerek kullanıcıyla kişiselleştirilmiş bir bağlantı kurulması hedeflendi.
* API'den gelen veriler, aynı şehir için tekrar sorgu yapılmaması için önbelleğe alındı (cache). Bu da hem performansı artırır hem de API limitlerinin gereksiz tükenmesini engeller.
* Kod yapısı, her dosyada anlamlı ve açıklayıcı yorumlar ile zenginleştirildi. Bu sayede hem geliştirici ekip için okunabilirlik artıyor hem de GitHub üzerinden kod incelemesi kolaylaşıyor.

---


## Kaynaklar

* [OpenWeatherMap API](https://openweathermap.org/)
* [Flutter Resmi Belgeleri](https://flutter.dev/)

