/*
插件管理器
*/
import 'dart:io';

import 'package:hive/hive.dart';

import 'PluginType.dart';
import 'pluginInsert/PluginInsertPointManager.dart';
import './storeData/ServerStoreDataPlugin.dart';
import 'Plugin.dart';
import 'storeData/PluginModel.dart';
import 'storeData/PluginModelAdapter.dart';

class PluginManager extends ServerStoreDataPlugin {
  // 私有构造函数，确保无法从外部实例化该类
  PluginManager._privateConstructor();
  // 静态变量，保存类的唯一实例
  static final PluginManager _instance = PluginManager._privateConstructor();

  // 提供公共的静态方法来获取类的唯一实例
  factory PluginManager() {
    print("初始化");
    // 初始化管理器
    _initial();
    return _instance;
  }

  /*
  初始化管理器
   */
  static _initial() {}

  /*
   实例化一个注入器
   用法:
   */
  PluginInsertPointManager pluginInjector = PluginInsertPointManager();

  /*
  从存储中加载插件列表
   */
  loadPluginFromStore() {
    List<PluginModel> pluginModels = getPluginListInHive();

    pluginModels.forEach((pluginModel) {
      //
    });
  }

  // 存储已注册的插件
  List<Plugin> _registeredPlugins = [];

  /*
  注册插件
   */
  void registerPlugin(Plugin plugin) {
    _registeredPlugins.add(plugin);
    plugin.registerPlugin();
  }

  /*
  注销插件
   */
  void unregisterPlugin(String id) {
    print("注销插件: id=$id");
    _registeredPlugins.removeWhere((plugin) => plugin.id == id);
  }

  /*
  获取已注册的插件
   */
  Plugin? getPlugin(String id) {
    for (var plugin in _registeredPlugins) {
      if (plugin.id == id) {
        return plugin;
      }
    }
    return null;
  }

  /*
  初始化所有已注册的插件
   */
  void initialAll() {
    print("初始化所有插件");
    for (var plugin in _registeredPlugins) {
      plugin.initial();
    }
  }

  /*
  获取所有已注册的插件
   */
  List<Plugin> getRegisterPlugins() {
    return _registeredPlugins;
  }

  /*
  根据提供的pluginType获取所有插件
   */
  List<Plugin> getPluginsByType(PluginType pluginType) {
    return _registeredPlugins.where((plugin) {
      if (plugin.type == pluginType) return true;
      return false;
    }).toList();
  }

  /*
  释放所有已注册插件
   */
  void disposeAll() {
    print("释放全局插件");
    _registeredPlugins.forEach((plugin) {
      // 释放
      plugin.dispose();
    });
    _registeredPlugins.clear();
  }
}
