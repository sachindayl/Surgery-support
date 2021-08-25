import 'package:flutter/material.dart';
import 'package:surgery_support/base/base_styles.dart';

abstract class MaterialStyles {
  static final ThemeData lightTheme = ThemeData(
      fontFamily: 'Roboto',
      brightness: Brightness.light,
      primarySwatch: Colors.brown,
      primaryColor: Styles.primaryColor,
      accentColor: Styles.accentColor,
      primaryColorDark: Styles.primaryColorDark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      iconTheme: IconThemeData(color: Styles.primaryColor),
      textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: Styles.fontSize30,
              fontWeight: Styles.fontWeightBold,
              color: Styles.black.withOpacity(Styles.opacity87)),
          headline2: TextStyle(
              fontSize: Styles.fontSize25,
              fontWeight: Styles.fontWeightBold,
              color: Styles.black.withOpacity(Styles.opacity87)),
          headline3: TextStyle(
              fontSize: Styles.fontSize21,
              fontWeight: Styles.fontWeightSemiBold,
              color: Styles.black.withOpacity(Styles.opacity87)),
          headline4: TextStyle(
              fontSize: Styles.fontSize19,
              fontWeight: Styles.fontWeightSemiBold,
              color: Styles.black.withOpacity(Styles.opacity87)),
          headline5: TextStyle(
              fontSize: Styles.fontSize16,
              fontWeight: Styles.fontWeightSemiBold,
              color: Styles.black.withOpacity(Styles.opacity87)),
          headline6: TextStyle(
              fontSize: Styles.fontSize14,
              fontWeight: Styles.fontWeightSemiBold,
              color: Styles.black.withOpacity(Styles.opacity87)),
          subtitle1: TextStyle(
              fontSize: Styles.fontSize16,
              fontWeight: Styles.fontWeightSemiBold,
              color: Styles.black.withOpacity(Styles.opacity87)),
          subtitle2: TextStyle(
              fontSize: Styles.fontSize14,
              fontWeight: Styles.fontWeightNormal,
              color: Styles.black.withOpacity(Styles.opacity64)),
          bodyText1: TextStyle(
              fontSize: Styles.fontSize16,
              fontWeight: Styles.fontWeightNormal,
              color: Styles.black.withOpacity(Styles.opacity64)),
          bodyText2: TextStyle(
              fontSize: Styles.fontSize14,
              fontWeight: Styles.fontWeightNormal,
              color: Styles.black.withOpacity(Styles.opacity64)),
          button: TextStyle(fontSize: Styles.fontSize21, color: Colors.grey)),
      backgroundColor: Styles.backgroundColor,
      disabledColor: Styles.unselectedTextColor,
      cardColor: Styles.white,
      unselectedWidgetColor: Styles.unselectedTextColor);

  static final double iconSizedBoxWidth = 50.0;
}