/*
插件注入点管理
 */

import 'package:dart_plugin_system/pluginSystem/PluginType.dart';
import 'package:dart_plugin_system/pluginSystem/pluginInsert/PluginCategory.dart';
import 'package:dart_plugin_system/pluginSystem/pluginInsertPointsClass/FunctionalityModulePluginInsertPoint.dart';

class PluginInsertPointManager {
  // 运行插件类型: 默认类型Functionality
  PluginType pluginType = PluginType.Functionality;

  // 运行插件的类别: 默认类别Integration
  PluginCategory pluginCategory = PluginCategory.Integration;

  // 输入注入器数据
  dynamic data;

  /*
   运行函数
   参数:
      data            dynamic                  封装传入的数据
   */
  dynamic run() {
    // 输出数据
    late dynamic outputData;

    /*
    根据传入参数确定插件类型
     */
    switch (pluginType) {
      case PluginType.Functionality:
        /*
        模块化流程化处理类型
         */
        // 1.实例化FunctionalityModule类型插件注入点
        FunctionalityModulePluginInsertPoint
            functionalityModulePluginInsertPoint =
            FunctionalityModulePluginInsertPoint();
        // 2.注入点模块初始化
        functionalityModulePluginInsertPoint.initial();
        // 3.调用对应的运行函数
        outputData = functionalityModulePluginInsertPoint.run(data);
        break;
      case PluginType.Integration:
        /*
        继承类型
         */
        break;
      case PluginType.UI:
        break;
      case PluginType.Security:
        break;
      case PluginType.Analytics:
        break;
      case PluginType.ContentManagement:
        break;
      case PluginType.DevelopmentTools:
        break;
      case PluginType.Automation:
        break;
      case PluginType.DataProcessing:
        break;
      case PluginType.Communication:
        break;
      case PluginType.miniApp:
        break;
    }

    return outputData;
  }
}
