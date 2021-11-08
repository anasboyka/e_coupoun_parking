import 'package:e_coupoun_parking/models/driver.dart';
import 'package:e_coupoun_parking/models/driveruid.dart';
import 'package:e_coupoun_parking/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  Driveruid _userFromFirebaseUser(User? user) {
    
    return Driveruid(uid: user!.uid);
  }

  Stream<Driveruid?> get user {
    return _auth
        .authStateChanges()
        //.map((User? user) => _userFromFirebaseUser(user!));
        .map(_userFromFirebaseUser);
  }

  Future registerWithEmailAndPassword(
      String email,
      String password,
      String username,
      String name,
      String phoneNum,
      String icNum,
      DateTime dateOfbirth) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;
      print(credential.user);
      await FirebaseService(uid: user!.uid)
          .updateDriverDataCollection(username, name, phoneNum, icNum, dateOfbirth);
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
