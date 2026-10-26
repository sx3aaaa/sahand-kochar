import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_2/data/model/asset.dart';
import 'package:flutter_application_2/data/model/reading.dart';

void main() {
  test('asset validation works', () {
    expect(Asset.isValidId('G-102'), isTrue);
    expect(Asset.isValidId('G-1024'), isFalse);
    expect(Asset.isValidId('D-1B0'), isFalse);
  });

  test('Reading model parses and validates values', () {
    final reading = Reading(
      id: 'r-1',
      assetId: 'G-102',
      kwh: 1520,
      fuelPercent: 18,
      runHours: 1520,
      takenAt: DateTime.utc(2022, 2, 18, 8, 10),
      note: 'Low fuel warning',
      version: 1,
      syncState: SyncState.pending,
    );

    expect(reading.isLowFuel, isTrue);
    expect(reading.assetId, 'G-102');
    expect(reading.syncState, SyncState.pending);

    final json = reading.toJson();
    expect(json['id'], 'r-1');
    expect(json['syncState'], 'pending');

    final restored = Reading.fromJson(json);
    expect(restored, equals(reading));
  });
}
