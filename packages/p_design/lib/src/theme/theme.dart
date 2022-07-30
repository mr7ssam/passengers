import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';
import 'const.dart';
import 'typo.dart';

final kButtonPadding = REdgeInsets.all(LayoutConstrains.m1);
final kChipPadding = REdgeInsets.all(LayoutConstrains.s2);

final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: PColors.primarySwatch.shade500,
    scaffoldBackgroundColor: PColors.scaffoldBackground,
    useMaterial3: true,
    textTheme: textTheme,
    colorScheme: _colorScheme,
    floatingActionButtonTheme: _floatingActionButtonTheme,
    textButtonTheme: _textButtonTheme,
    elevatedButtonTheme: _elevatedButtonTheme,
    outlinedButtonTheme: _outlinedButtonTheme,
    checkboxTheme: _checkboxThemeData,
    chipTheme: _chipTheme,
    appBarTheme: _appBarTheme,
    inputDecorationTheme: _kInputDecoration,
    iconTheme: _kIconTheme,
    indicatorColor: PColors.primarySwatch.shade400,
    popupMenuTheme: PopupMenuThemeData(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(PRadius.container),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(PRadius.container),
          topRight: Radius.circular(PRadius.container),
        ),
      ),
    ),
    cardTheme: CardTheme(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PRadius.container.r))),
    dialogTheme: DialogTheme(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r))),
    listTileTheme: ListTileThemeData(
      horizontalTitleGap: 0,
      contentPadding: REdgeInsets.symmetric(horizontal: 12),
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: Colors.transparent,
      height: 50.h,
    ));
final _borderWidth = 1.r;
final _inputBorderRadius = BorderRadius.circular(PRadius.texFiled).r;
final _kInputDecoration = InputDecorationTheme(
  fillColor: PColors.textFieldFill,
  contentPadding: REdgeInsets.symmetric(vertical: 14, horizontal: 14),
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(width: _borderWidth, color: PColors.textFieldBorder),
    borderRadius: _inputBorderRadius,
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(width: _borderWidth, color: PColors.textFieldBorder),
    borderRadius: _inputBorderRadius,
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
        BorderSide(width: _borderWidth, color: PColors.primarySwatch.shade500),
    borderRadius: _inputBorderRadius,
  ),
  errorBorder: OutlineInputBorder(
    borderSide:
        BorderSide(width: _borderWidth, color: PColors.errorSwatch.shade400),
    borderRadius: _inputBorderRadius,
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide(width: _borderWidth, color: PColors.textFieldBorder),
    borderRadius: _inputBorderRadius,
  ),
);

final _kIconTheme = IconThemeData(size: 20.r);

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
    side: BorderSide(color: PColors.primarySwatch.shade400),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(PRadius.button.r),
    ),
  ),
);

final _floatingActionButtonTheme = FloatingActionButtonThemeData(
  backgroundColor: PColors.primarySwatch.shade500,
  foregroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(PRadius.floatingButton.r),
  ),
);

final _colorScheme = ColorScheme.fromSwatch(
  primarySwatch: PColors.primarySwatch,
  accentColor: PColors.secondarySwatch.shade400,
).copyWith(
  onPrimaryContainer: PColors.primarySwatch.shade400,
  primaryContainer: PColors.primarySwatch.shade50,
);

final _checkboxThemeData = CheckboxThemeData(
  fillColor: MaterialStateProperty.all(PColors.primarySwatch),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(PRadius.checkBox.r),
  ),
);

final _chipTheme = ChipThemeData(
  padding: kChipPadding,
  selectedColor: PColors.primarySwatch.shade50,
  backgroundColor: Colors.transparent,
  checkmarkColor: PColors.primarySwatch.shade400,
  shape: RoundedRectangleBorder(
    side: BorderSide(
      width: 1.r,
    ),
    borderRadius: BorderRadius.circular(PRadius.chip.r),
  ),
);

final _appBarTheme = AppBarTheme(
  color: Colors.transparent,
  elevation: 0,
  titleSpacing: LayoutConstrains.m3.r,
  foregroundColor: Colors.black,
  iconTheme: const IconThemeData(color: Colors.black),
);
