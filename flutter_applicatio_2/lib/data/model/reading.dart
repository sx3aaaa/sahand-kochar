import 'package:flutter/foundation.dart';

enum SyncState { synced, pending, conflict }

@immutable
class Reading {
  const Reading({
    required this.id,
    required this.assetId,
    required this.kwh,
    required this.fuelPercent,
    required this.runHours,
    required this.takenAt,
    required this.note,
    required this.version,
    required this.syncState,
  }) : assert(kwh >= 0),
       assert(fuelPercent >= 0 && fuelPercent <= 100),
       assert(runHours >= 0),
       assert(version >= 0);

  final String id;
  final String assetId;
  final double kwh;
  final int fuelPercent;
  final int runHours;
  final DateTime takenAt;
  final String note;
  final int version;
  final SyncState syncState;

  bool get isLowFuel => fuelPercent < 20;

  factory Reading.fromJson(Map<String, Object?> json) => Reading(
    id: json['id'] as String,
    assetId: json['assetId'] as String,
    kwh: (json['kwh'] as num).toDouble(),
    fuelPercent: json['fuelPercent'] as int,
    runHours: json['runHours'] as int,
    takenAt: DateTime.parse(json['takenAt'] as String),
    note: json['note'] as String? ?? '',
    version: json['version'] as int? ?? 1,
    syncState: SyncState.values.byName(
      json['syncState'] as String? ?? SyncState.synced.name,
    ),
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'assetId': assetId,
    'kwh': kwh,
    'fuelPercent': fuelPercent,
    'runHours': runHours,
    'takenAt': takenAt.toIso8601String(),
    'note': note,
    'version': version,
    'syncState': syncState.name,
  };

  Reading copyWith({
    String? id,
    String? assetId,
    double? kwh,
    int? fuelPercent,
    int? runHours,
    DateTime? takenAt,
    String? note,
    int? version,
    SyncState? syncState,
  }) {
    return Reading(
      id: id ?? this.id,
      assetId: assetId ?? this.assetId,
      kwh: kwh ?? this.kwh,
      fuelPercent: fuelPercent ?? this.fuelPercent,
      runHours: runHours ?? this.runHours,
      takenAt: takenAt ?? this.takenAt,
      note: note ?? this.note,
      version: version ?? this.version,
      syncState: syncState ?? this.syncState,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Reading &&
          id == other.id &&
          assetId == other.assetId &&
          kwh == other.kwh &&
          fuelPercent == other.fuelPercent &&
          runHours == other.runHours &&
          takenAt == other.takenAt &&
          note == other.note &&
          version == other.version &&
          syncState == other.syncState;

  @override
  int get hashCode => Object.hash(
    id,
    assetId,
    kwh,
    fuelPercent,
    runHours,
    takenAt,
    note,
    version,
    syncState,
  );
}
