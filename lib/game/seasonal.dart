/// Seasonal designs (owner, 30.09.2026): a design with a sale month can be
/// bought only during that calendar month, every year; one already owned
/// stays owned and usable all year. Pure Dart, no Flutter imports.
///
/// The first is Halloween: a pumpkin theme and an animated ghost skin, for
/// sale in October. The month is the player's local calendar, like the Daily
/// and the deal of the day.
library;

/// October.
const int kHalloweenMonth = 10;

/// The Halloween theme (`kThemeCatalog`) and skin (`kSkinCatalog`).
const String kHalloweenThemeId = 'pumpkin';
const String kHalloweenSkinId = 'ghost';

/// Whether a design with [saleMonth] can be bought at [now]. Null means an
/// ordinary design, for sale all year.
bool forSaleIn(int? saleMonth, DateTime now) =>
    saleMonth == null || now.month == saleMonth;

/// Whether the Halloween event runs at [now]: the shop section and the home
/// banner show, and its two designs can be bought.
bool halloweenActive(DateTime now) => now.month == kHalloweenMonth;
