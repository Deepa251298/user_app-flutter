// ignore_for_file: avoid_unnecessary_containers, use_build_context_synchronously, avoid_print, sort_child_properties_last

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_app/config/palette.dart';
import 'package:user_app/screens/home_screen.dart';
import 'package:user_app/widgets/bottom_navbar.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ADD THIS at top

class VerifyScreen extends StatefulWidget {
  final String email;
  const VerifyScreen({super.key, required  this.email});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {

  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());

  final TextEditingController otpController = TextEditingController();
  bool isButtonEnabled = false;

 @override
void initState() {
  super.initState();
  for (var controller in _controllers) {
    controller.addListener(_checkOTPComplete);
  }
}

void _checkOTPComplete() {
  setState(() {
    isButtonEnabled = _controllers.every((controller) => controller.text.trim().isNotEmpty);
  });
}


Future<void> verifyEmailOTP(String email, String otp) async {
  const url = 'https://demoapi.amtcmro.com/login/verifyOTP';
  final String otp ="112233";

  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({"mail": email, "otp": otp});

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("OTP Verified: $data");

      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_email', email);
      await prefs.setBool('is_logged_in', true);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP Verified Successfully")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      print("OTP Verification failed: ${response.body}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid OTP")),
      );
    }
  } catch (e) {
    print("Error: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Something went wrong")),
    );
  }
}


  Widget _otpTextField(int index) {
    return Container(
      width: 40,
      height: 55,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.borderorange),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.borderorange, width: 2),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1 && index < 5) {
            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          }
          if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          }
        },
      ),
    );
  }
  @override
Widget build(BuildContext context) {
  return Scaffold(
    resizeToAvoidBottomInset: true,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Palette.black),
            ),
            SizedBox(height: 20),
            Text(
              "Verification",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Palette.txtorange),
            ),
            SizedBox(height: 10),
            Text(
              "Enter Verification Code Sent On the Email Address",
              style: TextStyle(color: Palette.borderorange),
            ),
            Row(
              children: [
                Text(widget.email,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Palette.black)),
                Icon(Icons.edit, size: 16),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) => _otpTextField(index)),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  String otp = _controllers.map((e) => e.text).join();
                  if (otp.length == 6) {
                    verifyEmailOTP(widget.email, otp);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please enter all 6 digits")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isButtonEnabled ? Palette.txtorange : Palette.grey,
                  minimumSize: Size(200, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text("Verify",
                    style: TextStyle(color: Palette.white, fontSize: 16)),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Text("Didn't receive code?"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Resend", style: TextStyle(color: Palette.blue)),
                      SizedBox(width: 5),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 30), // Add bottom space
          ],
        ),
      ),
    ),
    // bottomNavigationBar: BottomNavbar(),
  );
}

}