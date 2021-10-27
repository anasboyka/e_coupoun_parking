import 'package:e_coupoun_parking/models/user.dart';
import 'package:e_coupoun_parking/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Driver _userFromFirebaseUser(User? user) {
    // ignore: unnecessary_null_comparison
    return Driver(uid: user!.uid);
  }

  Stream<Driver> get user {
    return _auth
        .authStateChanges()
        //.map((User? user) => _userFromFirebaseUser(user!));
        .map(_userFromFirebaseUser);
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;
      print(credential.user);
      await FirebaseService(uid: user!.uid).updateDriverData(
          'username', "name", 'phoneNum', 'icNum', DateTime.now());
      if (credential.user == null) {
        return null;
      } else {
        return credential.user;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;
      print(credential.user);
      if (credential.user == null) {
        return null;
      } else {
        return credential.user;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
