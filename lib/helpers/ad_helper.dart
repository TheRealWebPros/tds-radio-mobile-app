import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8139631059262464/5603520476";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8139631059262464/1922803916";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8139631059262464/7954900380";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8139631059262464/2319430320";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get openAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8139631059262464/4482010492";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8139631059262464/9814776968";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
