import 'dart:async';
import 'dart:math';

final rnd = Random();

double readSensor() => 220 + rnd.nextDouble() * 10;

Future<void> producer(StreamController<double> out) async {
  for (var i = 0; i < 5; i++) {
    out.add(readSensor());
    await Future.delayed(const Duration(milliseconds: 200));
  }

  await out.close();
}

Future<void> consumer(StreamController<double> controller) async {
  await for (final value in controller.stream) {
    print('Sensor: ${value.toStringAsFixed(1)} V');
  }

  print('Consumer finished');
}

Future<void> main() async {
  final controller = StreamController<double>();

  await Future.wait([producer(controller), consumer(controller)]);
}
