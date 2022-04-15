
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  SharedPreferences prefs;

  UserRepository({this.prefs});

  static const String _isLoggedIn = "is_logged_in";
  static const String _appLaunchedPreviously = "is_app_launched_previously";
  static const String _isCustomerLogin = "is_customer_login";
  static const String _customerLogin = "false";


  appLaunched() async {
    await prefs.setBool(_appLaunchedPreviously, false);
  }

  Future<void> setCustomerLogin(bool status) async {
    await prefs.setBool(_customerLogin, status);
  }

  Future<bool> isCustomerLogin() async {
    return prefs.containsKey(_customerLogin);
  }

  Future<void> login() async {
    await prefs.setBool(_isLoggedIn, true);
  }

  Future<bool> isLoggedIn() async {
    return prefs.containsKey(_isLoggedIn);
  }

  Future<bool> isAppLaunchedPreviously() async {
    return prefs.containsKey(_appLaunchedPreviously);
  }

  Future<bool> getloginType() async {
    return prefs.containsKey(_isCustomerLogin);
  }

  Future logout() async {
    bool status = false;
    await prefs.remove(_isLoggedIn).then((value) {
      if (value) {
        status = true;
      }
    });
    return status;
  }

}