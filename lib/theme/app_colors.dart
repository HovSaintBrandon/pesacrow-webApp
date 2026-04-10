import 'package:flutter/material.dart';

class AppColors {
  // Primary Action Colors (Role-Based)
  static const Color buyerGreen = Color(0xFF2E9D5B);
  static const Color sellerBlue = Color(0xFF3182CE);
  
  // Semantic Colors
  static const Color success = Color(0xFF2E9D5B); // Same as Buyer Green
  static const Color warning = Color(0xFFD69E2E); // Pending Payment (Amber)
  static const Color error = Color(0xFFE53E3E);   // Error/Disputed (Red)
  static const Color info = Color(0xFF3182CE);    // Funds Held (Blue)
  static const Color muted = Color(0xFF757575);   // Secondary Text

  // Neutral & Surface Palette
  static const Color bg = Color(0xFFF7F9F7);      // Scaffold Background
  static const Color surface = Colors.white;      // Surface White
  static const Color dark = Color(0xFF1A1A1A);     // Primary Text
  static const Color cardBorder = Color(0xFFE5E7EB);

  // Accent Tints
  static const Color buyerTint = Color(0xFFE8F5EE);

  // Legacy mappings for compatibility
  static const Color teal = buyerGreen;
  static const Color purple = sellerBlue;

  // Gradient helpers
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [buyerGreen, sellerBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static BoxDecoration gradientBox({double radius = 16}) => BoxDecoration(
    gradient: primaryGradient,
    borderRadius: BorderRadius.circular(radius),
  );
}
