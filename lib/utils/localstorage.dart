import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
class LocalStorage {
  static late SharedPreferences localstorage;
  static late BuildContext context;

  LocalStorage(context) {
    init();
  }

  static init() async {
   localstorage = await SharedPreferences.getInstance();
    var brightness = SchedulerBinding.instance.window.platformBrightness;

    isDarkMode = brightness == Brightness.dark;
    return true;
  }


  static bool isDarkMode = false;
  static bool get isDarkTheme => localstorage.getBool("isdark") ?? isDarkMode;

  static set setDarkTheme(bool value) => localstorage.setBool("isdark", value);

}
