import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../controller/auth_service.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showSignupPage;
  const LoginPage({super.key, required this.showSignupPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userlController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthService authService = AuthService();

  void signIn() {
    authService.signIn(
        email: _userlController.text.trim(),
        password: _passwordController.text.trim());
  }

  void signInWithGoogle() {
    authService.SignInWithGoogle();
  }

  @override
  void dispose() {
    _userlController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/Property 1=Default.jpg"),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 26, left: 10),
                    child: Hero(
                      tag: "logo",
                      child: SvgPicture.asset(
                        "assets/icons/logo.svg",
                        width: 120,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 285),
              Container(
                width: double.infinity,
                height: 350,
                // color: Colors.amber,
                child: Column(
                  children: [
                    const Text(
                      "Welcome Back !",
                      style: TextStyle(fontSize: 22),
                    ),
                    const SizedBox(height: 15),
                    //Username================================================

                    Container(
                      width: 350,
                      height: 42,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 5),
                        child: TextField(
                          controller: _userlController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Username",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: "inter",
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    //Password================================================

                    Container(
                      width: 350,
                      height: 42,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 5),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: "inter",
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    //button login  ==========================================

                    GestureDetector(
                      onTap: signIn,
                      child: Container(
                        width: 350,
                        height: 45,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.black,
                          ),
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    //button sign in with google =============================

                    Container(
                      width: 350,
                      height: 45,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: signInWithGoogle,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/icons/Frame 6.svg"),
                            const SizedBox(width: 10),
                            const Text(
                              "Sign in with Google",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    //don't account

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(fontFamily: "inter"),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: widget.showSignupPage,
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 235),
              const SizedBox(
                width: 185,
                height: 80,
                child: Text(
                  "Join our new beta program to test\n    our new experimental feature ",
                  style: TextStyle(fontFamily: "inter", fontSize: 11),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
