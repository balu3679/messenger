import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger/utils/errors.dart';

class Authentication {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static bool isLoggedIn() {
    return !(FirebaseAuth.instance.currentUser == null);
  }

  static Future<UserCredential?> signUpWithEmailAndPassword(
    String name,
    String email,
    String phone,
    String company,
    String notes,
    String password,
  ) async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
        'email': email,
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'password': password,
        'phone': phone,
        'name': name,
        'company': company,
        'notes': notes,
        'created_at': DateTime.now(),
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      final errorMsg = getFirebaseAuthErrorMessage(e.code, e.message);
      print('FirebaseAuth Error: ${e.code} - ${e.message}');
      throw Exception(errorMsg);
    }
  }

  static Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      final errorMsg = getFirebaseAuthErrorMessage(e.code, e.message);
      print('FirebaseAuth Error: ${e.code} - ${e.message}');
      throw Exception(errorMsg);
    }
  }

  static Future<bool> signOut() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await FirebaseAuth.instance.signOut();
      await googleSignIn.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      final errorMsg = getFirebaseAuthErrorMessage(e.code, e.message);
      print('FirebaseAuth Error: ${e.code} - ${e.message}');
      throw Exception(errorMsg);
    }
  }
}
