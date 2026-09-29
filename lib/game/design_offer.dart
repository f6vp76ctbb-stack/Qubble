/// The designs sold for diamonds, and the deal of the day (owner, 28.09.2026).
/// Pure Dart, no Flutter imports.
///
/// Six designs — three themes, three block skins — are always for sale at
/// [kRotatingDesignPrice] diamonds. Each day one of them is the deal of the
/// day, featured at the top of the shop at [kDailyDealDiscountPercent] off;
/// the six take turns, so each is the deal once every six days. The day is
/// the player's local calendar day, like the Daily.
library;

enum DesignKind { theme, skin }

/// A design in the diamond shop: a theme id (`kThemeCatalog`) or a skin id
/// (`kSkinCatalog`).
class ShopDesign {
  const ShopDesign(this.kind, this.id);

  final DesignKind kind;
  final String id;

  @override
  bool operator ==(Object other) =>
      other is ShopDesign && other.kind == kind && other.id == id;

  @override
  int get hashCode => Object.hash(kind, id);

  @override
  String toString() => '${kind.name}:$id';
}

/// The six, in the order they take turns as the deal of the day: a theme,
/// then a skin, so two days in a row never offer the same kind.
const List<ShopDesign> kRotatingDesigns = [
  ShopDesign(DesignKind.theme, 'candy'),
  ShopDesign(DesignKind.skin, 'pixel'),
  ShopDesign(DesignKind.theme, 'volcano'),
  ShopDesign(DesignKind.skin, 'marble'),
  ShopDesign(DesignKind.theme, 'glacier'),
  ShopDesign(DesignKind.skin, 'jelly'),
];

/// Regular price of each of the six, in diamonds.
const int kRotatingDesignPrice = 80;

/// The deal of the day is this much cheaper.
const int kDailyDealDiscountPercent = 25;

/// Days since 1970-01-01 for the calendar day of [now], counted on the date
/// alone so a 23- or 25-hour day at a clock change is still exactly one day.
int _dayNumber(DateTime now) =>
    DateTime.utc(now.year, now.month, now.day).millisecondsSinceEpoch ~/
    Duration.millisecondsPerDay;

/// The deal of the day for the local calendar day of [now].
ShopDesign dailyDeal(DateTime now) =>
    kRotatingDesigns[_dayNumber(now) % kRotatingDesigns.length];

/// What [design] costs in diamonds at [now].
int designPrice(ShopDesign design, DateTime now) => design == dailyDeal(now)
    ? kRotatingDesignPrice * (100 - kDailyDealDiscountPercent) ~/ 100
    : kRotatingDesignPrice;

/// Time left until the next deal: the next local midnight.
Duration untilNextDeal(DateTime now) =>
    DateTime(now.year, now.month, now.day + 1).difference(now);
