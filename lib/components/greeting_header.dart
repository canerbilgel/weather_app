import 'package:flutter/material.dart';

// Uygulamanın üst kısmında yer alan karşılama bileşeni.
// Günün saatine göre dinamik bir "Good Morning", "Good Afternoon" mesajını gösterir
// Ayrıca sağ üstte şehir arama için bir buton bulunur.
class GreetingHeader extends StatelessWidget {
  final String greeting;           // Günün saatine göre oluşturulmuş karşılama metni
  final String formattedDate;
  final VoidCallback onSearchPressed; // Şehir arama butonuna basıldığında çalışacak fonksiyon

  const GreetingHeader({
    required this.greeting,
    required this.formattedDate,
    required this.onSearchPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),

      // Kutunun görsel stili
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

      // İçerik: karşılama metni - buton - tarih
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Üst satır: Selamlama ve arama butonu
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Günlük selamlama
              Text(
                greeting,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),

              // Şehir arama butonu
              IconButton(
                icon: const Icon(Icons.travel_explore, size: 32, color: Colors.black87),
                onPressed: onSearchPressed,
              ),
            ],
          ),

          const SizedBox(height: 4),

          // Alt satır: Tarih bilgisi
          Text(
            formattedDate,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

