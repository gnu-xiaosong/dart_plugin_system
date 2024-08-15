/*
Functionality插件类型的实现
 */
import 'package:uuid/uuid.dart';

import '../Plugin.dart';
import '../PluginType.dart';
import '../pluginInsert/PluginCategory.dart';

class FunctionalityPlugin extends Plugin {
  @override
  bool status = true;

  @override
  PluginType type = PluginType.Functionality;

  @override
  String id = const Uuid().v4();

  @override
  DateTime time = DateTime.now();

  /*
  初始化传参
   */
  FunctionalityPlugin(
      {required PluginCategory category,
      bool? evc,
      required String path,
      required String name}) {
    this.evc = evc ?? true;
    this.name = name;
    this.path = path;
    this.category = category;
  }

  @override
  dispose() {
    // 实现该类型插件操作：在插件被释放时调用
    print("FunctionalityPlugin: 释放插件");
  }

  @override
  void initial() {
    // 实现该类型插件操作: 在插件再初始化时调用
    print("FunctionalityPlugin: 初始化插件");
  }

  @override
  registerPlugin() {
    // 实现该类型插件操作：在插件注册时被调用
    print("FunctionalityPlugin: 注册插件");
  }
}
