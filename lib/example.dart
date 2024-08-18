import 'dart:io';
import 'package:dart_plugin_system/pluginSystem/PluginManager.dart';
import 'package:dart_plugin_system/pluginSystem/PluginType.dart';
import 'package:dart_plugin_system/pluginSystem/dataModel/functionalityPluginDataModel.dart';
import 'package:dart_plugin_system/pluginSystem/plugin/FunctionalityPlugin.dart';
import 'package:dart_plugin_system/pluginSystem/pluginInsert/PluginCategory.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'pluginSystem/storeData/ServerStoreDataPlugin.dart';

main() async {
  // 初始化Hive
  // 获取当前执行环境的路径
  final String directory = Directory.current.path;
  // 初始化Hive，设置存储路径
  Hive.init(directory);
  // 注册调制器
  // Hive.registerAdapter(PluginModelAdapter());
  // 初始化持久化存储插件列表
  await ServerStoreDataPlugin.initialize();

  // 实例化一个插件管理器实例单例对象
  PluginManager pluginManager = PluginManager();

  // ************************前置操作：注册插件 and 初始化插件************************************
  print("注册和初始化插件完成");

  // 实例化中间处理模块化插件 继承至Plugin类
  FunctionalityPlugin functionalityPlugin = FunctionalityPlugin(
      category: PluginCategory.Integration,
      evc: false,
      path:
          "D:\\ProjectDevelopment\\plugin_system\\dart_plugin_system\\assets\\plugin\\pluginName_plugin.dart",
      name: "testPlugin");

  // 注册插件
  pluginManager.registerPlugin(functionalityPlugin);

  /*
  插件初始化:
  1.方式一：仅初始化该插件
  2.方式二: 初始化所有已注册插件：包括方式1和2
   */
  functionalityPlugin.initial(); // 方式1 推荐
  // pluginManager.initialAll(); // 方式2

  // 插件流程化测试
  {
    // 步骤一: 原料
    String a = "石材";
    print("-------------step 1: $a");

    // 步骤二: 中间产物(插件化) 注入点
    /// 一行代码即可使用插件
    print("-------------step 2");
    pluginManager.pluginInjector // 获取注入器
      ..pluginType = PluginType.Functionality // 设置插件类型
      ..pluginCategory = PluginCategory.Integration // 设置插件类别
      ..data = FunctionalityPluginDataModel(
          id: Uuid().v4(),
          name: "测试数据",
          payload: {"id": "test", "name": "hello word"})
      ..callback = (args) {
        // args传递过来的参数: 依次为args[0]、args[1].....
        // 需要使用工具函数getValueFrom$Value来结构出value值
        final firstValue = pluginManager.getValueFrom$Value(args, index: 0);
        print("回调处理: ${firstValue} - 第三方: ${Uuid().v4()}");
      }
      ..inputDataHandler = (data) {
        // 数据输入插件系统处理回调函数: 不处理应返回原数据
        print("输入数据处理");
        return data;
      }
      ..outputDataHandler = (data) {
        // 数据输出插件系统处理回调函数: 不处理应返回原数据
        print("输出数据处理");
        return data;
      }
      ..run(); // 运行注入器

    // 步骤三: 成品
    String c = "房子";
    print("-------------step 3: $c");
  }

  // *******************exit application***************************
  print("存储的插件列表: ${ServerStoreDataPlugin.getPluginListInHive()}");
  print("释放插件成功");
  // 释放插件
  functionalityPlugin.dispose();
  pluginManager.disposeAll();
}
