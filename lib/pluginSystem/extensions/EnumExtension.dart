/*
枚举的拓展
 */

import '../PluginType.dart';
import '../pluginInsert/PluginCategory.dart';

/*
PluginType枚举类型拓展
 */
extension PluginTypeEnumExtension on PluginType {
  // 将整数索引转换为 PluginType 值
  static PluginType fromIndex(int index) {
    if (index < 0 || index >= PluginType.values.length) {
      throw ArgumentError('Invalid index: $index');
    }
    return PluginType.values[index];
  }

  // 获取枚举的字符串名称
  String get name => toString().split('.').last;
}

/*
PluginType枚举类型拓展
 */
extension PluginCategoryEnumExtension on PluginCategory {
  // 将整数索引转换为 PluginType 值
  static PluginCategory fromIndex(int index) {
    print("================================================");
    print("index=$index  enum=${PluginCategory.values[index]}");
    if (index < 0 || index >= PluginCategory.values.length) {
      throw ArgumentError('Invalid index: $index');
    }
    return PluginCategory.values[index];
  }

  // 获取枚举的字符串名称
  String get name => toString().split('.').last;
}
