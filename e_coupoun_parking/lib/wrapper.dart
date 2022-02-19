//ubah screen based on sign in condition

import 'package:e_coupoun_parking/homeScreen.dart';
import 'package:e_coupoun_parking/menu/register_car/register_Input.dart';
import 'package:e_coupoun_parking/menu/register_car/register_car.dart';
import 'package:e_coupoun_parking/models/driver.dart';
import 'package:e_coupoun_parking/models/driveruid.dart';
import 'package:e_coupoun_parking/provider/firebaseProvider.dart';
import 'package:e_coupoun_parking/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authenticate/Authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final driveruid = Provider.of<Driveruid?>(context);

    if (driveruid == null) {
      return Authentication();
    } else {
      //final firebaseService = FirebaseService(uid: driveruid.uid);
      // final firebaseProvider = FirebaseProvider(uid: driveruid.uid);

      return MultiProvider(
        providers: [
          FutureProvider<Driver?>(
              create: (context) =>
                  FirebaseService(uid: driveruid.uid).driverinfo,
              initialData: null),
          ChangeNotifierProvider.value(
              value: FirebaseProvider(uid: driveruid.uid))
        ],
        child: HomeScreen(),
      );
    }
  }
}
