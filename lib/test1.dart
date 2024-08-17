import 'package:dart_eval/dart_eval.dart';
import 'package:dart_eval/dart_eval_bridge.dart';
import 'package:dart_eval/stdlib/core.dart';

import 'lib.dart';

// ** Main code **

void main(List<String> args) {
  final source = '''
    import 'package:example1/bridge.dart';
    
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

  // Create a compiler and define the classes' bridge declarations so it knows their structure
  final compiler = Compiler();

  // 桥接类
  compiler.defineBridgeClasses(
      [$TimestampedTime.$declaration, $WorldTimeTracker$bridge.$declaration]);

  // Compile the source code into a Program containing metadata and bytecode.
  // In a real app, you could also compile the Eval code separately and output
  // it to a file using program.write().
  final program = compiler.compile({
    'example': {'main.dart': source}
  });

  // Create a runtime from the compiled program, and register bridge functions
  // for all static methods and constructors. Default constructors use
  // "ClassName." syntax.
  final runtime = Runtime.ofProgram(program)
    ..registerBridgeFunc('package:example1/bridge.dart', 'TimestampedTime.',
        $TimestampedTime.$new)
    // 桥接类
    ..registerBridgeFunc('package:example1/bridge.dart', 'WorldTimeTracker.',
        $WorldTimeTracker$bridge.$new,
        isBridge: true);

  // Call the function and cast the result to the desired type
  final timeTracker = runtime.executeLib(
    'package:example/main.dart',
    'fn',
    // Wrap args in $Value wrappers except int, double, bool, and List
    [$String('USA')],
  ) as WorldTimeTracker;

  // We can now utilize the returned bridge class
  print('UK timezone offset: ${timeTracker.getTimeFor('UK').timezoneOffset}'
      ' (from outside Eval!)');
}
