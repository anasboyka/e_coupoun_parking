import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_coupoun_parking/constant.dart';
import 'package:e_coupoun_parking/models/driver.dart';
import 'package:e_coupoun_parking/route_generator.dart';
import 'package:e_coupoun_parking/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 //test
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Driver?>.value(
            catchError: (_, __) => null,
            value: AuthService().user,
            initialData: null),
      ],
      child: MaterialApp(
        title: 'E-Coupoun Parking',
        debugShowCheckedModeBanner: false,
        //theme: ThemeData(primaryColor: kprimaryColor),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
