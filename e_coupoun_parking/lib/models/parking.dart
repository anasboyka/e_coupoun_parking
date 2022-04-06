import 'package:cloud_firestore/cloud_firestore.dart';

class Parking {
  final double cost;
  final DateTime date;
  final int duration;
  final DateTime startTime;
  final DateTime endTime;
  final DocumentReference? carId;
  final DocumentReference? driverId;
  final DocumentReference? locationId;
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
    this.driverId,
    this.locationId,
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
      driverId: map['driverId'] ?? null,
      locationId: map['locationId'] ?? null,
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
      driverId: map['driverId'] ?? null,
      locationId: map['locationId'] ?? null,
    );
  }

  Map<String, dynamic> toMap() => {
        'cost': cost,
        'date': date,
        'duration': duration,
        'startTime': startTime,
        'endTime': endTime,
        'carId': carId,
        'driverId': driverId,
        'locationId': locationId,
      };

  Parking copyWith({
    required double cost,
    required DateTime date,
    required int duration,
    required DateTime startTime,
    required DateTime endTime,
    DocumentReference? carId,
    DocumentReference? driverId,
    DocumentReference? locationId,
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
    );
  }

  @override
  String toString() {
    return '${cost.toString()}, ${date.toString()}, ${duration.toString()}, ${startTime.toString()}, ${endTime.toString()}, ${carId.toString()}, ${driverId.toString()}, ${locationId.toString()}, ';
  }

  @override
  bool operator ==(other) => other is Parking && documentID == other.documentID;

  int get hashCode => documentID.hashCode;
}
