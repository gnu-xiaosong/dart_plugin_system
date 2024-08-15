import 'package:plugin_system/bridge.dart';

class MyWorldTimeTracker extends WorldTimeTracker {
  MyWorldTimeTracker();

  static TimestampedTime _currentTimeWithOffset(int offset) {
    return TimestampedTime(DateTime.now().millisecondsSinceEpoch,
        timezoneOffset: offset);
  }

  @override
  TimestampedTime getTimeFor(String country) {
    final countries = <String, TimestampedTime>{
      'USA': _currentTimeWithOffset(4),
      'UK': _currentTimeWithOffset(6),
    };

    return countries[country];
  }
}

/*
入口函数:
输入数据： data实例化桥接类, 这里数据对象类需要根据不同业务场景实现，但可以抽象成一个接口，拱具体实现，
注意由于数据模型类需要在eval中调用，因此要符合规范
输出数据:  正常为同输入统一桥接类
 */
dynamic entry(dynamic dataModel) {
  /// .................插件的业务实现...............
  /// 返回值说明：
  /// 如果没有返回值则请返回 null
  /// 否则请使用定义好的数据类模型进行封装再返回并且输入数据与输出数据模型类应当统一，以便插件的链式操作处理
}
