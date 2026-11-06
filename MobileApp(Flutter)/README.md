# Salin-Suri

Cross-platform Flutter prototype for a water-quality monitoring app. Readings
are sample values until the physical monitoring device is connected.

## Project structure

- `lib/main.dart` — app entry point
- `lib/screens/` — onboarding, dashboard, sensor, history, filtration,
  notification, alert, and settings screens
- `lib/widgets/` — reusable UI components and navigation helpers
- `lib/models/` — sensor reading model and placeholder readings
- `lib/theme/` — shared color palette and app theme
- `test/` — widget tests

Run the app with `flutter run`; run checks with `flutter analyze` and
`flutter test`.
