# Shelf Planner

A Flutter app (web and macOS) that plans a single-wall built-in bookshelf shaped as a rectangular ring around a window.

Enter the window size, column and bar dimensions, and depth. The app produces:

- A to-scale front elevation drawing
- Automatic structural braces (vertical dividers and shelves)
- A cut list based on Home Depot plywood sizes
- A sheet count and live warnings
- Copyable CSV and text summaries, and a printable PDF

The full build spec, including constants, formulas and tests, is in [shelf_planner_spec.md](shelf_planner_spec.md).

## Run

```
flutter pub get
flutter run -d chrome
flutter run -d macos
```

## Test

```
flutter test
```

## Notes

- All values are inches internally and shown as fractions to the nearest 1/16.
- The structural limits are rules of thumb, not engineering certification. Verify against your actual book load.
- Dependencies beyond the Flutter SDK: `pdf` and `printing`, for PDF export only.
