import 'package:flutter/material.dart';
import 'package:flutter_application_1/sign_in_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'language_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = '';
  Future<void> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username').toString();
    });
  }

  void _changeLanguage(Locale locale, context) {
    Provider.of<LanguageProvider>(context, listen: false).setLocale(locale);
  }

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${appLocale?.profile}'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Icon(Icons.account_circle),
            Text("${appLocale?.username}: $username"), // Display current user's name
            const SizedBox(height: 20),
            Text(
                '${appLocale?.langPref}: ${appLocale?.languagePreference}'), // Display current language preference
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                //change language preference
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.language),
                            title: const Text('English'),
                            onTap: () {
                              _changeLanguage(const Locale('en', ''), context);
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.language),
                            title: const Text('Español'),
                            onTap: () {
                              _changeLanguage(const Locale('es', ''), context);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Text('Change Language'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); //popping profile route
                Navigator.pop(context); //popping homepage route
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                ); // navigating to sign in page
              },
              child: Text('${appLocale?.logout}'),
            ),
          ],
        ),
      ),
    );
  }
}
