// ** 类定义 **
import 'package:dart_eval/dart_eval.dart';
import 'package:dart_eval/dart_eval_bridge.dart';
import 'package:dart_eval/dart_eval_extensions.dart';
import 'package:dart_eval/stdlib/core.dart';

class TimestampedTime {
  const TimestampedTime(this.utcTime, {this.timezoneOffset = 0});

  final int utcTime;
  final int timezoneOffset;
}

abstract class WorldTimeTracker {
  WorldTimeTracker();

  TimestampedTime getTimeFor(String country);
}

///为[TimestampedTime]创建一个包装器包装器是一种高性能的互操作
///当你不需要重写类时的解决方案
/// dart_eval虚拟机
class $TimestampedTime implements TimestampedTime, $Instance {
  ///创建一个wrap构造函数，它包装一个底层实例
  ///从[$Object]继承。
  $TimestampedTime.wrap(this.$value) : _superclass = $Object($value);

  ///定义该类的编译时类型引用。
  static final $type = BridgeTypeSpec(
    'package:example/bridge.dart',
    'TimestampedTime',
  ).ref;

  ///定义编译时的类声明并映射出所有的字段和
  ///编译器的方法。
  static final $declaration = BridgeClassDef(
    BridgeClassType($type),
    constructors: {
      //使用空字符串定义默认构造函数
      '': BridgeFunctionDef(returns: $type.annotate, params: [
        // 使用内置类型的参数可以使用[CoreTypes]
        'utcTime'.param(CoreTypes.int.ref.annotate)
      ], namedParams: [
        'timezoneOffset'.paramOptional(CoreTypes.int.ref.annotate)
      ]).asConstructor // 桥接构造函数函数定义
    },
    // 传递参数映射定义
    fields: {
      'utcTime': BridgeFieldDef(CoreTypes.int.ref.annotate),
      'timezoneOffset': BridgeFieldDef(CoreTypes.int.ref.annotate)
    },
    // 使用包装器
    wrap: true,
  );

  ///为所有静态方法和定义static [EvalCallableFunc]函数
  ///构造函数。这是用于默认构造函数的，也是运行时的
  ///将使用创建该类的实例。
  static $Value? $new(Runtime runtime, $Value? target, List<$Value?> args) {
    return $TimestampedTime.wrap(TimestampedTime(
      args[0]!.$value,
      timezoneOffset: args[1]?.$value ?? 0,
    ));
  }

  ///这个包装器包装的底层Dart实例
  @override
  final TimestampedTime $value;

  ///在大多数情况下[$reified]应该只返回[$value]，但是collection
  ///像列表这样的类型应该使用它来递归地具体化它们的内容。
  @override
  TimestampedTime get $reified => $value;

  ///虽然不是必需的，但是创建一个超类字段允许你继承
  ///基本属性从[$Object]，如==和hashCode。
  final $Instance _superclass;

  /// [$getProperty]是dart_eval如何访问包装器的属性和方法，
  ///把它们映射到这里。在默认情况下，退回到[_superclass]
  ///实现。对于方法，您将返回一个带有闭包的[$Function]。
  @override
  $Value? $getProperty(Runtime runtime, String identifier) {
    switch (identifier) {
      case 'utcTime':
        return $int($value.utcTime);
      case 'timezoneOffset':
        return $int($value.timezoneOffset);
      default:
        return _superclass.$getProperty(runtime, identifier);
    }
  }

  ///查找运行时类型ID
  @override
  int $getRuntimeType(Runtime runtime) => runtime.lookupType($type.spec!);

  ///使用[$setProperty]映射非final字段。我们这里没有，
  ///返回到Object实现。
  @override
  void $setProperty(Runtime runtime, String identifier, $Value value) {
    return _superclass.$setProperty(runtime, identifier, value);
  }

  ///最后，我们的标准[TimestampedTime]实现!重定向到
  ///包装[$value]的所有属性和方法的实现。
  @override
  int get timezoneOffset => $value.timezoneOffset;

  @override
  int get utcTime => $value.utcTime;
}

