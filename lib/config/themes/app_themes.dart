import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_strings.dart';

ThemeData appTheme(){
  return ThemeData(
    primaryColor: AppColors.primary,
    hintColor: AppColors.hint,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: AppStrings.fontFamily,

    //appBar
    appBarTheme:   const AppBarTheme(
      elevation: 0.0,
      centerTitle: true,
      color: Colors.transparent,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    )
  );
}