import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_coupoun_parking/constant.dart';
import 'package:e_coupoun_parking/models/driver.dart';
import 'package:e_coupoun_parking/models/driveruid.dart';
import 'package:e_coupoun_parking/route_generator.dart';
import 'package:e_coupoun_parking/services/auth.dart';
import 'package:e_coupoun_parking/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// test pullll
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return MultiProvider(
      providers: [
        StreamProvider<Driveruid?>.value(
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
