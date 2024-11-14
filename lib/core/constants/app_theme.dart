import 'package:flutter/material.dart';
import 'package:nutri_teca/core/constants/app_colors.dart';

class AppTheme {
  // Definición de tamaños de letra
  static const double titleFontSize = 32.0;
  static const double bodyFontSize = 24.0;
  static const double descriptionFontSize = 20.0;
  static const double captionFontSize = 16.0;

  // Definición de estilos de texto
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: titleFontSize,
    color: AppColors.foreground,
  );
  static const TextStyle splashTextStyle = TextStyle(
    fontFamily: 'DancingScript',
    fontSize: titleFontSize,
    fontWeight: FontWeight.w900,
    color: AppColors.foreground,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: bodyFontSize,
    color: AppColors.foreground,
  );

  static const TextStyle detailTextStyle = TextStyle(
    fontSize: bodyFontSize,
    color: AppColors.secondaryAccent,
  );

  static const TextStyle splashBodyTextStyle = TextStyle(
    fontFamily: 'DancingScript',
    fontWeight: FontWeight.w700,
    fontSize: bodyFontSize,
    color: AppColors.foreground,
  );

  static const TextStyle captionTextStyle = TextStyle(
    fontSize: captionFontSize,
    color: AppColors.foreground,
  );

  static const TextStyle descriptionTextStyle = TextStyle(
    fontSize: descriptionFontSize,
    color: Colors.white,
  );

  // Definición del tema
  static final ThemeData mainTheme = ThemeData(
    primaryColor: AppColors.foreground,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: const TextTheme(
      displayLarge: titleTextStyle,
      displayMedium: splashTextStyle,
      bodyLarge: bodyTextStyle,
      bodyMedium: splashBodyTextStyle,
      bodySmall: captionTextStyle,
    ),
    // Puedes agregar más personalizaciones aquí
  );
}
