import 'package:flutter/material.dart';
import 'app_pallete.dart';

class AppTheme {
  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
      width: 3,
    ),
    borderRadius: BorderRadius.circular(10),
  );

  // final 表示该变量只能被赋值一次
  //这样可以确保 darkThemeMode 只在第一次使用时初始化之后的调用将使用同一个实例
  static final darkThemeMode = ThemeData.dark().copyWith( // static 表示属于类本身而不是类的对象
    // 使用 copyWith 可以避免重新定义所有的主题属性
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(Pallete.borderColor),
      focusedBorder: _border(Pallete.gradient2),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Pallete.backgroundColor,
    ),
  );
}