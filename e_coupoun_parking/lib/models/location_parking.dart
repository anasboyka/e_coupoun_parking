import 'package:cloud_firestore/cloud_firestore.dart';

class LocationParking {
  String locationName;
  String locationSubname;
  GeoPoint geoPoint;
  DocumentSnapshot? snapshot;
  DocumentReference? reference;
  String? documentID;

  LocationParking({
    required this.locationName,
    required this.locationSubname,
    required this.geoPoint,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory LocationParking.fromFirestore(DocumentSnapshot snapshot) {
    // if (snapshot == null) return null;
    dynamic map = snapshot.data()!;

    return LocationParking(
      locationName: map['locationName'],
      locationSubname: map['locationSubname'],
      geoPoint: map['geoPoint'],
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  factory LocationParking.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return LocationParking(
        locationName: map['locationName'],
        locationSubname: map['locationSubname'],
        geoPoint: map['geoPoint']);
  }

  Map<String, dynamic> toMap() => {
        'locationName': locationName,
        'locationSubname': locationSubname,
        'geoPoint': geoPoint,
      };

  LocationParking copyWith({
    String? locationName,
    String? locationSubname,
    GeoPoint? geoPoint,
  }) {
    return LocationParking(
      locationName: locationName ?? this.locationName,
      locationSubname: locationSubname ?? this.locationSubname,
      geoPoint: geoPoint ?? this.geoPoint,
    );
  }

  @override
  String toString() {
    return '${locationName.toString()}, ${locationSubname.toString()}, ';
  }

  @override
  bool operator ==(other) =>
      other is LocationParking && documentID == other.documentID;

  int get hashCode => documentID.hashCode;
}
