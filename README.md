# 文档笔记

## dart_eval
可扩展的 Dart 语言字节码编译器和解释器，用 Dart 编写，支持 Flutter 和 Dart AOT 的动态执行和 codepush
* 目标: 与真实的 Dart 代码互操作
* 
### 特性
* 真实的 Dart中创建的类可以通过包装器dart_eval在解释器内部使用，而在解释器中创建的类可以通过创建接口和桥接类在解释器外部使用
* 缺少生成器、集合和扩展方法等功能
* 部分标准库尚未实现

### 基本用法
```dart
import 'package:dart_eval/dart_eval.dart';

void main() {
  print(eval('2 + 2')); // -> 4
  
  final program = r'''
      class Cat {
        Cat(this.name);
        final String name;
        String speak() => "I'm $name!";
      }
      String main() {
        final cat = Cat('Fluffy');
        return cat.speak();
      }
  ''';
  
  print(eval(program, function: 'main')); // prints 'I'm Fluffy!'
}
```

#### 从dart_eval中调用并传参规则
* 传递给 dart_eval 的参数包装在$Value 包装器中，例如$String或$Map
* 这些“装箱类型”包含有关它们是什么以及如何修改它们的信息，并且你可以使用属性访问它们的底层值$value。但是，**整数、双精度数、布尔值和列表**被视为原语，当函数签名中指定了它们的确切类型时，应在不包装的情况下传递它们：
```dart
final program = '''
  int main(int count, String str) {
    return count + str.length;
  }
''';
print(eval(program, function: 'main', args: [1, $String('Hi!')])); // -> 4
```
>>> 当从外部调用函数或构造函数时，必须按顺序指定所有参数 - 甚至是可选参数和命名参数，使用 null 表示没有参数（而 $null() 表示空值）

#### 在dart_eval中调用真实dart中中调用并传参规则

###### 例子
```dart
import 'package:dart_eval/dart_eval.dart';
import 'package:dart_eval/dart_eval_bridge.dart';

void main() {
  final program = '''
    void main(Function callback) {
      callback('Hello');
    }
  ''';

  eval(program, function: 'main', args: [
    $Closure((runtime, target, args) {
      print(args[0]!.$value + '!');
      return null;
    })
  ]); // -> prints 'Hello!'
}
```
文档:https://pub.dev/packages/dart_eval

####### 插件系统开发推荐使用：桥接互操作（缺点：耗费性能)
Bridge interop 可实现最多的功能：dart_eval 不仅可以访问对象的字段，还可以进行扩展，从而允许您在 Eval 中创建子类并在 dart_eval 之外使用它们。例如，这可用于创建可在运行时动态更新的自定义 Flutter 小部件。Bridge interop 在某些方面也比创建包装器更简单，但它会以性能为代价，因此在性能敏感的情况下应避免使用。要使用 bridge interop，请扩展原始类和 mixin $Bridge：

```dart
// ** See previous example for the original class and imports **

/// This is our bridge class
class $Book$bridge extends Book with $Bridge<Book> {
  static final $type = ...; // See previous example
  static final $declaration = ...; // Previous example, but use bridge: true instead of wrap

  /// Recreate the original constructor
  $Book$bridge(super.pages);

  static $Value? $new(
    Runtime runtime, $Value? target, List<$Value?> args) {
    return $Book$bridge((args[0]!.$reified as List).cast());
  }

  @override
  $Value? $bridgeGet(String identifier) {
    if (identifier == 'getPage') {
      return $Function((_, target, args) {
        return $String(getPage(args[0]!.$value));
      });
    } 
    throw UnimplementedError('Unknown property $identifier');
  }

  @override
  $Value? $bridgeSet(String identifier) => 
    throw UnimplementedError('Unknown property $identifier');

  /// Override the original class' properties and methods
  @override
  String getPage(int index) => $_invoke('getPage', [$int(index)]);

  @override
  List<String> get pages => $_get('pages');
}

void main() {
  final compiler = Compiler();
  compiler.defineBridgeClass($Book$bridge.$declaration);
  
  final program = compiler.compile({'hello' : { 
    'main.dart': '''
      import 'book.dart';
      class MyBook extends Book {
        MyBook(List<String> pages) : super(pages);
        String getPage(int index) => 'Hello world!';
      }

      Book main() {
        final book = MyBook(['Hello world!', 'Hello again!']);
        return book;
      }
    '''
  }});

  final runtime = Runtime.ofProgram(program);
  runtime.registerBridgeFunc(
    'package:hello/book.dart', 'Book.', $Book$bridge.$new, bridge: true);

  // Now we can use the new book class outside dart_eval!
  final book = runtime.executeLib('package:hello/main.dart', 'main') 
    as Book;
  print(book.getPage(1)); // -> 'Hello world!'
}
```


或者采用插件模式
重写evalPluign类