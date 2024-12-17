import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../controller/auth_service.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignupPage({super.key, required this.showLoginPage});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final AuthService _authService = AuthService();

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final conPassController = TextEditingController();

  void signUp() {
    log("click");
    if(passController.text.trim() == conPassController.text.trim() && userNameController.text.isNotEmpty && emailController.text.isNotEmpty && passController.text.isNotEmpty) {
      log("condition true");
      _authService.signUp(email: emailController.text, password: passController.text, userName: userNameController.text);
    } else {
      log("condition false");
    }
    log("pass here");
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
                    child: SvgPicture.asset(
                      "assets/icons/logo.svg",
                      width: 120,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100),
              Container(
                width: double.infinity,
                height: 650,
                // color: Colors.amber,
                child: Column(
                  children: [
                    const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 22),
                    ),
                    //Username================================================
                    Image.asset("assets/images/users.png", width: 200),
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
                          controller: userNameController,
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
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: "inter",
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

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
                      child:  Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 5),
                        child: TextField(
                          controller: passController,
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
                          controller: conPassController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Comfirm Password",
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

                    Container(
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
                      child: TextButton(
                        onPressed: signUp,
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white),
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
                        onPressed: () => Navigator,
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
                          "Already have an account",
                          style: TextStyle(fontFamily: "inter"),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: widget.showLoginPage,
                          child: const Text(
                            "Sign In",
                            style: TextStyle(),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 120),
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
