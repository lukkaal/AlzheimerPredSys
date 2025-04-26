// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';
// import 'package:flutter/foundation.dart';

// class GestureModel {
//   final String id;
//   final String name;
//   final List<String> trajectory;
//   final List<String> pressure;

//   GestureModel({
//     required this.id,
//     required this.name,
//     required this.trajectory,
//     required this.pressure
//   });



//   GestureModel copyWith({
//     String? id,
//     String? name,
//     List<String>? trajectory,
//     List<String>? pressure,
//   }) {
//     return GestureModel(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       trajectory: trajectory ?? this.trajectory,
//       pressure: pressure ?? this.pressure,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'name': name,
//       'trajectory': trajectory,
//       'pressure': pressure,
//     };
//   }

//   factory GestureModel.fromMap(Map<String, dynamic> map) {
//     return GestureModel(
//       id: map['id'] as String,
//       name: map['name'] as String,
//       trajectory: List<String>.from(map['trajectory'] as List),
//       pressure: List<String>.from(map['pressure'] as List), // 添加右括号
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory GestureModel.fromJson(String source) => GestureModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'GestureModel(id: $id, name: $name, trajectory: $trajectory, pressure: $pressure)';
//   }

//   @override
//   bool operator ==(covariant GestureModel other) {
//     if (identical(this, other)) return true;
  
//     return 
//       other.id == id &&
//       other.name == name &&
//       listEquals(other.trajectory, trajectory) &&
//       listEquals(other.pressure, pressure);
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//       name.hashCode ^
//       trajectory.hashCode ^
//       pressure.hashCode;
//   }
// }

import 'dart:convert';
import 'package:flutter/foundation.dart';

// class GestureModel {
//   final String id;
//   final String name;
//   final String trajectory;  // 更改为 String 类型
//   final String pressure;    // 更改为 String 类型
//
//   GestureModel({
//     required this.id,
//     required this.name,
//     required this.trajectory,
//     required this.pressure,
//   });
//
//   GestureModel copyWith({
//     String? id,
//     String? name,
//     String? trajectory,
//     String? pressure,
//   }) {
//     return GestureModel(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       trajectory: trajectory ?? this.trajectory,
//       pressure: pressure ?? this.pressure,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'name': name,
//       'trajectory': trajectory,
//       'pressure': pressure,
//     };
//   }
//
//   factory GestureModel.fromMap(Map<String, dynamic> map) {
//     return GestureModel(
//       id: map['id'] as String,
//       name: map['name'] as String,
//       trajectory: map['trajectory'] as String,  // 更改为 String
//       pressure: map['pressure'] as String,      // 更改为 String
//     );
//   }
//
//   String toJson() => json.encode(toMap());
//
//   factory GestureModel.fromJson(String source) =>
//       GestureModel.fromMap(json.decode(source) as Map<String, dynamic>);
//
//   @override
//   String toString() {
//     return 'GestureModel(id: $id, name: $name, trajectory: $trajectory, pressure: $pressure)';
//   }
//
//   @override
//   bool operator ==(covariant GestureModel other) {
//     if (identical(this, other)) return true;
//
//     return other.id == id &&
//         other.name == name &&
//         other.trajectory == trajectory && // 比较 String
//         other.pressure == pressure;       // 比较 String
//   }
//
//   @override
//   int get hashCode {
//     return id.hashCode ^
//         name.hashCode ^
//         trajectory.hashCode ^ // 计算 String 的 hashCode
//         pressure.hashCode;     // 计算 String 的 hashCode
//   }
// }

class GestureModel {
  final String id;
  final String name;
  final String trajectory;  // 更改为 String 类型
  final String pressure;    // 更改为 String 类型
  final String description;

  GestureModel({
    required this.id,
    required this.name,
    required this.trajectory,
    required this.pressure,
    required this.description
  });

  GestureModel copyWith({
    String? id,
    String? name,
    String? trajectory,
    String? pressure,
    String? description,
  }) {
    return GestureModel(
      id: id ?? this.id,
      name: name ?? this.name,
      trajectory: trajectory ?? this.trajectory,
      pressure: pressure ?? this.pressure,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'trajectory': trajectory,
      'pressure': pressure,
      'description': description,
    };
  }

  factory GestureModel.fromMap(Map<String, dynamic> map) {
    return GestureModel(
      id: map['id'] as String,
      name: map['name'] as String,
      trajectory: map['trajectory'] as String,
      pressure: map['pressure'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GestureModel.fromJson(String source) => GestureModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GestureModel(id: $id, name: $name, trajectory: $trajectory, pressure: $pressure, description: $description)';
  }

  @override
  bool operator ==(covariant GestureModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.trajectory == trajectory &&
      other.pressure == pressure &&
      other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      trajectory.hashCode ^
      pressure.hashCode ^
      description.hashCode;
  }
}
 