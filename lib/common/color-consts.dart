import 'dart:ui';

import 'package:flutter/material.dart';

class ColorConsts {

  // Logo 的颜色，一般都是品牌色
  static const LogoColor = Color(0xFF6D000D);

  // 主色，App 定调的颜色，一般从 Logo 中提升
  static const Primary = Color(0xFF461220);
  // 辅助色
  static const Secondary = Color(0x99461220);

  // 深色背景
  static const DarkBackground = Colors.brown;
  // 浅色背景
  static const LightBackground = Color(0xFFEEE0CB);

  // 棋盘颜色
  static const BoardBackground = Color(0xFFEBC38D);

  static const DarkTextPrimary = Colors.white;
  static const DarkTextSecondary = Color(0x99FFFFFF);

  // 棋盘线颜色
  static const BoardLine = Color(0x996D000D);

  // 棋盘上的路数、河界提示文字颜色
  static const BoardTips = Color(0x666D000D);

  static const LightLine = Color(0x336D000D);

  // 棋盘上的移动位置指示
  static const FocusPosition = Color(0x99FFFFFF);
  static const BlurPosition = Color(0x99FFFFFF);

  // 黑棋子颜色
  static const BlackPieceColor = Color.fromARGB(0xFF, 0x00, 0x00, 0x00);
  static const BlackPieceBorderColor = Color.fromARGB(0xFF, 0x22, 0x22, 0x22);

  // 红棋子颜色
  static const RedPieceColor = Color.fromARGB(0xFF, 0x7B, 0x00, 0x00);
  static const RedPieceBorderColor = Color.fromARGB(0xFF, 0x66, 0x00, 0x00);

  // 棋子文字颜色
  static const PieceTextColor = Color.fromARGB(0xCC, 0xFF, 0xFF, 0xFF);
}