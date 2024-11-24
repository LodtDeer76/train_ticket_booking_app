// ignore_for_file: constant_identifier_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Constant {
  factory Constant() => _singleton;

  Constant._internal();

  static final Constant _singleton = Constant._internal();

  static Constant getInstance() => _singleton;
}

class TextInputLength {
  static const xShort = 6;
  static const short = 10;
  static const medium = 20;
  static const xMedium = 50;
  static const xxMedium = 100;
}

class InputFieldType {
  static const text = "text";
  static const dropDown = "dropdownbox";
  static const calendar = "calendar";
  static const button = "button";
}

class BorderRadiusConst {
  static const double small = 4;
  static const double standard = 10;
  static const double large = 20;
  static const double xLarge = 30;
  static const double xxLarge = 60;
  static const double xxxLarge = 160;
}

class IconSizeConst {
  static const double tiny = 8;
  static const double small = 14;
  static const double xSmall = 20;
  static const double normal = 24;
  static const double large = 28;
  static const double xLarge = 36;
  static const double xxLarge = 40;
  static const double mLarge = 50;
  static const double xxxLarge = 70;
  static const double extraLarge = 100;
  static const double extreme = 192;
}

class ButtonSizeConst {
  static const double normal = 40;
  static const double large = 28;
  static const double xLarge = 36;
  static const double xxLarge = 40;
  static const double mLarge = 50;
  static const double xxxLarge = 70;
  static const double extraLarge = 100;
  static const double extreme = 192;
}

class ItemSizeConst {
  static const double searchBarHeight = 28;
  static const double categoryHeight = 80;
  static const double categoryWidth = 65;
  static const double ArticleHeight = 200;
  static const double infoWidth = 130;
  static const double popupHeight = 60;
  static const double ProfileHeight = 130;
}

class PaddingConst {
  static const double xxSmall = 1;
  static const double xSmall = 2;
  static const double small = 4;
  static const double medium = 8;
  static const double xMedium = 12;
  static const double large = 16;
  static const double xLarge = 20;
  static const double xxLarge = 26;
  static const double xxxLarge = 32;
  static const double extreme = 35;
  static const double xExtreme = 45;
  static const double xxExtreme = 55;
  static const double xxxExtreme = 75;
  static const double customize = 90;
  static const double customize1 = 100;
  static const double customize2 = 150;
}

class FontWeightStyle {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight medium = FontWeight.w500;
}

class FontSizeStyle {
  static const double xxSmall = 10;
  static const double xSmall = 13;
  static const double small = 15;
  static const double xMedium = 20;
  static const double medium = 25;
}

class MinFontSizeConst {
  static const double xsmall = 6;
  static const double xMedium = 10;
  static const double medium = 12;
  static const double large = 28;
  static const double exreme = 44;
}

class ButtonHeightStyle {
  static const double xMedium = 50;
}
