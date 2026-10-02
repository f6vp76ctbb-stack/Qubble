/// Accessories on the blocks (owner, 30.09.2026): a small extra drawn on top
/// of any block skin — a cobweb, a snow cap, a crown and so on. Pure Dart, no
/// Flutter imports; the drawing is in lib/ui/widgets/accessory_painter.dart.
///
/// Six to start, 60 diamonds each (owner's choice). One is worn at a time,
/// or none. It sits on about two blocks in five, always the same board
/// positions, so the board stays readable and nothing flickers as pieces
/// come and go.
library;

enum AccessoryStyle { none, cobweb, snowCap, crown, flower, sparkle, dewdrop }

class Accessory {
  const Accessory({required this.id, required this.style, required this.cost});

  /// Stable catalog id; the displayed name is `accessoryName` in
  /// lib/ui/l10n_maps.dart.
  final String id;
  final AccessoryStyle style;

  /// Price in diamonds; 0 for [kNoAccessoryId], which everyone has.
  final int cost;
}

/// "No accessory" — owned by everyone, the default.
const String kNoAccessoryId = 'none';

/// Price of each accessory, in diamonds.
const int kAccessoryPrice = 60;

const List<Accessory> kAccessoryCatalog = [
  Accessory(id: kNoAccessoryId, style: AccessoryStyle.none, cost: 0),
  Accessory(id: 'cobweb', style: AccessoryStyle.cobweb, cost: kAccessoryPrice),
  Accessory(id: 'snowCap', style: AccessoryStyle.snowCap, cost: kAccessoryPrice),
  Accessory(id: 'crown', style: AccessoryStyle.crown, cost: kAccessoryPrice),
  Accessory(id: 'flower', style: AccessoryStyle.flower, cost: kAccessoryPrice),
  Accessory(id: 'sparkle', style: AccessoryStyle.sparkle, cost: kAccessoryPrice),
  Accessory(id: 'dewdrop', style: AccessoryStyle.dewdrop, cost: kAccessoryPrice),
];

AccessoryStyle accessoryStyleById(String id) => kAccessoryCatalog
    .firstWhere((a) => a.id == id, orElse: () => kAccessoryCatalog.first)
    .style;

/// Whether the block at ([row], [col]) wears the accessory: two positions in
/// every five, spread so that neighbours rarely both do.
bool wearsAccessory(int row, int col) => (row * 2 + col * 3) % 5 < 2;
