import "package:flutter/material.dart";
import "package:vpn_basic_project/screens/login.dart";
import "package:vpn_basic_project/screens/register.dart";

class LoginOrRegisgterPage extends StatefulWidget {
  const LoginOrRegisgterPage({Key? key}) : super(key: key);

  @override
  State<LoginOrRegisgterPage> createState() => _LoginOrRegisgterPageState();
}

class _LoginOrRegisgterPageState extends State<LoginOrRegisgterPage> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}
