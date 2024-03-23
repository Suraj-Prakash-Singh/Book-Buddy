import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sign_in_page.dart';
import 'book.dart';
import './assets/constants.dart' as constants;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _username = '';
  final List<Book> _books = constants.BOOKS_LIST;
  bool _isDarkMode = false;
  List<Book> _filteredBooks = [];

  @override
  void initState() {
    super.initState();
    _checkSignIn();
    _filteredBooks = _books;
  }

  Future<void> _checkSignIn() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    if (username == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInPage()),
      );
    } else {
      setState(() {
        _username = username;
      });
    }
  }

  //implementing search functionality
  void _searchBooks(String query) {
    setState(() {
      _filteredBooks = _books.where((book) {
        final titleMatch =
            book.title.toLowerCase().contains(query.toLowerCase());
        final authorMatch =
            book.author.toLowerCase().contains(query.toLowerCase());
        return titleMatch || authorMatch;
      }).toList();
    });
  }

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Library',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Book Buddy'),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: _searchBooks,
                      decoration: const InputDecoration(
                        hintText: 'Search books...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Switch(
                    value: _isDarkMode,
                    onChanged: _toggleTheme,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredBooks.length,
                itemBuilder: (context, index) {
                  final book = _filteredBooks[index];
                  return ListTile(
                    title: Text('Title: ${book.title}'),
                    subtitle: Text('Author: ${book.author}'),
                    trailing: Icon(
                      book.isAvailable ? Icons.check : Icons.close,
                      color: book.isAvailable ? Colors.green : Colors.red,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
