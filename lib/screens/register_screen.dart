// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:user_app/config/palette.dart';
import 'package:user_app/screens/login_screen.dart';
import 'package:user_app/widgets/rectangular_button.dart';
import 'package:user_app/widgets/textfield_input.dart';

// ignore: use_key_in_widget_constructors
class RegisterScreen extends StatelessWidget {

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(onPressed: () { 
                Navigator.pop(context);
               },
              icon: Icon(Icons.arrow_back, color: Palette.black)),

              Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Palette.txtorange,
                ),
              ),
              const SizedBox(height: 20),
              Text('First Name'),
              TextfieldInput(
                Controller: firstNameController, 
                Icons: Icon(Icons.person),
                keyboardType: TextInputType.name, hintText: '',
              ),

              SizedBox(height: 15),
              Text('Last Name'),
              TextfieldInput(
                Controller: lastNameController, 
                Icons: Icon(Icons.person),
                keyboardType: TextInputType.name, hintText: '',
              ),

              const SizedBox(height: 15),
              Text('Email ID'),
              TextfieldInput(
                Controller: emailController, 
                Icons: Icon(Icons.email_outlined),
                keyboardType: TextInputType.emailAddress, hintText: '',
              ),

              const SizedBox(height: 15),
              Text('Date of Birth'),
              TextfieldInput(
                Controller: dobController, 
                Icons: Icon(Icons.today_outlined),
                keyboardType: TextInputType.datetime, hintText: '',
              ),

              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: RectangularButton(title: 'Register', onPressed: () { 
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                 },),
              ),
            ]
          ),
        ),
      ),
    );
  }
}


            