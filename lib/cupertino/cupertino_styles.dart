import 'package:flutter/cupertino.dart';

import '../base/base_styles.dart';

abstract class CupertinoStyles {
  static final CupertinoThemeData lightTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: Styles.primaryColor,
    primaryContrastingColor: Styles.accentColor,
    scaffoldBackgroundColor: Styles.backgroundColor,
    textTheme: CupertinoTextThemeData(
      navLargeTitleTextStyle: TextStyle(
        fontSize: Styles.fontSize30,
        fontWeight: Styles.fontWeightBold,
        color: Styles.black.withOpacity(Styles.opacity87),
      ),
      navTitleTextStyle: TextStyle(
        fontSize: Styles.fontSize21,
        fontWeight: Styles.fontWeightBold,
        color: Styles.black.withOpacity(Styles.opacity87),
      ),
      navActionTextStyle: TextStyle(
        fontSize: Styles.fontSize16,
        fontWeight: Styles.fontWeightSemiBold,
        color: Styles.accentColor,
      ),
      actionTextStyle: TextStyle(
        fontSize: Styles.fontSize19,
        fontWeight: Styles.fontWeightNormal,
        color: Styles.accentColor,
      ),
      textStyle: TextStyle(
        fontSize: Styles.fontSize16,
        fontWeight: Styles.fontWeightNormal,
        color: Styles.black.withOpacity(Styles.opacity64),
      ),
      tabLabelTextStyle: TextStyle(
        fontSize: Styles.fontSize11,
        fontWeight: Styles.fontWeightNormal,
        color: Styles.accentColor,
      ),
    ),
  );

  static final TextStyle formPrefixStyle = TextStyle(
      color: Styles.primaryColor.withOpacity(Styles.opacity87),
      fontSize: Styles.fontSize14);
  static final TextStyle navigationBarTextStyle =
      TextStyle(fontSize: 16.0, color: Styles.primaryColor);

  static TextStyle chartNamingStyle(bool isTouched) {
    final fontSize = isTouched ? 25.0 : 16.0;
    return TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: const Color(0xffffffff));
  }

  static final TextStyle mainTitleText = TextStyle(
      fontSize: Styles.fontSize21,
      fontWeight: Styles.fontWeightSemiBold,
      color: Styles.black.withOpacity(Styles.opacity87));

  static final TextStyle blackBodyText2 = TextStyle(
      fontSize: Styles.fontSize14,
      fontWeight: Styles.fontWeightNormal,
      color: Styles.black.withOpacity(Styles.opacity87));

  static final TextStyle cardTitleText = TextStyle(
      fontSize: Styles.fontSize19,
      fontWeight: Styles.fontWeightNormal,
      color: Styles.black.withOpacity(Styles.opacity87));

  static final TextStyle cardSubTitleText = TextStyle(
      fontSize: Styles.fontSize16,
      fontWeight: Styles.fontWeightLight,
      color: Styles.black.withOpacity(Styles.opacity87));

  static final TextStyle formErrorText = TextStyle(
      fontSize: Styles.fontSize11,
      fontWeight: Styles.fontWeightNormal,
      color: Styles.accentColor.withOpacity(Styles.opacity87));

  static final TextStyle errorMessageText = TextStyle(
      fontSize: Styles.fontSize19,
      fontWeight: Styles.fontWeightNormal,
      color: Styles.accentColor.withOpacity(Styles.opacity87));

  static const double navBarIconSize = 24.0;

  // region Colors
  static const Color priorityRed = CupertinoColors.destructiveRed;
  static const Color priorityYellow = CupertinoColors.systemYellow;
  static const Color priorityGreen = CupertinoColors.activeGreen;
// endregion
}
