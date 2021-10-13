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
      default:
        return CupertinoPageRoute(builder: (_) => HomeScreen());
    }
  }
}
