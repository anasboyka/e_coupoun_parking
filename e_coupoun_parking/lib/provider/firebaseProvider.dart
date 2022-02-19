import 'package:e_coupoun_parking/models/car.dart';
import 'package:e_coupoun_parking/models/driver.dart';
import 'package:e_coupoun_parking/services/firebase_service.dart';
import 'package:flutter/material.dart';

class FirebaseProvider with ChangeNotifier {
  String uid;
  Driver? driverInfo;
  Car? carInfo;
  List<Car>? carList;

  FirebaseProvider({required this.uid, this.driverInfo});

  void init() async {
    Driver? driver = await FirebaseService(uid: this.uid).driverinfo;
    this.driverInfo = driver;
    notifyListeners();
  }

  void setDriverInfo(Driver driver) async {
    this.driverInfo = driver;
    notifyListeners();
  }

  Driver get getDriverInfo => driverInfo!;
}
