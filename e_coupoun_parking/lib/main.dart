import 'package:e_coupoun_parking/constant.dart';
import 'package:e_coupoun_parking/route_generator.dart';
import 'package:flutter/material.dart';

//test push
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Coupoun Parking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: kprimaryColor),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
