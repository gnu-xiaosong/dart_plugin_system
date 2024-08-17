/*
 * 名称: 插件开发入口
 * 描述: 这是基于dart_eval的纯dart语言的插件开发系统，让开发者仅需掌握基本dart_eval使用规范和要求就能轻易集成到自己dart项目中
 , 轻松完成code pull, 功能模块动态拓展等业务场景。后续会开发拓展到flutter项目中。
 * 作者: xskj
 * version: v1.0.0
 * github: https://github.com/gnu-xiaosong
 * 创建日期: 2024-08-16
 * @parameters:
     dataModel    dynamic    插件所需要处理的数据模型对象，可自定义，也可使用官方编写好的常用数据体封装模型
     callback     FUnction   回调函数，主要用途为，方便扩展实现在Eval环境中不支持的功能业务场景，比如执行第三方拓展包的功能
                             使用步骤:
                             * 1. 在插件注入点定义callback回调函数理逻辑，以便编写插件时直接在Eval环境中调用即可。
                             * 2. 在插件脚本[即本文件]中根据业务需求调用即可
 * @return:
     dataModel    dynamic/null   返回参数为输入参数数据封装模型类型，可为空[具体区别参见系统设计部分文档]
 * 构建: 对于插件的构建方式有两种方式：
          1. 源代码: 导入.dart的源代码文件, 运行时编译，不推荐, 速度慢，影响性能
          2. evc字节码: 先将源代码编译成evc字节码，在dart运行时直接执行，推荐，速度较快，具体构建evc字节码参见文档构建evc部分，或者阅读dart_eval文档
 * 其他说明: 为了方便开发者专注于业务场景的实现，本插件系统已实现了两种构建方式，具体使用参见【构建部分】，直接使用相关插件模版即可快速开发
 * 注意: 在使用插件系统开发时,一定要注意插件的版本对应!!
 * 调试：为了方便开发者熟悉插件的执行流程, 在xxx文件夹内有个xxx测试用例，供开发者调试
 */

// 导入Eval环境中会用到的相关类: 提示在ide中会报错，不用管
import 'package:plugin_system/bridge.dart';

/*
插件的入口函数: 名称不能修改
 */
entry(dynamic dataModel, Function? callback) {
  /// .................插件的业务实现............................
  /// 返回值说明：
  /// 如果没有返回值则请返回 null
  /// 否则请使用定义好的数据类模型进行封装再返回并且输入数据与输出数据模型类应当统一，以便插件的链式操作处理

  // 使用数据体进行重新封装: 一定要重新封装
  FunctionalityPluginDataModel data = FunctionalityPluginDataModel(
      id: dataModel.id, name: dataModel.name, payload: dataModel.payload);
  print("In the eval environment input data: ${data.toMap()}");

  // 返回数据类型为数据封装体模型的包装类warp, 带$的, 例如: $FunctionalityPluginDataModel
  return dataModel ?? null;
}
