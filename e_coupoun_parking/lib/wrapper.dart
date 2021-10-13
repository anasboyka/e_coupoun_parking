import 'package:e_coupoun_parking/authenticate/authenticate.dart';
import 'package:e_coupoun_parking/homeScreen.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<UserFirebase>(context);
    final user = null;

    if (user == null) {
      return Authenticate();
    } else {
      return HomeScreen();
    }
  }
}
