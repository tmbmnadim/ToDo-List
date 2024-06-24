import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/Services/theme_services.dart';

NotifierProvider<ThemeNotifier, ThemeMode> themeNotifier =
    NotifierProvider<ThemeNotifier, ThemeMode>(() => ThemeNotifier());

class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    return ThemeMode.system;
  }

  void changeTheme(Brightness lightTheme) {
    if (lightTheme == Brightness.dark) {
      state = ThemeMode.light;
    } else {
      state = ThemeMode.dark;
    }
  }

  void getTheme() async {
    state = await ThemeServices().getTheme();
  }

  void setTheme(ThemeMode themeMode) async {
    await ThemeServices().setTheme(themeMode);
  }
}
