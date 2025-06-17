// ignore_for_file: duplicate_import, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/screens/home_screen.dart';
import 'package:user_app/screens/login_screen.dart';
import 'package:user_app/screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userEmail = prefs.getString('user_email');

  runApp(MaterialApp(
    home: userEmail == null ? LoginScreen() : HomeScreen(),
  ));
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: LoginScreen(),
        initialRoute: '/login', // or '/home' based on user status
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/register':(context) =>RegisterScreen(),
      }
        
      );
  }
}
