import 'package:flutter/material.dart';

class Pallete {
  // 声明为 static 变量之后能够在不创建类的实例对象而对该变量进行调用 如 Pallete.cardColor

  // static const cardColor = Color.fromRGBO(30, 30, 30, 1);
  // static const greenColor = Colors.green;
  // static const subtitleText = Color(0xffa7a7a7);
  // static const inactiveBottomBarItemColor = Color(0xffababab);
  //
  // static const Color backgroundColor = Color.fromRGBO(18, 18, 18, 1);
  // static const Color gradient1 = Color.fromRGBO(187, 63, 221, 1);
  // static const Color gradient2 = Color.fromRGBO(251, 109, 169, 1);
  // static const Color gradient3 = Color.fromRGBO(255, 159, 124, 1);
  // static const Color borderColor = Color.fromRGBO(52, 51, 67, 1);
  // static const Color whiteColor = Colors.white;
  // static const Color greyColor = Colors.grey;
  // static const Color errorColor = Colors.redAccent;
  // static const Color transparentColor = Colors.transparent;


  static const cardColor = Color.fromRGBO(20, 30, 50, 1); // 深蓝卡片背景
  static const greenColor = Colors.green; // 可保留用于表示成功的反馈

  static const subtitleText = Color(0xffa0b0c0); // 蓝灰色，用作辅助文字色
  static const inactiveBottomBarItemColor = Color(0xff7a8ca0); // 底部栏未选中状态

  static const Color backgroundColor = Color.fromRGBO(15, 20, 35, 1); // 主页面深蓝背景
  static const Color gradient1 = Color.fromRGBO(30, 60, 120, 1); // 渐变起始蓝
  static const Color gradient2 = Color.fromRGBO(50, 90, 160, 1); // 渐变中间蓝
  static const Color gradient3 = Color.fromRGBO(70, 110, 180, 1); // 渐变末尾蓝

  static const Color borderColor = Color.fromRGBO(60, 70, 100, 1); // 边框深蓝灰
  static const Color whiteColor = Colors.white; // 保留白色用于文字
  static const Color greyColor = Color(0xffb0b0b0); // 浅灰色备用

  static const Color errorColor = Color(0xffe57373); // 柔和的红色用于错误提示
  static const Color transparentColor = Colors.transparent;

  static const Color inactiveSeekColor = Colors.white38;






}