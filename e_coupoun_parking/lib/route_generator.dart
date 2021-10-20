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
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
          return Wrapper();
        }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          final offsetAnimation = animation.drive(tween);
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        });
      // case '/subBluebook':
      //   return CupertinoPageRoute(
      //       builder: (_) => SubBluebook(bluebookdata: args));
      case '/home':
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
          return HomeScreen();
        }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          final offsetAnimation = animation.drive(tween);
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        });
      case '/loginadmin':
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
          return LoginAdminPage();
        }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          final offsetAnimation = animation.drive(tween);
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        });
      case '/loginofficer':
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
          return LoginOfficerPage();
        }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          final offsetAnimation = animation.drive(tween);
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        });

      default:
        return CupertinoPageRoute(builder: (_) => HomeScreen());
    }
  }
  
}
