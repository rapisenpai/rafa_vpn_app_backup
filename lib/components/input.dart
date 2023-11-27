import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class usernameInput extends StatelessWidget {
  final controller;

  final String hintText;
  final bool obscureText;
  final Color midnightNavy = Color(0xFF050049);
  final Color whisperGray = Color(0xFFFCFCFC);
  final Color silverGray = Color(0xFFA8A8A8);

  usernameInput(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: midnightNavy,
            ),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        ),
        style: GoogleFonts.poppins(
          // Customize text color and font
          textStyle: TextStyle(
            color: Colors.black, // Change text color
            fontSize: 16, // Change font size
          ),
        ),
        cursorColor: midnightNavy, // Change cursor color
      ),
    );
  }
}
