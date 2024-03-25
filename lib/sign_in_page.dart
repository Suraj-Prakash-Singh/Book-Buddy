import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //in memory login info
  final String username = "Suraj123";
  final String password = "pass123";

  Future<void> _signIn() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', _usernameController.text);
    prefs.setString('password', _passwordController.text);

    //when id and pass is correct, navigate to homepage
    if (_usernameController.value.text == username &&
        _passwordController.value.text == password) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      //returning an alert box which shows wrong input
      showDialog(
          context: context,
          builder: (BuildContext context) {
            final appLocale = AppLocalizations.of(context);
            return AlertDialog(
              title: Text('${appLocale?.wrongInput}'),
              content: Text('${appLocale?.errorMessage}'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text('${appLocale?.close}'),
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("${appLocale?.signIn}"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: "${appLocale?.username}",
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "${appLocale?.password}",
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _signIn,
              child: Text("${appLocale?.signIn}"),
            ),
          ],
        ),
      ),
    );
  }
}
