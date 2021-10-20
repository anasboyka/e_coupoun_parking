import 'package:e_coupoun_parking/homeScreen.dart';
import 'package:flutter/material.dart';

import 'authenticate/Authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<UserFirebase>(context);
    final user = null;

    if (user == null) {
      return Authentication();
      //return HomeScreen();

    } else {
      return HomeScreen();
    }
  }
}
