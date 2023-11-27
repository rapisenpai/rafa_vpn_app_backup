import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class signUpBtn extends StatelessWidget {
  final Function()? onTap;
  final Color midnightNavy = Color(0xFF050049);
  final Color whisperGray = Color(0xFFFCFCFC);
  final Color silverGray = Color(0xFFA8A8A8);
  final Color vibrantRed = Color(0xFFFF6666);
  final Color oceanBlue = Color(0xFF4080FC);

  signUpBtn({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: whisperGray,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: oceanBlue, // Specify the border color
            width: 2.0, // Specify the border width
          ),
        ),
        child: Center(
          child: Text(
            "Sign up",
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: oceanBlue,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
