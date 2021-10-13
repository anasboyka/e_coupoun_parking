import 'package:e_coupoun_parking/authenticate/login.dart';
import 'package:e_coupoun_parking/authenticate/register.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showlogin = true;

  void toggleview() {
    setState(() {
      showlogin = !showlogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!showlogin) {
      return Register(toggleview: toggleview);
    } else {
      return Login(toggleview: toggleview);
    }
  }
}
