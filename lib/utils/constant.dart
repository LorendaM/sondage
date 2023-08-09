import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'localstorage.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_declarations, non_constant_identifier_names, constant_identifier_names, equal_keys_in_map, unnecessary_import, slash_for_doc_comments, prefer_interpolation_to_compose_strings

class Helper {
  static final Color kPrimaryColor = Color(0xFF0F6FFF);
  static final Color lPrimaryColor = Color(0xFFCCE0FA);

  static final MaterialColor kPrimaryColorShades = MaterialColor(
    0xFF0F6FFF,
    <int, Color>{
      50: Color(0xFFA4A4BF),
      100: Color(0xFFA4A4BF),
      200: Color(0xFFA4A4BF),
      300: Color(0xFF9191B3),
      400: Color(0xFF7F7FA6),
      500: Color(0xFF09ADE5),
      600: Color(0xFF6D6D99),
      700: Color(0xFF5B5B8D),
      800: Color(0xFF494980),
      900: Color(0xFF09ADE5),
    },
  );
  static final Color darkColor = Color(0xFF181919);

  static Color get textColor => LocalStorage.isDarkTheme ? Colors.white.withOpacity(0.9) : Colors.black.withOpacity(0.85);
  static Color get greyTextColor => LocalStorage.isDarkTheme ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.85);
  static Color get widgetColor => LocalStorage.isDarkTheme ? Colors.white10 : Colors.grey.shade200;

  static Color primary = Color(0xFF0B76E8);
  static Color secondary = kPrimaryColor;
  static Color danger = Color(0xFFF40A23);
  static Color warning = Color(0xFFF4AA0A);
  static Color success = Color.fromARGB(255, 56, 206, 51);


  static showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black.withOpacity(0.7),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static backAppPurple({required List<Widget> children}) {
    return Stack(children: [
      Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: CircularProgressIndicator(
            strokeWidth: 97,
            color: Colors.grey,
          ),
        ),
      ),
      Positioned.fill(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 150, sigmaY: 150),
          child: SizedBox(),
        ),
      ),
      for (var element in children) element
    ]);
  }

  static String acl = "rive";

  static Widget backApp({required List<Widget> children}) => acl == "purple" ? backAppPurple(children: children) : backAppRive(children: children);

  static backAppRive({required List<Widget> children}) {
    return Stack(children: [
      RotatedBox(quarterTurns: 4, child: RiveAnimation.asset("assets/RiveAssets/shapes.riv")),
      Positioned.fill(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 150, sigmaY: 150),
          child: SizedBox(),
        ),
      ),
      for (var element in children) element
    ]);
  }
}