///不像[TimestampedTime]，我们需要子类化[WorldTimeTracker]。为此,
///我们可以使用桥类!
///
///桥类是灵活的，在某些方面比包装器更简单，但是
///它们有很多开销。在性能敏感的情况下尽量避免使用它们
///情况。
///
///因为[WorldTimeTracker]是抽象的，我们可以在这里实现它。
///如果它是一个具体类，你应该扩展它。
class $WorldTimeTracker$bridge
    with $Bridge<WorldTimeTracker>
    implements WorldTimeTracker {
  static final $type = BridgeTypeSpec(
    'package:example/bridge.dart',
    'WorldTimeTracker',
  ).ref;

  ///同样，我们为编译器映射出所有的字段和方法。
  static final $declaration = BridgeClassDef(
    BridgeClassType($type, isAbstract: true),
    constructors: {
      //虽然这个类是抽象的，但是我们现在需要定义
      //默认构造函数。
      '': BridgeFunctionDef(returns: $type.annotate).asConstructor
    },
    methods: {
      'getTimeFor': BridgeFunctionDef(
        returns: $TimestampedTime.$type.annotate,
        params: ['country'.param(CoreTypes.string.ref.annotate)],
      ).asMethod
    },
    bridge: true,
  );

  ///为所有静态方法和定义static [EvalCallableFunc]函数
  ///构造函数。这是用于默认构造函数的，也是运行时的
  ///将使用创建该类的实例。
  static $Value? $new(Runtime runtime, $Value? target, List<$Value?> args) {
    return $WorldTimeTracker$bridge();
  }

  /// [$bridgeGet]与[$getProperty]的工作方式不同——它只被调用
  ///如果Eval子类没有提供覆盖实现。
  @override
  $Value? $bridgeGet(String identifier) {
    // [WorldTimeTracker]是抽象的，所以如果我们没有覆盖它的所有
    //方法是错误。
    //如果它是具体的，这个实现看起来像[$getProperty]
    //除非你访问'super'上的字段和调用方法。
    throw UnimplementedError(
      'Cannot get property "$identifier" on abstract class WorldTimeTracker',
    );
  }

  @override
  void $bridgeSet(
    String identifier,
    $Value value,
  ) {
    /// Same idea here.
    throw UnimplementedError(
      'Cannot set property "$identifier" on abstract class WorldTimeTracker',
    );
  }

  ///在桥类中，用[$_invoke]覆盖所有字段和方法，
  /// [$_get]和[$_set]。这允许我们通过扩展来覆盖这些方法
  /// dart_eval中的类。
  @override
  TimestampedTime getTimeFor(String country) => $_invoke(
        'getTimeFor',
        [$String(country)],
      );
}

// ** main入口代码 **
void main1() {
  final source = '''
    import 'package:example/bridge.dart';
    
    class MyWorldTimeTracker extends WorldTimeTracker {
    
      MyWorldTimeTracker();
      
      static TimestampedTime _currentTimeWithOffset(int offset) {
        return TimestampedTime(DateTime.now().millisecondsSinceEpoch,
          timezoneOffset: offset);
      }
      
      @override
      TimestampedTime getTimeFor(String country) {
        final countries = <String, TimestampedTime> {
          'USA': _currentTimeWithOffset(4),
          'UK': _currentTimeWithOffset(6),
        };
      
        return countries[country];
      }
    }
    
    MyWorldTimeTracker fn(String country) {
      final timeTracker = MyWorldTimeTracker();
      final myTime = timeTracker.getTimeFor(country);
      
      print(country + ' timezone offset: ' + myTime.timezoneOffset.toString() + ' (from Eval!)');
      
      return timeTracker;
    }
  ''';

  // 包名
  String packetName = "plugin_system";

  //创建一个编译器并定义类的桥声明，以便它知道它们的结构
  final compiler = Compiler();
  compiler.defineBridgeClasses(
      [$TimestampedTime.$declaration, $WorldTimeTracker$bridge.$declaration]);

  //将源代码编译成包含元数据和字节码的程序。
  //在真正的应用程序中，你也可以单独编译Eval代码并输出
  //使用program.write()将其写入文件。
  final program = compiler.compile({
    packetName: {'main.dart': source}
  });

  //从编译后的程序创建一个运行时，并注册桥函数
  //所有静态方法和构造函数。默认构造函数使用
  // "ClassName."语法。
  final runtime = Runtime.ofProgram(program)
    ..registerBridgeFunc('package:example/bridge.dart', 'TimestampedTime.',
        $TimestampedTime.$new)
    ..registerBridgeFunc('package:example/bridge.dart', 'WorldTimeTracker.',
        $WorldTimeTracker$bridge.$new,
        isBridge: true);

  // 调用函数并将结果强制转换为所需的类型: 获取返回值
  final timeTracker = runtime.executeLib(
    'package:example/main.dart',
    'fn',
    //在$Value包装器中包装除int、double、bool和List之外的参数，直接传递
    [$String('USA')], // 传入参数
  ) as WorldTimeTracker;

  // 现在我们可以利用返回的桥类
  print('UK timezone offset: ${timeTracker.getTimeFor('UK').timezoneOffset}'
      ' (from outside Eval!)');
}
