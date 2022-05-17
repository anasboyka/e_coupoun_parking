import 'package:cloud_firestore/cloud_firestore.dart';
import 'constant.dart';
import 'models/driver.dart';
import 'models/driveruid.dart';
import 'route_generator.dart';
import 'services/auth.dart';
import 'services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

//test windows

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
        StreamProvider<Driveruid?>.value(
            catchError: (_, __) => null,
            value: AuthService().user,
            initialData: null),
      ],
      child: ScreenUtilInit(
          designSize: const Size(428, 926),
          builder: (BuildContext context) {
            return MaterialApp(
              title: 'E-Coupoun Parking',
              debugShowCheckedModeBanner: false,
              //theme: ThemeData(primaryColor: kprimaryColor),
              initialRoute: '/',
              onGenerateRoute: RouteGenerator.generateRoute,
            );
          }),
    );
  }
}
