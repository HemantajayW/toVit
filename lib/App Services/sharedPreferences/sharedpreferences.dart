import 'package:shared_preferences/shared_preferences.dart';

// SharedPreferences prefs = await SharedPreferences.getInstance();

class AppSharedPreferences {
  AppSharedPreferences() {
    getInstance();
  }
  getInstance() {
    print("Got INSTANCE");
  }

  setString(String variable, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(variable, value);
    print("set $variable to $value");
  }

  setBool(String variable, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("set $variable to $value");
  }

  setInt(String variable, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("set $variable to $value");
  }

  setDouble(String variable, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("set $variable to $value");
  }

  getString(String variable) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var value = prefs.getString(variable);
    print("get $variable to $value");

    return value;
  }

  getBouble(String variable) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getDouble(variable);
  }

  getInt(String variable) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getInt(variable);
  }

  getBool(String variable) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(variable);
  }
}
