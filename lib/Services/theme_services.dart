import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';

class ThemeServices {
  ThemeServices();

  Future<ThemeMode> getTheme() async {
    ThemeMode themeMode = ThemeMode.dark;
    try {
      Box taskBox = await Hive.openBox<String>("theme");

      String themeModeString = taskBox.get("themeMode");
      if (themeModeString == "light") {
        themeMode = ThemeMode.light;
      } else if (themeModeString == "dark") {
        themeMode = ThemeMode.dark;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
    return themeMode;
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    try {
      Box taskBox = await Hive.openBox<String>("theme");

      await taskBox.put("themeMode", themeMode.name);
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }
}
