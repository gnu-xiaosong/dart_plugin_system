/*
包装器/桥接类
 */

/*
入口函数:
输入数据： data实例化桥接类, 这里数据对象类需要根据不同业务场景实现，但可以抽象成一个接口，拱具体实现，
注意由于数据模型类需要在eval中调用，因此要符合规范
@参数:
输出数据dataModel:  正常为同输入统一桥接类
回调函数callback:   用于执行Eval环境受限的外部的真实dart指令, 用于Eval环境主动发起调用, 真实dart环境的回调函数由具体注入点(注入点不同则一般回调逻辑也不同)来实现
 */
dynamic entry(dynamic dataModel, Function? callback) {
  /// .................插件的业务实现...............
  /// 返回值说明：
  /// 如果没有返回值则请返回 null
  /// 否则请使用定义好的数据类模型进行封装再返回并且输入数据与输出数据模型类应当统一，以便插件的链式操作处理
  print("in Eval: ");
  print(dataModel.toString());
  return dataModel ?? null;
}
