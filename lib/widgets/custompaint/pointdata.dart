import 'package:flutter/material.dart';

class PointData {
  final Offset position; // required 不能用于位置参数
  final double pressure;

  PointData(this.position, this.pressure);
}