<img src="assets/feature-image.png" width="61%">

# A simple app to roll dices.

Made with Flutter using Provider state management.

<p float="left">
  <img src="assets/screenshot-1.png" width="20%">
  <img src="assets/screenshot-2.png" width="20%">
  <img src="assets/screenshot-3.png" width="20%">
</p>

## Project layout (high level)

- lib/
  - main.dart — app entry
  - src/ — app modules (widgets, providers, models)
- test/ — unit tests
- assets/ — images and screenshots

## Prerequisites

- macOS (development machine)
- Flutter SDK installed (see `flutter --version`)
- For Android: Android Studio + AVD or a physical device
- For iOS: Xcode and a valid development setup

Run:
- flutter doctor

## Running

First, install flutter than run `flutter doctor` and fix possible errors. <br>
To run the app simply run `flutter run`.

### Android

Before running the android emulator must be launched

## Building for release

### Ads

Replace the placeholder AdMob IDs with your own from the AdMob console:

- Update `lib/utils/ad_helper.dart`:
  - replace any placeholder ad unit IDs with your production ad unit IDs (banner, interstitial, rewarded, etc.).
- Update Android manifest `android/app/src/main/AndroidManifest.xml`:
  - replace the placeholder Android app ID(s) with your AdMob Android App ID(s).
- Exact placeholders to replace (examples from this repo):
  - <admob-android-unit-id>
  - <admob-android-app-id>

Notes:
- IOS not yet implemented.
- Use AdMob test IDs while developing and replace them with your real IDs only for release builds.
- Ad unit IDs typically look like ca-app-pub-XXXXXXXXXXXXXXXX/NNNNNNNNNN, app IDs like ca-app-pub-XXXXXXXXXXXXXXXX~NNNNNNNNNN.
- After replacing IDs, run a clean build (for example: flutter clean && flutter build apk or flutter build ios) and test in release/profile modes to verify ads load.

## References

- [Flutter Online Documentation](https://flutter.dev/docs)
- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Flutter simple app state management](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple)
- [Pragmatic State Management in Flutter](https://www.youtube.com/watch?v=d_m5csmrf7I)
- [WidgetView Pattern](https://blog.gskinner.com/archives/2020/02/flutter-widgetview-a-simple-separation-of-layout-and-logic.html)
- [Unit Testing](https://flutter.dev/docs/cookbook/testing/unit/introduction)
- [Integration Testing](https://flutter.dev/docs/cookbook/testing/integration/introduction)
- [Bottom App Bar](https://proandroiddev.com/flutter-how-to-using-bottomappbar-75d53426f5af)
- [Slivers for fancy scrolling](https://flutter.dev/docs/development/ui/advanced/slivers)
- [Prepare to release](https://flutter.dev/docs/deployment/android)
- [Floating App Bar with Slivers](https://flutter.dev/docs/cookbook/lists/floating-app-bar)

## License

No part of this project may be used, copied, modified, or distributed without prior written permission from the owner.
