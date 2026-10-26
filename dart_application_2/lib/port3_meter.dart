import 'dart:isolate';
import 'dart:math' as math;

class Stats {
  const Stats(this.min, this.max, this.mean, this.sd);

  final double min;
  final double max;
  final double mean;
  final double sd;

  @override
  String toString() =>
      'min ${min.toStringAsFixed(1)}, max ${max.toStringAsFixed(1)}, '
      'mean ${mean.toStringAsFixed(2)}, sd ${sd.toStringAsFixed(2)}';
}

Stats computeStats(List<double> xs) {
  if (xs.isEmpty) {
    throw ArgumentError.value(xs, 'xs', 'Must contain at least one sample');
  }

  var min = double.infinity;
  var max = double.negativeInfinity;
  var sum = 0.0;
  var sq = 0.0;

  for (final x in xs) {
    if (x < min) min = x;
    if (x > max) max = x;
    sum += x;
    sq += x * x;
  }

  final mean = sum / xs.length;
  final sd = math.sqrt(math.max(0.0, sq / xs.length - mean * mean));
  return Stats(min, max, mean, sd);
}

Future<void> _onIsolate(List<double> samples) async {
  final sw = Stopwatch()..start();
  final result = await Isolate.run(() => computeStats(samples));
  sw.stop();

  print('Isolate.run: $result (${sw.elapsedMilliseconds} ms)');
}

Future<void> main() async {
  for (final size in [20000, 2000000]) {
    final samples = List<double>.generate(size, (i) => 220 + i % 100 / 10);

    final sw = Stopwatch()..start();
    final result = computeStats(samples);
    sw.stop();
    print(
      'Main isolate, $size samples: $result '
      '(${sw.elapsedMilliseconds} ms)',
    );

    await _onIsolate(samples);
    print('---');
  }
}
