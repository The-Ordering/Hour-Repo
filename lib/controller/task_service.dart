import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class TaskService {
  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> taskStreamer() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final taskSnapshot = firestore
        .collection("tasks")
        .snapshots()
        .map((snapshot) => snapshot.docs);
    return taskSnapshot;
  }

  Future<void> addTask(
      {required String name,
      required String category,
      required Timestamp date,
      required String start,
      required String end,
      required String priority,
      required String des,
      required bool done}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    firestore.collection("tasks").add({
      "name": name,
      "category": category,
      "date": date,
      "start": start,
      "end": end,
      "priority": priority,
      "des": des,
      "done": done
    });
  }

  Future<void> editTask(
      {required String name,
      required String category,
      required Timestamp date,
      required String start,
      required String end,
      required String priority,
      required String des,
      required String id,
      required bool done}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("tasks").doc(id).update({
      "name": name,
      "category": category,
      "date": date,
      "start": start,
      "end": end,
      "priority": priority,
      "des": des,
      "done": done
    });
  }

  Future<void> remove({required String id}) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("tasks").doc(id).delete();
  }

  Future<void> completing({required String id}) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("tasks").doc(id).update({"done": true});
  }

 Widget getTxt( {required String cate}) {
   return StreamBuilder<QuerySnapshot>(
     stream: FirebaseFirestore.instance
         .collection("tasks")
         .where('category', isEqualTo: cate)
         .snapshots(),
     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
       if (snapshot.connectionState == ConnectionState.waiting) {
         return Text("...");
       }

       if (snapshot.hasError) {
         return Text("Error");
       }

       // Count of documents
       int docCount = snapshot.data!.docs.length;

       return Text("$docCount");
     },
   );
 } Widget getAllTxt() {
   return StreamBuilder<QuerySnapshot>(
     stream: FirebaseFirestore.instance
         .collection("tasks")
         .snapshots(),
     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
       if (snapshot.connectionState == ConnectionState.waiting) {
         return Text("...");
       }

       if (snapshot.hasError) {
         return Text("Error");
       }

       // Count of documents
       int docCount = snapshot.data!.docs.length;

       return Text("$docCount");
     },
   );
 }

}
