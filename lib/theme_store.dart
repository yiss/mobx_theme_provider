import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'theme_store.g.dart';

enum ThemeType { light, dark }

class ThemeStore = _ThemeStore with _$ThemeStore;

abstract class _ThemeStore with Store {
  final ThemeData _lightTheme =
      ThemeData.light().copyWith(primaryColor: Colors.deepPurple);
  final ThemeData _darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.deepPurple,
  );

  @observable
  ThemeType currentThemeType = ThemeType.light;

  @computed
  ThemeData get currentThemeData =>
      (currentThemeType == ThemeType.light) ? _lightTheme : _darkTheme;

  @computed
  String get themeString =>
      (currentThemeType == ThemeType.light) ? 'Light' : 'Dark';

  @action
  void changeCurrentTheme(ThemeType type) {
    currentThemeType = type;
  }
}
