import 'dart:io';

class AdHelper {
  static String get interstitialNewDiceAdUnitId {
    if (Platform.isAndroid) {
      return '<admob-android-unit-id>';
    } else if (Platform.isIOS) {
      return '<admob-ios-unit-id>';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
