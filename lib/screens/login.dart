import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vpn_basic_project/components/input.dart';
import 'package:vpn_basic_project/components/signInBtn.dart';
import 'package:vpn_basic_project/components/signUpBtn.dart';
import 'package:vpn_basic_project/components/square_tile.dart';
import 'package:vpn_basic_project/screens/register.dart';
import 'package:vpn_basic_project/services/googleAuth.dart';

class LoginPage extends StatefulWidget {
  final void Function() onTap;
  const LoginPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final Color midnightNavy = Color(0xFF050049);
  final Color whisperGray = Color(0xFFFCFCFC);
  final Color silverGray = Color(0xFFA8A8A8);
  final Color vibrantRed = Color(0xFFFF6666);
  final Color oceanBlue = Color(0xFF4080FC);

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF050049)),
          ),
        );
      },
    );
  }

  void signUserIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF050049)),
            ),
          );
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
      } else if (e.code == 'wrong-password') {}
    } finally {
      Navigator.pop(context); // Close loading dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whisperGray,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Image.asset(
                  'assets/images/vpn.png',
                  height: 80,
                ),
                const SizedBox(height: 25),
                Text(
                  'Defender VPN',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: oceanBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                // logo
                // const Icon(
                //   Icons.lock,
                //   size: 100,
                // ),

                const SizedBox(height: 10),
                Text(
                  'Browse anything with our secure',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: silverGray,
                      fontSize: 14,
                    ),
                  ),
                ),
                Text(
                  'browsing experience',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: silverGray,
                      fontSize: 14,
                    ),
                  ),
                ),

                // welcome back, you've been missed!

                const SizedBox(height: 40),

                // username textfield
                usernameInput(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                usernameInput(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 20),

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: silverGray,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // sign in button
                signInBtn(
                  text: "Sign In",
                  onTap: signUserIn,
                ),
                const SizedBox(height: 10),

                signUpBtn(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(
                          onTap: () {},
                        ), // Replace SignUpPage with your target page
                      ),
                    );
                  },
                ),

                const SizedBox(height: 25),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: silverGray,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: silverGray,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // google + facebook sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(
                      onTap: () {
                        _showLoadingDialog(context);
                        AuthService().signInWithGoogle().then((_) {
                          Navigator.pop(context); // Close loading dialog
                        });
                      },
                      imagePath: 'assets/images/google.png',
                    ),

                    SizedBox(width: 15),

                    // facebook button
                    SquareTile(
                      onTap: () {
                        _showLoadingDialog(context);
                        AuthService().signInWithGoogle().then((_) {
                          Navigator.pop(context); // Close loading dialog
                        });
                      },
                      imagePath: 'assets/images/facebook.png',
                    ),
                  ],
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
