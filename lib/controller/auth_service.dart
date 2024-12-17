import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  Future<void> signUp(
      {required String email,
      required String password,
      required String userName}) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    //add acc to auth
    await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    //add acc to store based on auth.uid as doc.id//
    await firestore
        .collection("users")
        .doc(auth.currentUser?.uid)
        .set({"email": email, "userName": userName});
  }

  Future<void> signIn({required String email, required String password}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      log("error: ${e.message.toString()}");
    }
  }

  Future<void> logOut() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
  }

  Future<void> SignInWithGoogle() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
    await auth.signInWithProvider(googleAuthProvider);
  }

  Future<String> getUserName() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    String uid = auth.currentUser!.uid;
    DocumentSnapshot userNameSnapshot =
        await firestore.collection("users").doc(uid).get();
    if (!userNameSnapshot.exists) {
      return "USERNAME";
    } else {
      final userName = userNameSnapshot.get("userName");
      return userName;
    }
  }

  Future<void> changeUserName( {required String userName , required String uid }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection("users").doc(uid).update({"userName" : userName});
  }

  Future<void> changeUserEmail( {required String newEmail}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.currentUser!.updateEmail(newEmail);
  }
}
