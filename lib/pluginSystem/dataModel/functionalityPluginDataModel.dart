/*
插件类型为Functionality的插件数据模型类
 */
import 'package:dart_plugin_system/pluginSystem/dataModel/PluginDataModel.dart';
import 'package:eval_annotation/eval_annotation.dart';

@Bind()
class FunctionalityPluginDataModel extends PluginDataModel {
  /*
  实例化
   */
  FunctionalityPluginDataModel(
      {required super.id, required super.name, required super.payload});

  /*
  其他拓展方法
   */
}
