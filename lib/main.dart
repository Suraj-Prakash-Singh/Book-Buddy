import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/sign_in_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'language_provider.dart';


void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => LanguageProvider(),
      child: const MyApp(),
    ),);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); //hiding the status bar
    final languageProvider = Provider.of<LanguageProvider>(context);
    return MaterialApp(
      supportedLocales: const [
        Locale('en',''), // English
        Locale('es', ''), // Spanish
      ],
      locale: languageProvider.currentLocale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      title: 'Sign In Demo',
      home: const SignInPage(),
    );
  }
}
