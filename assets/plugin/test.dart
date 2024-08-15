class Cat {
  Cat(this.name);
  final String name;
  String speak(String food) => "$name love food $food";
}

String entry(String food) {
  final cat = Cat('cat');
  return cat.speak(food);
}
