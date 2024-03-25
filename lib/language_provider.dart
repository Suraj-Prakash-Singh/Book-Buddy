import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _currentLocale = Locale('en', '');

  Locale get currentLocale => _currentLocale;

  void setLocale(Locale locale) {
    _currentLocale = locale;
    notifyListeners();
  }
}