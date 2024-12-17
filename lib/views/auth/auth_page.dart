import 'package:flutter/cupertino.dart';
import '../login_page.dart';
import '../signup_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void togglScrean() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showSignupPage: togglScrean);
    } else {
      return SignupPage(showLoginPage: togglScrean);
    }
  }
}
