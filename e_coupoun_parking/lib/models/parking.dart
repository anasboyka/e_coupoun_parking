import 'package:cloud_firestore/cloud_firestore.dart';

class Parking {
  final double cost;
  final DateTime date;
  final int duration;
  final DateTime startTime;
  final DateTime endTime;
  final String? carId;
  //final DocumentReference? carRef;
  final String? driverId;
  //final DocumentReference? driverRef;
  final String? locationId;
  //final DocumentReference? locationRef;
  final String? locationName;
  final DocumentSnapshot? snapshot;
  final DocumentReference? reference;
  final String? documentID;

  Parking({
    required this.cost,
    required this.date,
    required this.duration,
    required this.startTime,
    required this.endTime,
    this.carId,
    //this.carRef,
    this.driverId,
    //this.driverRef,
    this.locationId,
    //this.locationRef,
    this.locationName,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory Parking.fromFirestore(DocumentSnapshot snapshot) {
    // if (snapshot == null) return null;
    dynamic map = snapshot.data();

    return Parking(
      cost: map['cost'],
      date: map['date']?.toDate(),
      duration: map['duration'],
      startTime: map['startTime']?.toDate(),
      endTime: map['endTime']?.toDate(),
      carId: map['carId'] ?? null,
      //carRef: map['carRef'] ?? null,
      driverId: map['driverId'] ?? null,
      //driverRef: map['drverRef'] ?? null,
      locationId: map['locationId'] ?? null,
      //locationRef: map['locationRef'] ?? null,
      locationName: map['locationName'] ?? null,
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  factory Parking.fromMap(Map<String, dynamic> map) {
    //if (map == null) return null;

    return Parking(
      cost: map['cost'],
      date: map['date']?.toDate(),
      duration: map['duration'],
      startTime: map['startTime']?.toDate(),
      endTime: map['endTime']?.toDate(),
      carId: map['carId'] ?? null,
      //carRef: map['carRef'] ?? null,
      driverId: map['driverId'] ?? null,
      //driverRef: map['drverRef'] ?? null,
      locationId: map['locationId'] ?? null,
      //locationRef: map['locationRef'] ?? null,
      locationName: map['locationName'] ?? null,
    );
  }

  Map<String, dynamic> toMap() => {
        'cost': cost,
        'date': date,
        'duration': duration,
        'startTime': startTime,
        'endTime': endTime,
        'carId': carId,
        //'carRef': carRef,
        'driverId': driverId,
        //'driverRef': driverRef,
        'locationId': locationId,
        //'locationRef': locationRef,
        'locationName': locationName,
      };

  Parking copyWith({
    required double cost,
    required DateTime date,
    required int duration,
    required DateTime startTime,
    required DateTime endTime,
    String? carId,
    String? driverId,
    String? locationId,
    String? locationName,
  }) {
    return Parking(
        cost: cost,
        date: date,
        duration: duration,
        startTime: startTime,
        endTime: endTime,
        carId: carId ?? this.carId,
        driverId: driverId ?? this.driverId,
        locationId: locationId ?? this.locationId,
        locationName: locationName ?? this.locationName);
  }

  @override
  String toString() {
    return '${cost.toString()}, ${date.toString()}, ${duration.toString()}, ${startTime.toString()}, ${endTime.toString()}, ${carId.toString()}, ${driverId.toString()}, ${locationId.toString()}, ';
  }

  @override
  bool operator ==(other) => other is Parking && documentID == other.documentID;

  int get hashCode => documentID.hashCode;
}
