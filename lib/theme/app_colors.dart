import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors (Bitnob-inspired)
  static const Color background = Color(0xFF0A0A0A);
  static const Color surface = Color(0xFF111827);
  static const Color surfaceLight = Color(0xFF1F2937);
  
  // Accent Palette
  static const Color cyan = Color(0xFF00B4FF);
  static const Color electricBlue = Color(0xFF3B82F6);
  static const Color success = Color(0xFF22C55E);
  static const Color orange = Color(0xFFF59E0B);
  static const Color accentGold = Color(0xFFFFD700);
  
  // Semantic Colors
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFFBBF24);
  static const Color info = Color(0xFF3B82F6);
  
  // Text Colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color textMuted = Color(0xFF6B7280);

  // Legacy mappings (Keep some for compatibility temporarily if needed)
  static const Color buyerGreen = success;
  static const Color sellerBlue = electricBlue;
  static const Color dark = background;
  static const Color muted = textSecondary;

  // Gradient helpers
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [cyan, electricBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [orange, accentGold],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static BoxDecoration gradientBox({double radius = 12}) => BoxDecoration(
    gradient: primaryGradient,
    borderRadius: BorderRadius.circular(radius),
    boxShadow: [
      BoxShadow(
        color: cyan.withOpacity(0.3),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );

  static BoxDecoration cyberCard({double radius = 16}) => BoxDecoration(
    color: surface.withOpacity(0.6),
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: Colors.white.withOpacity(0.1)),
  );
}
