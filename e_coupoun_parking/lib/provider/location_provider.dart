import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  Position? position;
  LocationProvider({
    this.position,
  });

  // void getLatlang(){
  //   var pos = position.
  // }
}
