// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';


class TextfieldInput extends StatelessWidget {
  const TextfieldInput({
    super.key,
    required this.Controller, 
    required this.Icons, 
    required this.keyboardType, 
    required this.hintText,
  });

  final TextEditingController Controller;
  final Icon Icons;
  final TextInputType keyboardType;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: Controller,
      decoration: InputDecoration(
        hintText: '',
        prefixIcon: Icons,
        contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 250, 184, 97)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 250, 184, 97), width: 2),
        ),
      ),
    );
  }
}