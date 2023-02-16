import 'package:a2d_app/services/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageServices {
  static void setSignStatus(bool status) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(Keys.signStatus, status);
  }

  static Future<bool> getSignStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(Keys.signStatus) ?? false;
  }
}
