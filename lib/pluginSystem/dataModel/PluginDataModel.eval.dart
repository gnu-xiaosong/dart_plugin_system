import 'package:dart_eval/dart_eval.dart';
import 'package:dart_eval/dart_eval_bridge.dart';
import 'PluginDataModel.dart';
import 'package:dart_eval/stdlib/core.dart';

/// dart_eval wrapper binding for [PluginDataModel]
class $PluginDataModel implements $Instance {
  /// Configure this class for use in a [Runtime]
  static void configureForRuntime(Runtime runtime) {
    runtime.registerBridgeFunc('package:plugin_system/bridge.dart',
        'PluginDataModel.', $PluginDataModel.$new);

    runtime.registerBridgeFunc('package:plugin_system/bridge.dart',
        'PluginDataModel.fromJson', $PluginDataModel.$fromJson);

    runtime.registerBridgeFunc('package:plugin_system/bridge.dart',
        'PluginDataModel.fromMap', $PluginDataModel.$fromMap);
  }

  /// Compile-time type declaration of [$PluginDataModel]
  static const $type = BridgeTypeRef(
    BridgeTypeSpec(
      'package:plugin_system/bridge.dart',
      'PluginDataModel',
    ),
  );

  /// Compile-time class declaration of [$PluginDataModel]
  static const $declaration = BridgeClassDef(
    BridgeClassType(
      $type,
      isAbstract: false,
    ),
    constructors: {
      '': BridgeConstructorDef(
        BridgeFunctionDef(
          returns: BridgeTypeAnnotation($type),
          namedParams: [
            BridgeParameter(
              'id',
              BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.string)),
              true,
            ),
            BridgeParameter(
              'name',
              BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.string)),
              true,
            ),
            BridgeParameter(
              'payload',
              BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.map)),
              true,
            ),
          ],
          params: [],
        ),
        isFactory: false,
      ),
      'fromJson': BridgeConstructorDef(
        BridgeFunctionDef(
          returns: BridgeTypeAnnotation($type),
          namedParams: [],
          params: [
            BridgeParameter(
              'source',
              BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.string)),
              true,
            ),
          ],
        ),
        isFactory: true,
      ),
      'fromMap': BridgeConstructorDef(
        BridgeFunctionDef(
          returns: BridgeTypeAnnotation($type),
          namedParams: [],
          params: [
            BridgeParameter(
              'map',
              BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.map)),
              true,
            ),
          ],
        ),
        isFactory: true,
      ),
    },
    methods: {
      'toJson': BridgeMethodDef(
        BridgeFunctionDef(
          returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.string)),
          namedParams: [],
          params: [],
        ),
      ),
      'toMap': BridgeMethodDef(
        BridgeFunctionDef(
          returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.map)),
          namedParams: [],
          params: [],
        ),
      ),
    },
    getters: {},
    setters: {},
    fields: {
      'id': BridgeFieldDef(
        BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.string)),
        isStatic: false,
      ),
      'name': BridgeFieldDef(
        BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.string)),
        isStatic: false,
      ),
      'payload': BridgeFieldDef(
        BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.map)),
        isStatic: false,
      ),
    },
    wrap: true,
  );

  /// Wrapper for the [PluginDataModel.new] constructor
  static $Value? $new(Runtime runtime, $Value? thisValue, List<$Value?> args) {
    return $PluginDataModel.wrap(
      PluginDataModel(
          id: args[0]!.$value, name: args[1]!.$value, payload: args[2]!.$value),
    );
  }

  /// Wrapper for the [PluginDataModel.fromJson] constructor
  static $Value? $fromJson(
      Runtime runtime, $Value? thisValue, List<$Value?> args) {
    return $PluginDataModel.wrap(
      PluginDataModel.fromJson(args[0]!.$value),
    );
  }

  /// Wrapper for the [PluginDataModel.fromMap] constructor
  static $Value? $fromMap(
      Runtime runtime, $Value? thisValue, List<$Value?> args) {
    return $PluginDataModel.wrap(
      PluginDataModel.fromMap(args[0]!.$value),
    );
  }

  final $Instance _superclass;

  @override
  final PluginDataModel $value;

  @override
  PluginDataModel get $reified => $value;

  /// Wrap a [PluginDataModel] in a [$PluginDataModel]
  $PluginDataModel.wrap(this.$value) : _superclass = $Object($value);

  @override
  int $getRuntimeType(Runtime runtime) => runtime.lookupType($type.spec!);

  @override
  $Value? $getProperty(Runtime runtime, String identifier) {
    switch (identifier) {
      case 'id':
        final _id = $value.id;
        return $String(_id);

      case 'name':
        final _name = $value.name;
        return $String(_name);

      case 'payload':
        final _payload = $value.payload;
        return $Map.wrap(_payload);
      case 'toJson':
        return __toJson;

      case 'toMap':
        return __toMap;
    }
    return _superclass.$getProperty(runtime, identifier);
  }

  static const $Function __toJson = $Function(_toJson);
  static $Value? _toJson(Runtime runtime, $Value? target, List<$Value?> args) {
    final self = target as $PluginDataModel;
    final result = self.$value.toJson();
    return $String(result);
  }

  static const $Function __toMap = $Function(_toMap);
  static $Value? _toMap(Runtime runtime, $Value? target, List<$Value?> args) {
    final self = target as $PluginDataModel;
    final result = self.$value.toMap();
    return $Map.wrap(result);
  }

  @override
  void $setProperty(Runtime runtime, String identifier, $Value value) {
    return _superclass.$setProperty(runtime, identifier, value);
  }
}
