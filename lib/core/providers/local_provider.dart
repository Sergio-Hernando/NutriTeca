import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LocaleProvider {
  final List<Locale> supportedLocales = const [
    Locale('en', ''),
    Locale('es', ''),
    Locale('pt', ''),
    Locale('fr', ''),
    Locale('de', ''),
  ];

  Locale getLocale() {
    Locale? deviceLocale = PlatformDispatcher.instance.locale;

    for (var locale in supportedLocales) {
      if (locale.languageCode == deviceLocale.languageCode) {
        return deviceLocale;
      }
    }

    return const Locale('en', '');
  }
}
