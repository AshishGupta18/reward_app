import 'package:flutter/material.dart';




class AppGradients extends ThemeExtension<AppGradients> {
  final LinearGradient gradient;

  AppGradients({required this.gradient});

  @override
  AppGradients copyWith({LinearGradient? gradient}) {
    return AppGradients(gradient: gradient ?? this.gradient);
  }

  @override
  AppGradients lerp(AppGradients? other, double t) {
    if (other is! AppGradients) return this;
    return AppGradients(
      gradient: LinearGradient(
        colors: [
          Color.lerp(gradient.colors[0], other.gradient.colors[0], t)!,
          Color.lerp(gradient.colors[1], other.gradient.colors[1], t)!,
        ],
      ),
    );
  }
}


class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      // Define the primary color and overall color scheme
      primaryColor: Color(0xFF6200EA), // Purple
      colorScheme: ColorScheme.light(
        primary: Color(0xFF6200EA), // Purple
        secondary: Color(0xFF03DAC6), // Teal
        surface: Colors.white, // Card background
        background: Color(0xFFF5F5F5), // Main background
        error: Colors.red, // Error color
        onPrimary: Colors.white, // Text color on primary
        onSecondary: Colors.black, // Text color on secondary
        onSurface: Colors.black, // Text color on surface
        onBackground: Colors.black, // Text color on background
        onError: Colors.white, // Text color on error
      ),
      scaffoldBackgroundColor: Color(0xFFF5F5F5), // Background color
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.teal, // AppBar color
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.white), // Icon color
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Color(0xFF6200EA), // Button color
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(fontSize: 18, color: Colors.black87),
        bodyText2: TextStyle(fontSize: 16, color: Colors.black54),
        headline4: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        caption: TextStyle(fontSize: 14, color: Colors.grey),
        button: TextStyle(fontSize: 16, color: Colors.white),
      ),
      cardTheme: CardTheme(
        color: Colors.white, // Card background color
        elevation: 4, // Card shadow elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Card corner radius
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // Input field border radius
          borderSide: BorderSide(color: Color(0xFF6200EA)), // Border color
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFF03DAC6)), // Focused border color
        ),
        hintStyle: TextStyle(color: Colors.black38), // Hint text color
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF6200EA), // Elevated button color
          onPrimary: Colors.white, // Text color on elevated button
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Button radius
          ),
        ),
      ),
    );
  }


   static LinearGradient get gradient {
    return LinearGradient(
      colors: [
        Color(0xFF6200EA), // Start color (light purple)
        Color(0xFF03DAC6), // End color (teal)
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}