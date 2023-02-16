import 'package:flutter/foundation.dart';

class AppProviders extends ChangeNotifier {
  String countryName = "";
  void countryNameFunc(String name) {
    countryName = name;
    notifyListeners();
  }

  bool authButtonEnabled = false;
  void authButtonEnabledFunc(bool enable) {
    authButtonEnabled = enable;
    notifyListeners();
  }
}
