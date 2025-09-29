// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppColors {
  static const Color darkIndigo = Color(0xFF4B4E6D);
  static const Color mutedLavender = Color(0xFFA9A9B7);
  static const Color steelGray = Color(0xFF606E8C);
  static const Color softSilver = Color(0xFFC0C0C0);
  static const Color charcoal = Color(0xFF1F1F24);
  static const Color warningRed = Color(0xFFD32F2F);
  static const Color successGreen = Color(0xFF388E3C);
  static const Color infoBlue = Color(0xFF1976D2);
}

// Crime type colors for better visual organization
class CrimeColors {
  static const Map<String, Color> crimeTypeColors = {
    'Theft': Color(0xFFFF6B6B),
    'Assault': Color(0xFFFFA726),
    'Fraud': Color(0xFFAB47BC),
    'Burglary': Color(0xFF26A69A),
    'Drug Offenses': Color(0xFF42A5F5),
    'Cybercrime': Color(0xFF7E57C2),
    'Homicide': Color(0xFFEF5350),
    'Sexual Offenses': Color(0xFFEC407A),
  };
}

// Helper function to replace deprecated withOpacity()
Color withOpacity(Color color, double opacity) {
  return color.withOpacity(opacity);
}

ThemeData buildTheme() {
  return ThemeData(
    primaryColor: AppColors.darkIndigo,
    scaffoldBackgroundColor: AppColors.charcoal,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.charcoal,
      foregroundColor: AppColors.softSilver,
      elevation: 2,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: AppColors.softSilver, fontSize: 24, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(color: AppColors.softSilver, fontSize: 20, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: AppColors.softSilver, fontSize: 16),
      bodyMedium: TextStyle(color: AppColors.mutedLavender, fontSize: 14),
      labelLarge: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: withOpacity(AppColors.steelGray, 0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.darkIndigo, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkIndigo,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.steelGray,
        textStyle: const TextStyle(fontWeight: FontWeight.w500),
      ),
    ),
    cardTheme: CardTheme(
      color: withOpacity(AppColors.steelGray, 0.2),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),
  );
}