import 'package:flutter/material.dart';

class AppColors {
  // ---- Genel arka plan renkleri ----
  static const Color bgLight1 = Color(0xFFCCE4F6);
  static const Color bgLight2 = Color(0xFFE6F0FA);

  // ---- Güneş efekti ----
  static const Color sunOuter = Color(0xFFFFD54F);
  static const Color sunInner = Color(0xFFFF8A65);

  // ---- Hava durumu gradyan renkleri ----
  static const Color clear1 = Color(0xFFfceabb);
  static const Color clear2 = Color(0xFFf8b500);

  static const Color clouds1 = Color(0xFFbdc3c7);
  static const Color clouds2 = Color(0xFF2c3e50);

  static const Color rain1 = Color(0xFF4b79a1);
  static const Color rain2 = Color(0xFF283e51);

  static const Color thunderstorm1 = Color(0xFF141E30);
  static const Color thunderstorm2 = Color(0xFF243B55);

  static const Color snow1 = Color(0xFF83a4d4);
  static const Color snow2 = Color(0xFFb6fbff);

  static const Color mist1 = Color(0xFFcfd9df);
  static const Color mist2 = Color(0xFFe2ebf0);

  static const Color smoke1 = Color(0xFFb79891);
  static const Color smoke2 = Color(0xFF94716b);

  static const Color squall1 = Color(0xFF485563);
  static const Color squall2 = Color(0xFF29323c);

  static const Color tornado1 = Color(0xFF3a3a3a);
  static const Color tornado2 = Color(0xFF000000);

  static const Color default1 = Color(0xFFd7d2cc);
  static const Color default2 = Color(0xFF304352);

  // ---- UI yardımcı renkler ----
  static const Color textMuted   = Colors.black54;
  static const Color textPrimary = Colors.black87;
  static const Color iconPrimary = Colors.black87;
  static const Color cardBg      = Colors.white;
  static const Color iconBlue    = Colors.blue;
  static const Color iconGrey    = Colors.grey;
  static const Color iconOrange  = Colors.orange;
  static const Color panelTint   = Colors.grey;

  // ---- Opaklık gerektiren renkler ----
  static Color shadow05() => Colors.black.withOpacity(0.05);
}
