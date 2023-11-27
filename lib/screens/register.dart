import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vpn_basic_project/components/input.dart';
import 'package:vpn_basic_project/components/signInBtn.dart';
import 'package:vpn_basic_project/components/square_tile.dart';
import 'package:vpn_basic_project/screens/login.dart';
import 'package:vpn_basic_project/services/googleAuth.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final Color midnightNavy = Color(0xFF050049);
  final Color whisperGray = Color(0xFFFCFCFC);
  final Color silverGray = Color(0xFFA8A8A8);
  final Color vibrantRed = Color(0xFFFF6666);
  final Color defender = Color(0xFF0866FF);

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

  void signUserUp() async {
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
      if (passwordController.text == confirmpasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        print("Passwords do not match");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("User not found");
      } else if (e.code == 'wrong-password') {
        print("Wrong password");
      }
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
                const SizedBox(height: 60),
                Image.asset(
                  'assets/images/vpn.png',
                  height: 80,
                ),
                const SizedBox(height: 25),
                Text(
                  'Welcome!',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: midnightNavy,
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

                const SizedBox(height: 5),
                Text(
                  'Sign up to get started',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: silverGray,
                      fontSize: 14,
                    ),
                  ),
                ),

                // welcome back, you've been missed!

                const SizedBox(height: 20),

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
                const SizedBox(height: 10),

                // password textfield
                usernameInput(
                  controller: confirmpasswordController,
                  hintText: 'Confirm Password',
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
                  text: "Sign Up",
                  onTap: signUserUp,
                ),
                const SizedBox(height: 25),

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

                const SizedBox(height: 20),

                // google + apple sign in buttons
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

                const SizedBox(height: 20),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: silverGray,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the login page when "Login Now" is tapped
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LoginPage(
                              onTap: () {},
                            ), // Replace LoginPage with the actual login page
                          ),
                        );
                      },
                      child: Text(
                        'Login now',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: midnightNavy,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Not working
}
