/// What kind of thing a shopping item is.
enum ShoppingKind {
  /// A tool the builder may already own, so it can be left out of the total.
  tool,

  /// A consumable that is used up by the build (glue, screws, sandpaper).
  material,
}
