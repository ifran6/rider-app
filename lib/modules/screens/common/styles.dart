import 'package:flutter/material.dart';

class AppStyles {
  // Colors
  static Color primaryColor = Colors.indigo[600]!;
  static Color secondaryColor = Colors.indigo[400]!;
  static Color backgroundColor = Colors.grey[50]!;
  static Color cardColor = Colors.white;
  static Color textPrimaryColor = Colors.grey[800]!;
  static Color textSecondaryColor = Colors.grey[600]!;
  static Color textTertiaryColor = Colors.grey[500]!;
  static Color borderColor = Colors.grey[200]!;
  
  // Text Styles
  static TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textPrimaryColor,
  );
  
  static TextStyle heading2 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
  );
  
  static TextStyle heading3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
  );
  
  static TextStyle bodyText = TextStyle(
    fontSize: 14,
    color: textPrimaryColor,
  );
  
  static TextStyle smallText = TextStyle(
    fontSize: 12,
    color: textTertiaryColor,
  );
  
  // Button Styles
  static ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
  
  static ButtonStyle secondaryButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: textSecondaryColor,
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(color: borderColor),
    ),
  );
  
  // Card Styles
  static BoxDecoration cardDecoration = BoxDecoration(
    color: cardColor,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.1),
        spreadRadius: 1,
        blurRadius: 3,
        offset: const Offset(0, 1),
      ),
    ],
  );
}