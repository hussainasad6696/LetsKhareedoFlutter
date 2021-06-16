import 'package:letskhareedo/constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs extends BaseSharedPreference {
  void setUserId(String value) {
    BaseSharedPreference._setString(SHAREDPREFERENCE_USERNAME_KEY, value);
  }

  Future<String> getUserId() async {
   final userName = await BaseSharedPreference._getString(SHAREDPREFERENCE_USERNAME_KEY);
    print("::::::::::-------------::::the id is::::::::::: $userName");
    return userName;
  }

  void setUserImage(String value) {
    BaseSharedPreference._setString(SHAREDPREFERENCE_PROFILEIMAGE_KEY, value);
  }

  Future<String> getUserImage() async {
    String userImage = await BaseSharedPreference._getString(SHAREDPREFERENCE_PROFILEIMAGE_KEY);
    print("::::::::::-------------::::the id is::::::::::: $userImage");
    return userImage;
  }

  void setUserImageName(String value) {
    BaseSharedPreference._setString(SHAREDPREFERENCE_PROFILEIMAGENAME_KEY, value);
  }

  Future<String> getUserImageName() async {
    String userImageName = await BaseSharedPreference._getString(SHAREDPREFERENCE_PROFILEIMAGENAME_KEY);
    print("::::::::::-------------::::the id is::::::::::: $userImageName");
    return userImageName;
  }
  void setUserMail(String value) {
    BaseSharedPreference._setString(SHAREDPREFERENCE_MAIL_KEY, value);
  }

  Future<String> getUserMail() async {
   String userMail = await BaseSharedPreference._getString(SHAREDPREFERENCE_MAIL_KEY);
    print("::::::::::-------------::::the id is::::::::::: $userMail");
    return userMail;
  }

  void setLoginStatus(bool value) {
    BaseSharedPreference._setBoolean(SHAREDPREFERENCE_LOGINSTATUS_KEY, value);
  }

  Future<bool> getLoginStatus() async {
   bool  id = await BaseSharedPreference._getBoolean(SHAREDPREFERENCE_LOGINSTATUS_KEY).then((value) {
      return value;
    });
    print("::::::::::-------------::::the id is::::::::::: $id");
    return id;
  }
}

class BaseSharedPreference {

  static SharedPreferences _sharedPreferences;

  static Future init() async => _sharedPreferences = await SharedPreferences.getInstance();

  static Future _setString(String key, String value) async {
    bool check = await _sharedPreferences.setString(key, value);
    if (check)
      print("SharedPreferenceBaseClass ::::::::::::::::::::::::::::::: $check");
    else
      print("SharedPreferenceBaseClass ::::::::::::::::::::::::::::::: $check");
  }

  static Future<String> _getString(String key) async => _sharedPreferences.getString(key);

  static Future _setBoolean(String key, bool value) async {
    bool check = await _sharedPreferences.setBool(key, value);
    if (check)
      print("SharedPreferenceBaseClass ::::::::::::::::::::::::::::::: $check");
    else
      print("SharedPreferenceBaseClass ::::::::::::::::::::::::::::::: $check");
  }

  static Future<bool> _getBoolean(String key) async => _sharedPreferences.getBool(key);
}
