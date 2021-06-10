import 'package:letskhareedo/constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs extends BaseSharedPreference {
  void setUserId(String value) {
    _setString(SHAREDPREFERENCE_USERNAME_KEY, value);
  }

  String getUserId() {
    String id;
    _getString(SHAREDPREFERENCE_USERNAME_KEY).then((value) {
      id = value;
    }).catchError((err) {
      print("SharedPreference error while getting userName : $err");
    });
    return id;
  }

  void setUserMail(String value) {
    _setString(SHAREDPREFERENCE_MAIL_KEY, value);
  }

  String getUserMail() {
    String id;
    _getString(SHAREDPREFERENCE_MAIL_KEY).then((value) {
      id = value;
    }).catchError((err) {
      print("SharedPreference error while getting userMail : $err");
    });
    return id;
  }

  void setLoginStatus(bool value) {
    _setBoolean(SHAREDPREFERENCE_LOGINSTATUS_KEY, value);
  }
  bool id = false;
  bool loginStatus(){
    return id;
  }
  Future<bool> getLoginStatus() async{
    bool id = await _getBoolean(SHAREDPREFERENCE_LOGINSTATUS_KEY).then((value) {
      return value;
    });
    print("::::::::::-------------::::the id is::::::::::: $id");
    return id;
  }
}

class BaseSharedPreference {
  BaseSharedPreference(){
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
  }
  void _setString(String key, String value) async {
    final pref = await SharedPreferences.getInstance();
    bool check = await pref.setString(key, value);
    if (check)
      print("SharedPreferenceBaseClass ::::::::::::::::::::::::::::::: $check");
    else
      print("SharedPreferenceBaseClass ::::::::::::::::::::::::::::::: $check");
  }

  Future<String> _getString(String key) async {
    final pref = await SharedPreferences.getInstance();
    String data = pref.getString(key);
    if (data != null)
      return data;
    else
      return "";
  }

  void _setBoolean(String key, bool value) async {
    final pref = await SharedPreferences.getInstance();
    bool check = await pref.setBool(key, value);
    if (check)
      print("SharedPreferenceBaseClass ::::::::::::::::::::::::::::::: $check");
    else
      print("SharedPreferenceBaseClass ::::::::::::::::::::::::::::::: $check");
  }

  Future<bool> _getBoolean(String key) async {
    final pref = await SharedPreferences.getInstance();
    bool data = pref.getBool(key);
    if (data != null)
      return data;
    else
      return false;
  }
}
