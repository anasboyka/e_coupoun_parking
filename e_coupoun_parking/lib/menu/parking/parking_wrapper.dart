import 'package:e_coupoun_parking/menu/parking/parking_page.dart';
import 'package:e_coupoun_parking/menu/parking/parking_status.dart';
import 'package:e_coupoun_parking/models/driveruid.dart';
import 'package:e_coupoun_parking/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ParkingWrapper extends StatelessWidget {
  ParkingWrapper({Key? key}) : super(key: key);

  bool status = true;

  @override
  Widget build(BuildContext context) {
    Driveruid driveruid = Provider.of<Driveruid>(context);
    return StreamBuilder(
        stream: FirebaseService(uid: driveruid.uid).streamParkingStatus(),
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            bool isParking = snapshot.data;
            if (isParking) {
              return ParkingStatus();
            } else {
              return ParkingPage();
            }
          } else {
            return CircularProgressIndicator.adaptive();
          }
        });
    // if (status) {
    //   return ParkingPage();
    // } else {
    //   return ParkingStatus();
    // }
  }
}
