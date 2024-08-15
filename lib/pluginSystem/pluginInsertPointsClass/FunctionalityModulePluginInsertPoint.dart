/*
功能拓展模块插件Functionality注入点类
 */

import 'package:dart_eval/dart_eval.dart';
import 'package:dart_eval/stdlib/core.dart';
import '../Plugin.dart';
import '../PluginManager.dart';
import '../PluginType.dart';
import '../common.dart';
import '../pluginInsert/PluginInsertPoint.dart';
import '../pluginInsert/PluginInsertPointType.dart';

class FunctionalityModulePluginInsertPoint
    with PluginCommon
    implements PluginInsertPoint {
  late PluginManager pluginManager;

  FunctionalityModulePluginInsertPoint({
    ConPluginType? conPluginType,
  })  : _pluginConnType = conPluginType ?? ConPluginType.series,
        pluginManager = PluginManager();

  /*
  实现存在的Functionality模块插件列表
   */
  @override
  List<Plugin> get pluginAll => getAllModulePlugin();

  /*
  实现插件的类型:
   */
  @override
  PluginType get type => PluginType.Functionality;

  /*
  私有变量
   */
  ConPluginType _pluginConnType = ConPluginType.series;

  /*
  实现插件连接类型
   */
  @override
  ConPluginType get pluginConnType => _pluginConnType;

  /*
  初始化
   */

  /*
  获取对应地所有插件
   */
  @override
  List<Plugin> getAllModulePlugin() {
    return pluginManager.getRegisterPlugins().where((plugin) {
      // 筛选出该模块插件类型的插件
      if (plugin.type == PluginType.Functionality) return true;
      return false;
    }).toList();
  }

  /*
  运行函数实现接口: 带设置是否带参数
   */
  @override
  dynamic run(dynamic inputData) {
    print("runnig: pluginType =$type  pluginConnType = $pluginConnType");
    print("data: $inputData");
    // 输入数据装饰
    inputData = inputDataHandler(inputData);
    print("input data handler result: $inputData");
    // 输出数据
    late dynamic outputData;

    // 判断插件连接类型
    switch (pluginConnType) {
      case ConPluginType.series:
        outputData = runSeries(inputData);
        break;
      case ConPluginType.parallel:
        outputData = runParallel(inputData);
        break;
    }

    // 输出数据处理
    outputData = outputDataHandler(outputData);
    print("output data handler result: $outputData");

    return outputData;
  }

  /*
  运行串联运行函数
   */
  dynamic runSeries(dynamic data) {
    // 循环遍历执行脚本程序
    pluginAll.forEach((plugin) {
      print(
          "------------plugin: ${plugin.name} evc=${plugin.evc}  path=${plugin.path}-----------------");
      print("data: $data");
      // 获取文件leiixng
      bool evc = plugin.evc;
      // 获取文件路径
      String path = plugin.path;

      // 调用执行脚本函数
      dynamic outData = execScript(evc: evc, path: path, data: data);
      print("outputData: $outData");

      // 判断输出数据是否为null: 串联
      if (outData != null) data = outData;
    });

    print("final output data: ${data}");
    // 数据统一封装
    return data;
  }

  /*
  运行并联运行函数: 默认执行插件列表的第一个，因此只需要排列插件列表顺序即可
   */
  dynamic runParallel(dynamic data) {
    if (pluginAll.isEmpty) {
      // 为空：无插件
      print("plugin list is empty or not plugin is load!");
    } else {
      // 存在注册插件

      // 获取目标plugin
      Plugin plugin = pluginAll.first;
      print(
          "------------plugin: ${plugin.name} evc=${plugin.evc}  path=${plugin.path}-----------------");
      print("input data:$data");

      // 获取文件leiixng
      bool evc = plugin.evc;

      // 获取文件路径
      String path = plugin.path;

      // 调用执行脚本函数
      dynamic outData = execScript(evc: evc, path: path, data: data);
      print("output data: $outData");

      // 判断输出数据是否为null: 串联
      if (outData != null) data = outData;
    }

    return data;
  }

  /*
  执行脚本程序
  @parameter:
    data  dynamic 输入数据
    path  脚本路径
    evc   是否为evc字节码文件
   */
  dynamic execScript(
      {required String path, bool evc = false, required dynamic data}) {
    print("start exec script........");
    late dynamic outputData;
    // 判定文件类型
    if (evc) {
      // evc文件
      print("执行文件类型: evc");
      outputData = "执行文件类型: evc";
    } else {
      print("执行文件类型: dart");
      // dart文件
      String? program = readFileContent(path);

      outputData = eval(program!, function: 'entry', args: [$String(data)]);
    }

    return outputData;
  }

  /*
  输入数据处理装饰函数
   */
  @override
  dynamic inputDataHandler(dynamic data) {
    print("inputDataHandler.........");
    return data;
  }

  /*
  输出数据处理装饰函数
   */
  @override
  dynamic outputDataHandler(dynamic data) {
    print("outputDataHandler.........");
    return data;
  }

  @override
  initial() {
    print("初始化FunctionalityModule");
  }
}
