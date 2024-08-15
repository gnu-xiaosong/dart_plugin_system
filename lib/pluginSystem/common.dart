/*
公共函数
 */

import 'dart:io';

mixin PluginCommon {
  /*
  读取文件内容
   */
  String? readFileContent(String path) {
    // 指定文件路径
    var file = File(path);

    // 检查文件是否存在
    if (file.existsSync()) {
      // 读取文件内容
      String contents = file.readAsStringSync();

      // 输出文件内容
      return contents;
    } else {
      print('File does not exist at the specified path: $path');
    }
  }
}
