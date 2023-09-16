import 'package:flutter/material.dart';
import 'package:avacado_task/common/constants/colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    // useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.green,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      titleSpacing: 0,
      titleTextStyle: TextStyle(
        fontSize: 17.5,
        color: Colors.white,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w500,
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.green,
    ),
  );
}
