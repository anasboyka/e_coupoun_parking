import 'package:e_coupoun_parking/homeScreen.dart';
import 'package:e_coupoun_parking/menu/register_car/register_Input.dart';
import 'package:e_coupoun_parking/menu/register_car/register_car.dart';
import 'package:e_coupoun_parking/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authenticate/Authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final driver = Provider.of<Driver?>(context);
    final user = null;

    if (driver == null) {
      //return RegisterCar();
      //return RegisterCarInput();
      return Authentication();
      //return HomeScreen();
    } else {
      return HomeScreen();
    }
  }
}
