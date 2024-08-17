/*
该类为数据模型类的基类:
供数据模型实现类的重写
数据模型类，用于插件和 Dart 环境之间的数据通讯
 */
import 'dart:convert';
import 'package:eval_annotation/eval_annotation.dart';

@Bind()
class PluginDataModel {
  final String id; // 模型id
  final String name; // 数据模型名称
  final Map<String, dynamic> payload; // 通讯数据

  PluginDataModel({
    required this.id,
    required this.name,
    required this.payload,
  });

  // 从 JSON 构造数据模型对象
  factory PluginDataModel.fromJson(String source) =>
      PluginDataModel.fromMap(json.decode(source));

  // 将数据模型对象转换为 JSON
  String toJson() => json.encode(toMap());

  // 从 Map 构造数据模型对象
  factory PluginDataModel.fromMap(Map<String, dynamic> map) {
    return PluginDataModel(
      id: map['id'],
      name: map['name'],
      payload: Map<String, dynamic>.from(map['payload']),
    );
  }

  // 将数据模型对象转换为 Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'payload': payload,
    };
  }
}
