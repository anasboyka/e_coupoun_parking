import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  //final String carName;
  final String carBrand;
  final String carType;
  final String carPlateNum;
  final bool parkingStatus;
  final DocumentSnapshot? snapshot;
  final DocumentReference? reference;
  final String? documentID;

  Car({
    //required this.carName,
    required this.carBrand,
    required this.carType,
    required this.carPlateNum,
    required this.parkingStatus,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory Car.fromFirestore(DocumentSnapshot snapshot) {
    // if (snapshot == null) return null;
    dynamic map = snapshot.data()!;

    return Car(
      carBrand: map['carBrand'],
      carType: map['carType'],
      carPlateNum: map['carPlateNum'],
      parkingStatus: map['parkingStatus'],
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  Car copyWith(
      {String? carBrand,
      String? carType,
      String? carPlateNum,
      bool? parkingStatus}) {
    return Car(
        carBrand: carBrand ?? this.carBrand,
        carType: carType ?? this.carType,
        carPlateNum: carPlateNum ?? this.carPlateNum,
        parkingStatus: parkingStatus ?? this.parkingStatus);
  }

  Map<String, dynamic> toMap() => {
        'carBrand': carBrand,
        'carType': carType,
        'carPlateNum': carPlateNum,
        'parkingStatus': parkingStatus
      };

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
        carBrand: map['carBrand'] ?? '',
        carType: map['carType'] ?? '',
        carPlateNum: map['carPlateNum'] ?? '',
        parkingStatus: map['parkingStatus'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory Car.fromJson(String source) => Car.fromMap(json.decode(source));

  @override
  String toString() =>
      'Car(carBrand: $carBrand, carType: $carType, carPlateNum: $carPlateNum)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Car &&
        other.carBrand == carBrand &&
        other.carType == carType &&
        other.carPlateNum == carPlateNum;
  }

  @override
  int get hashCode =>
      carBrand.hashCode ^ carType.hashCode ^ carPlateNum.hashCode;
}
