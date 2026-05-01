import 'package:flutter/material.dart';
import 'package:test_transisi/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(color: AppColors.typography, fontSize: 16, fontWeight: FontWeight.w500),
      labelMedium: TextStyle(color: AppColors.grey, fontSize: 15),
      labelSmall: TextStyle(color: AppColors.grey, fontSize: 12, fontWeight: FontWeight.w300),
    ),
  );
}
