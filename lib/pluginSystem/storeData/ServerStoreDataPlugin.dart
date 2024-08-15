import 'package:hive/hive.dart';
import 'PluginModel.dart';

class ServerStoreDataPlugin {
  late Box<PluginModel> plugins;

  /*
   初始化所有参数值
   */
  Future<void> initialHiveParameter() async {
    // 创建一个Box: PluginSystemBox
    plugins = await Hive.openBox<PluginModel>('PluginSystemBox');
  }

  /*
  获取插件模型列表
   */
  List<PluginModel> getPluginListInHive() {
    return plugins.values.toList();
  }

  /*
  异步添加插件信息到列表
   */
  Future<void> addPluginInfo(PluginModel pluginModel) async {
    try {
      await plugins.add(pluginModel);
    } catch (e) {
      print("Error adding plugin: $e");
    }
  }

  /*
  异步删除插件信息
  @parameter: id - 插件的唯一标识符
   */
  Future<void> deletePluginInfo(String id) async {
    try {
      final key = plugins.keys
          .firstWhere((key) => plugins.get(key)?.id == id, orElse: () => null);
      if (key != null) {
        await plugins.delete(key);
      } else {
        print("Plugin with id $id not found");
      }
    } catch (e) {
      print("Error deleting plugin: $e");
    }
  }

  /*
  异步更新插件信息
  @parameter: id - 插件的唯一标识符
  @parameter: updatedPlugin - 更新后的插件模型
   */
  Future<void> updatePluginInfo(String id, PluginModel updatedPlugin) async {
    try {
      final key = plugins.keys
          .firstWhere((key) => plugins.get(key)?.id == id, orElse: () => null);
      if (key != null) {
        await plugins.put(key, updatedPlugin);
      } else {
        print("Plugin with id $id not found");
      }
    } catch (e) {
      print("Error updating plugin: $e");
    }
  }
}
