import 'package:flutter/material.dart';
import 'package:simple_init_tracker/theme/colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
  );

  static ThemeData darkTheme = ThemeData(
    dividerTheme: const DividerThemeData(color: Colors.transparent),
    iconTheme: IconThemeData(
      color: AppColors.textPrimary,
    ),
    scaffoldBackgroundColor: AppColors.background,
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.textPrimary;
          }
          return AppColors.textSecondary;
        }),
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.background,
      primary: AppColors.background,
      onPrimary: AppColors.secondaryBackground,
      secondary: AppColors.textPrimary,
      onSecondary: AppColors.textSecondary,
      tertiary: AppColors.minorColor,
      secondaryContainer: AppColors.popupBackground,
      onSecondaryContainer: AppColors.onPopupBackground,
    ),
    textTheme: TextTheme(
      headlineLarge: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      headlineMedium: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      headlineSmall: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleLarge: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      // TitleMedium used by AppBar titles and Buttons
      titleMedium: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      titleSmall: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      labelLarge: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      // LabelMedium used by popup labels
      labelMedium: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      bodyLarge: const TextStyle(
        fontSize: 16,
        color: AppColors.textPrimary,
      ),
      bodyMedium: const TextStyle(
        fontSize: 14,
        color: AppColors.textPrimary,
      ),
      bodySmall: const TextStyle(
        fontSize: 12,
        color: AppColors.textPrimary,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.textSecondary,
      selectionColor: AppColors.textSecondary,
      selectionHandleColor: AppColors.textSecondary,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.popupBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      foregroundColor: AppColors.textPrimary,
    ),
  );
}
