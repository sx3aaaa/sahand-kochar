enum AssetType {
  generator('Generator', '⚡'),
  ups('UPS', '🔋'),
  solarInverter('Solar inverter', '☀️'),
  transformer('Transformer', '🔧');

  const AssetType(this.label, this.icon);

  final String label;
  final String icon;
}

final _idPattern = RegExp(r'^[A-Z]-\d{3}$'); // e.g. G-102

class Asset {
  Asset({
    required this.id,
    required this.name,
    required this.type,
    required this.site,
    required this.capacityKva,
  }) : assert(_idPattern.hasMatch(id), 'bad asset id $id');

  final String id;
  final String name;
  final String site;
  final AssetType type;
  final double capacityKva;

  static bool isValidId(String s) => _idPattern.hasMatch(s);

  factory Asset.fromJson(Map<String, Object?> j) => Asset(
    id: j['id'] as String,
    name: j['name'] as String,
    type:
        AssetType.values.asNameMap()[j['type'] as String] ??
        AssetType.generator,
    site: j['site'] as String? ?? 'Unknown site',
    capacityKva: (j['capacityKva'] as num).toDouble(),
  );
}