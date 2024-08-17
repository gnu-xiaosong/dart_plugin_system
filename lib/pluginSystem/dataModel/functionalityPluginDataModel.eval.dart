import 'package:dart_eval/dart_eval.dart';
import 'package:dart_eval/dart_eval_bridge.dart';
import 'PluginDataModel.eval.dart';
import 'functionalityPluginDataModel.dart';

/// dart_eval wrapper binding for [FunctionalityPluginDataModel]
class $FunctionalityPluginDataModel implements $Instance {
  /// Configure this class for use in a [Runtime]
  static void configureForRuntime(Runtime runtime) {
    runtime.registerBridgeFunc('package:plugin_system/bridge.dart',
        'FunctionalityPluginDataModel.', $FunctionalityPluginDataModel.$new);
  }

  /// Compile-time type declaration of [$FunctionalityPluginDataModel]
  static const $type = BridgeTypeRef(
    BridgeTypeSpec(
      'package:plugin_system/bridge.dart',
      'FunctionalityPluginDataModel',
    ),
  );

  /// Compile-time class declaration of [$FunctionalityPluginDataModel]
  static const $declaration = BridgeClassDef(
    BridgeClassType(
      $type,
      isAbstract: false,
      $extends: BridgeTypeRef(BridgeTypeSpec(
          'package:plugin_system/bridge.dart', 'PluginDataModel')),
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
    },
    methods: {},
    getters: {},
    setters: {},
    fields: {},
    wrap: true,
  );

  /// Wrapper for the [FunctionalityPluginDataModel.new] constructor
  static $Value? $new(Runtime runtime, $Value? thisValue, List<$Value?> args) {
    return $FunctionalityPluginDataModel.wrap(
      FunctionalityPluginDataModel(
          id: args[0]!.$value, name: args[1]!.$value, payload: args[2]!.$value),
    );
  }

  final $Instance _superclass;

  @override
  final FunctionalityPluginDataModel $value;

  @override
  FunctionalityPluginDataModel get $reified => $value;

  /// Wrap a [FunctionalityPluginDataModel] in a [$FunctionalityPluginDataModel]
  $FunctionalityPluginDataModel.wrap(this.$value)
      : _superclass = $PluginDataModel.wrap($value);

  @override
  int $getRuntimeType(Runtime runtime) => runtime.lookupType($type.spec!);

  @override
  $Value? $getProperty(Runtime runtime, String identifier) {
    return _superclass.$getProperty(runtime, identifier);
  }

  @override
  void $setProperty(Runtime runtime, String identifier, $Value value) {
    return _superclass.$setProperty(runtime, identifier, value);
  }
}
