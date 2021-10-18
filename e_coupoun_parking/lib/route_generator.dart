import 'package:e_coupoun_parking/authenticate/loginAdmin.dart';
import 'package:e_coupoun_parking/authenticate/loginOfficer.dart';
import 'package:e_coupoun_parking/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homeScreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(builder: (_) => Wrapper());
      // case '/subBluebook':
      //   return CupertinoPageRoute(
      //       builder: (_) => SubBluebook(bluebookdata: args));
      case '/home':
        return CupertinoPageRoute(builder: (_) => HomeScreen());
      case '/loginadmin':
        return CupertinoPageRoute(builder: (_) => LoginAdminPage());
      case '/loginofficer':
        return CupertinoPageRoute(builder: (_) => LoginOfficerPage());
      default:
        return CupertinoPageRoute(builder: (_) => HomeScreen());
    }
  }
}
