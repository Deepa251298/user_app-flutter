// ignore_for_file: use_key_in_widget_constructors, empty_statements, avoid_print, use_build_context_synchronously, unused_import, unused_field

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_app/screens/home_screen.dart';
import 'package:user_app/screens/register_screen.dart';
import 'package:user_app/screens/verify_screen.dart';
import 'package:user_app/widgets/bottom_navbar.dart';
import 'package:user_app/widgets/rectangular_button.dart';
import 'package:user_app/widgets/textfield_input.dart';
import 'package:user_app/config/palette.dart';


class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  Future<void> sendEmailOTP(BuildContext context, String email) async {
    const url = 'https://demoapi.amtcmro.com/login';
    final String email = "testadmin1@gmail.com";

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({"mail": email});

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201) {
        print("OTP sent successfully to $email");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("OTP sent to $email")),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyScreen(email: email),
          ),
        );
        print("Navigating to VerifyScreen...");

      } else {
        print("Failed to send OTP: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to send OTP")),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      body: SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'images/delivery.jpg',
                  height: 200,
                ),

                SizedBox(height: 30),

                Text(
                  'Login With Email Address',
                  style: TextStyle(
                    fontSize: 20,
                    color: Palette.txtorange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: TextfieldInput(
                    Controller: emailController, 
                    Icons: Icon(Icons.email_outlined),
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'example@gmail.com',
                  ),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Palette.txtorange,
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    final email = emailController.text.trim();
                    if (email.isNotEmpty && email.contains('@')) {
                      sendEmailOTP(context, email); 
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please enter a valid email")),
                      );
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Palette.white,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Icon(Icons.arrow_right_alt, color: Palette.white),
                    ],
                  ),
                ),

                RectangularButton(title: 'Register', onPressed: () { 
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                 },),

                Spacer(),
                BottomNavbar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

