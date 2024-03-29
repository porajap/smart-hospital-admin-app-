import 'package:shared_preferences/shared_preferences.dart';

import '../models/login/logged_model.dart';
class PreferenceKey {
  static final String isLogin = "isLogin";
  static final String phone = "phone";

  static final String fName = "fName";
  static final String lName = "lName";
  static final String token = "token";
  static final String organizeName = "organizeName";
  static final String format = "format";
}

class SharedPreferencesService {
  Future<void> setIsLoggedIn({required bool isLogin}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool(PreferenceKey.isLogin, isLogin);
  }

  Future<bool> getIsLoggedIn() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool _data = _prefs.getBool(PreferenceKey.isLogin) ?? false;
    return _data;
  }

  Future<void> clearDataUser() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
  }

  Future<void> setUserLoggedIn({required LoggedModel data}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    _prefs.setString(PreferenceKey.fName, data.data?.fName ?? "");
    _prefs.setString(PreferenceKey.lName, data.data?.lName ?? "");
    _prefs.setString(PreferenceKey.token, data.token ?? "");
    _prefs.setString(PreferenceKey.organizeName, data.data?.organizeName ?? "");
    _prefs.setInt(PreferenceKey.format, data.data!.format != null ? data.data!.format as int : 2);
  }

  Future<String> getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _data = _prefs.getString(PreferenceKey.token) ?? "";
    return _data;
  }

  Future<String> getPhone() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _data = _prefs.getString(PreferenceKey.phone) ?? "";
    return _data;
  }

  Future<String> getOrganize() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _data = _prefs.getString(PreferenceKey.organizeName) ?? "-";
    return _data;
  }

  Future<int> getFormat() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int _data = _prefs.getInt(PreferenceKey.format) ?? 2;
    return _data;
  }

  Future<void> setPhone({required String phone}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(PreferenceKey.phone, phone);
  }
}
