/*
该类为Hive中自定义类型的模型实体
 */

import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class PluginModel extends HiveObject {
  final String name;

  final String category;

  final DateTime time;

  final bool evc;

  final String path;

  final String id;

  // 构造函数
  PluginModel(
      {required this.name,
      required this.category,
      required this.path,
      required this.evc,
      String? id,
      DateTime? time})
      : id = id ?? Uuid().v4(),
        time = time ?? DateTime.now();

  // 可选：重写 toString 方法，便于调试
  @override
  String toString() {
    return 'PluginModel{id: $id, name: $name, category: $category, time: $time, evc: $evc, path: $path}';
  }
}
