import 'dart:io';

import 'package:chessboard/routes/main-menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(ChessRoadApp());

  // 仅支持竖屏
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
  );
  // 不显示状态栏
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent)
    );
  }
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class ChessRoadApp extends StatelessWidget {

  static const StatusBarHeight = 28.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.brown, fontFamily: 'QiTi'),
      debugShowCheckedModeBanner: false,
      home: MainMenu(),
    );
  }

}