import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_coupoun_parking/provider/location_provider.dart';
import 'package:e_coupoun_parking/services/location_services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:workmanager/workmanager.dart';
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
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     switch (task) {
//       case 'taskName':
//         print('$inputData runninggggg');
//         print(DateTime.now());
//         await Future.delayed(Duration(seconds: 3));
//         // await FirebaseService(uid: inputData['driveruid'])
//         //     .updateDriverParkingStatus(false, null);
//         // await FirebaseService(uid: inputData['driveruid'])
//         //     .updateCarParkingStatus(inputData['carid'], false, null);
//         print('done');
//         break;
//       default:
//     }
//     return Future.value(true);
//   });
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  Position? position = await LocationServices().initPosition();
  runApp(MultiProvider(
    providers: [
      StreamProvider<Driveruid?>.value(
          catchError: (_, __) => null,
          value: AuthService().user,
          initialData: null),
      ChangeNotifierProvider<LocationProvider>.value(
          value: LocationProvider(position: position))
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        // MultiProvider(
        //   providers: [
        //     StreamProvider<Driveruid?>.value(
        //         catchError: (_, __) => null,
        //         value: AuthService().user,
        //         initialData: null),
        //   ],
        //   child:
        ScreenUtilInit(
            designSize: const Size(428, 926),
            builder: (child) {
              return MaterialApp(
                title: 'E-Coupoun Parking',
                debugShowCheckedModeBanner: false,
                //theme: ThemeData(primaryColor: kprimaryColor),
                initialRoute: '/',
                onGenerateRoute: RouteGenerator.generateRoute,
              );
            });
    //  );
  }
}
