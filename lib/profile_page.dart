import 'package:flutter/material.dart';
import 'package:flutter_application_1/sign_in_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = '';
  Future<void> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username').toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Username: $username"), // Display current user's name
            const SizedBox(height: 20),
            const Text(
                'Language Preference'), // Display current language preference
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to change language preference
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
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
