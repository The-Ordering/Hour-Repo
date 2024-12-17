import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../controller/auth_service.dart';
import 'home_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _authService = AuthService();

  final emailController = TextEditingController();
  final userNameController = TextEditingController();

  String userName = "USERNAME";
  String userEmail = "USER-EMAIL";

  void fetchUser() async {
    String email = _auth.currentUser!.email.toString();
    String name = await _authService.getUserName();
    setState(() {
      userName = name;
      userEmail = email;
    });
  }

  void signOut() {
    _authService.logOut();
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        // image: DecorationImage(
                        //   fit: BoxFit.cover,
                        //   image: AssetImage("assets/images/Property 1=Variant2.jpg"),
                        // ),
                        ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            // Icon(Icons.arrow_left),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 28, bottom: 20),
                                child: SvgPicture.asset(
                                  "assets/icons/back.svg",
                                  width: 14,
                                ),
                              ),
                            )
                          ],
                        ),
                        const Hero(
                          tag: "users_tag",
                          child: Image(
                            image: AssetImage(
                              "assets/images/users.png",
                            ),
                            width: 200,
                          ),
                        ),
                        Text(
                          "$userName",
                          style: TextStyle(fontSize: 26),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 50,vertical:20),
                        color: Theme.of(context).colorScheme.surface,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Email"),
                            const SizedBox(height: 5),
                            Container(
                              width: 350,
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 15, bottom: 5),
                                child: TextField(
                                  onSubmitted: (value) {
                                    if(emailController.text.isNotEmpty) {
                                      AuthService().changeUserEmail(newEmail: emailController.text);
                                    }
                                  },
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: userEmail,
                                    hintStyle: const TextStyle(
                                      color: Colors.black54,
                                      fontFamily: "inter",
                                      fontSize: 15,
                                    ),
                                    icon: const Icon(Icons.edit),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 35),
                            const Text("User Name"),
                            const SizedBox(height: 5),
                            Container(
                              width: 350,
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 15, bottom: 5),
                                child: TextField(
                                  onSubmitted: (value) {
                                    if(userNameController.text.isNotEmpty) {
                                      AuthService().changeUserName(userName: userName, uid: _auth.currentUser!.uid.toString());
                                    }
                                  },
                                  controller: userNameController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: userName,
                                    hintStyle: const TextStyle(
                                        color: Colors.black54,
                                        fontFamily: "inter",
                                        fontSize: 15),
                                    icon: const Icon(Icons.edit),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: signOut,
                                  child: Container(
                                    width: 140,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFFF5757),
                                        borderRadius: BorderRadius.circular(12)),
                                    child: const Center(
                                        child: Text(
                                      "Log Out",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset("assets/icons/bgf.png"),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
