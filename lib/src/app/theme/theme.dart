import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color kPurpleColor = Color(0xFFCDB4DB);
  static const Color kBabyPinkColor = Color(0xFFFFC8DD);
  static const Color kPinkColor = Color(0xFFFFAFCC);
  static const Color kLightBlueColor = Color(0xFFBDE0FE);
  static const Color kBlueColor = Color(0xFFA2D2FF);

  /// Global app theme
  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFF8EDEB),
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      toolbarHeight: 47,
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: Colors.black87,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(kPinkColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
              color: Colors.black87,
              width: 2,
            ),
          ),
        ),
      ),
    ),
    fontFamily: GoogleFonts.roboto().fontFamily,
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      bodyMedium: GoogleFonts.roboto(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      bodySmall: GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      labelLarge: GoogleFonts.roboto(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      labelMedium: GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      labelSmall: GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    ),
  );
}
