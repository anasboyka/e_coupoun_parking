import 'package:cloud_firestore/cloud_firestore.dart';

class LocationParking {
  final String locationName;
  final String locationSubname;
  final DocumentSnapshot? snapshot;
  final DocumentReference? reference;
  final String? documentID;

  LocationParking({
    required this.locationName,
    required this.locationSubname,
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
    );
  }

  Map<String, dynamic> toMap() => {
        'locationName': locationName,
        'locationSubname': locationSubname,
      };

  LocationParking copyWith({
    String? locationName,
    String? locationSubname,
  }) {
    return LocationParking(
      locationName: locationName ?? this.locationName,
      locationSubname: locationSubname ?? this.locationSubname,
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
