import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_keep_clone/edit_info.dart';
import 'package:google_keep_clone/edit_note.dart';

import 'package:google_keep_clone/home.dart';
import 'package:google_keep_clone/login.dart';
import 'package:google_keep_clone/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          bodySmall: GoogleFonts.roboto(
            fontSize: 20,
            color: Color(0xffb8b7bd),
          ),
        ),
      ),
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/login' : '/home',
      routes: {
        '/register': (context) => Register(),
        '/login': (context) => Login(),
        '/home': (context) => Home(),
        '/edit_note': (context) => EditNote(),
        '/edit_info': (context) => EditInfo()
      },
    );
  }
}
