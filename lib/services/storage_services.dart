import 'package:a2d_app/services/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageServices {
  static void setSignStatus(bool status) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(Keys.signStatus, status);
  }

  static void setName(String name) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(Keys.name, name);
  }

  static void setEmail(String email) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(Keys.email, email);
  }

  static void setPhone(String phone) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(Keys.phone, phone);
  }

  static void setPassword(String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(Keys.password, password);
  }

  static void setCountry(String country) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(Keys.country, country);
  }

  static void setId(String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(Keys.id, id);
  }

  static void setId2(String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(Keys.id2, id);
  }

  static void setCityId(String cityId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(Keys.cityId, cityId);
  }

  static void setToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(Keys.token, token);
  }

  static Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(Keys.token) ?? "token";
  }

  static Future<String> getCityId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(Keys.cityId) ?? "cityID";
  }

  static Future<String> getId2() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(Keys.id2) ?? "id2";
  }

  static Future<String> getId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(Keys.id) ?? "id";
  }

  static Future<String> getCountry() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(Keys.country) ?? "country";
  }

  static Future<String> getPassword() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(Keys.password) ?? "password";
  }

  static Future<String> getPhone() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(Keys.phone) ?? "phone";
  }

  static Future<String> getEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(Keys.email) ?? "email";
  }

  static Future<String> getName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(Keys.name) ?? "name";
  }

  static Future<bool> getSignStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(Keys.signStatus) ?? false;
  }
}
