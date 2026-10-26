abstract class Meter {
  Meter({required this.id, required this.start, required this.end});

  final String id;
  final double start;
  final double end;

  double get consumed => end - start;

  double cost(double tariff);
}

class GeneratorMeter extends Meter {
  GeneratorMeter(
    String id,
    double start,
    double end, {
    required this.fuelLitres,
  }) : super(id: id, start: start, end: end);

  final double fuelLitres;

  @override
  double cost(double tariff) => consumed * tariff;

  double? get kwhPerLitre => fuelLitres == 0 ? null : consumed / fuelLitres;
}

void main() {
  final g = GeneratorMeter('G-102', 15200, 15640, fuelLitres: 140);

  print('${g.consumed} kWh, cost \$${g.cost(12.0)} IQD');
  print('efficiency ${g.kwhPerLitre?.toStringAsFixed(2) ?? 'n/a'} kWh/L');
}
