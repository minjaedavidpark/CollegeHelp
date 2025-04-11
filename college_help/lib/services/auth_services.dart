import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_help/main.dart';
import 'package:college_help/screens/home/home_screen.dart';
import 'package:college_help/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> signInUserApp({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseException catch (err) {
      return Utils.firebaseAuthException(err.code);
    }
  }

  Future<Map<String, dynamic>?> signUpUserApp({
    required String name,
    required String email,
    required String password,
    required String studantId,
  }) async {
    try {
      UserCredential uCred = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = uCred.user;

      if (user != null) {
        await user.updateDisplayName(name);
        await firestore.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'studantId': studantId,
        });
      }
      return null;
    } on FirebaseAuthException catch (err) {
      return Utils.firebaseAuthException(err.code);
    }
  }

  static Widget routeScreen(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          return const HomeScreen();
        }
        return const WelcomeScreen();
      },
    );
  }
}
