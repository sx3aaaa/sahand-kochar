mixin Swimmer {
  void swim() => print('$runtimeType is swimming');
}

mixin Flyer {
  int altitude = 0;

  void fly() {
    altitude += 100;
    print('$runtimeType files at $altitude m');
  }
}

class Animal {
  final String name;
  Animal(this.name);
}

class Duck extends Animal with Swimmer, Flyer {
  Duck() : super('Duck');
}

class Fish extends Animal with Swimmer {
  Fish() : super('Duck');
}

void main() {
  Duck()..swim()..fly();
  Fish()..swim();
}








