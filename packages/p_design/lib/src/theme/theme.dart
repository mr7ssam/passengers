import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';
import 'const.dart';
import 'typo.dart';

final kButtonPadding = REdgeInsets.all(LayoutConstrains.m1);
final kChipPadding = REdgeInsets.all(LayoutConstrains.s2);

final lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  textTheme: textTheme,
  colorScheme: _colorScheme,
  floatingActionButtonTheme: _floatingActionButtonTheme,
  textButtonTheme: _textButtonTheme,
  elevatedButtonTheme: _elevatedButtonTheme,
  outlinedButtonTheme: _outlinedButtonTheme,
  checkboxTheme: _checkboxThemeData,
  chipTheme: _chipTheme,
);

final _textButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    padding: kButtonPadding,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(PRadius.button.r),
    ),
  ),
);

final _elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    padding: kButtonPadding,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(PRadius.button.r),
    ),
  ),
);

final _outlinedButtonTheme = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    padding: kButtonPadding,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(PRadius.button.r),
    ),
  ),
);

final _floatingActionButtonTheme = FloatingActionButtonThemeData(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(PRadius.button.r),
  ),
);

final _colorScheme = ColorScheme.fromSwatch(
  primarySwatch: PColors.primarySwatch,
  accentColor: PColors.secondarySwatch.shade400,
);

final _checkboxThemeData = CheckboxThemeData(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(PRadius.checkBox.r),
  ),
);

final _chipTheme = ChipThemeData(
  padding: kChipPadding,
  selectedColor: PColors.primarySwatch.shade100,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(PRadius.chip.r),
  ),
);
