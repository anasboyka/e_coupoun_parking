//coding untuk handle firebase authentication

import 'package:e_coupoun_parking/models/driver.dart';
import 'package:e_coupoun_parking/models/driveruid.dart';
import 'package:e_coupoun_parking/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  //declare instance untuk firebase authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //declare instance untuk firebase user based on id
  Driveruid? _userFromFirebaseUser(User? user) {
    return Driveruid(uid: user!.uid);
  }

  //check state nak tengok dalam state sign in or dalam state sign out
  Stream<Driveruid?> get user {
    return _auth
        .authStateChanges()
        //.map((User? user) => _userFromFirebaseUser(user!));
        .map(_userFromFirebaseUser);
  }

  //register guna email and password, skali dgn bwak masuk data lain dalam firestore
  Future registerWithEmailAndPassword(
    String email,
    String password,
    String? username,
    String? name,
    String phoneNum,
    String? icNum,
    DateTime? dateOfbirth,
    bool? profileComplete,
    bool? parkingStatus,
  ) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;
      //print(credential.user);
      Driver driver = Driver(
        username: username,
        name: name,
        phoneNum: phoneNum,
        icNum: icNum,
        birthDate: dateOfbirth,
        profileComplete: profileComplete,
        parkingStatus: parkingStatus,
        //walletBalance: 0.00,
      );
      await FirebaseService(uid: user!.uid).updateDriverDataCollection(driver);
      if (credential.user == null) {
        return null;
      } else {
        return credential.user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'passwordweak';
      } else if (e.code == 'email-already-in-use') {
        return 'emailUsed';
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //untuk sign in pakai email dgn password shj
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

  //signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
