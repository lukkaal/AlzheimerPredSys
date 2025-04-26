import 'package:flutter/material.dart';

String rgbToHex(Color color) {
  return '${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}';
}

Color hexToColor(String hex) {
  return Color(int.parse(hex, radix: 16) + 0xFF000000);
}

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context) // 一个帮助管理 Scaffold 中 SnackBar 和 MaterialBanner 的工具类。
    ..hideCurrentSnackBar() // .. 是 Dart 中的级联操作符 用于在同一对象上连续调用多个方法或访问多个属性而无需多次引用该对象
    ..showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
}

