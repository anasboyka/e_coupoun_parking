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
      //FirebaseProvider firebaseProvider = FirebaseProvider(uid: driveruid.uid);

      return MultiProvider(
        providers: [
          //ChangeNotifierProvider(create:(context)=> FirebaseProvider(uid: driveruid.uid).driverInfo),
          // FutureProvider<Driver?>(
          //     create: (context) =>
          //         FirebaseService(uid: driveruid.uid).driverinfo,
          //     initialData: null),
          // ChangeNotifierProvider<FirebaseProvider>.value(
          //   value: FirebaseProvider(uid: driveruid.uid),
          // )
          // ChangeNotifierProvider<FirebaseProvider>.value(
          //   value: FirebaseProvider(
          //       uid: driveruid.uid, driverInfo: Provider.of<Driver?>(context)),
          // ),
          StreamProvider<Driver?>(
            create: (context) => FirebaseService(uid: driveruid.uid).driver,
            initialData: null,
          ),
        ],
        child: HomeScreen(),
      );
    }
  }
}
