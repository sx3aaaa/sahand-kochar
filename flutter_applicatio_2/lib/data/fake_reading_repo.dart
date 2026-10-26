import 'dart:async';

import 'model/reading.dart';

class FakeReadingRepo {
  FakeReadingRepo() {
    unawaited(loadInitialData());
  }

  final List<Reading> _items = <Reading>[];
  final StreamController<List<Reading>> _controller =
      StreamController<List<Reading>>.broadcast();

  Stream<List<Reading>> get readings => _controller.stream;

  Future<void> loadInitialData() async {
    await Future<void>.delayed(const Duration(seconds: 1));

    final seedReadings = <Reading>[
      Reading(
        id: 'r-1',
        assetId: 'G-102',
        kwh: 120.0,
        fuelPercent: 85,
        runHours: 1200,
        takenAt: DateTime.utc(2022, 2, 18, 8, 10),
        note: 'Normal operation',
        version: 1,
        syncState: SyncState.synced,
      ),
      Reading(
        id: 'r-2',
        assetId: 'G-102',
        kwh: 140.0,
        fuelPercent: 22,
        runHours: 1350,
        takenAt: DateTime.utc(2022, 2, 18, 9, 0),
        note: 'Low fuel',
        version: 1,
        syncState: SyncState.pending,
      ),
      Reading(
        id: 'r-3',
        assetId: 'S-204',
        kwh: 95.5,
        fuelPercent: 50,
        runHours: 330,
        takenAt: DateTime.utc(2022, 2, 18, 10, 15),
        note: 'Solar field stable',
        version: 2,
        syncState: SyncState.conflict,
      ),
    ];

    _items.addAll(seedReadings);
    _controller.add(List<Reading>.unmodifiable(_items));
  }

  Stream<List<Reading>> watchReadings() => _controller.stream;

  Future<void> addReading(Reading reading) async {
    _items.add(reading);
    _controller.add(List<Reading>.unmodifiable(_items));
  }

  Future<void> deleteReading(String id) async {
    _items.removeWhere((reading) => reading.id == id);
    _controller.add(List<Reading>.unmodifiable(_items));
  }

  Future<void> clear() async {
    _items.clear();
    _controller.add(const <Reading>[]);
  }

  Future<void> dispose() async {
    await _controller.close();
  }
}
