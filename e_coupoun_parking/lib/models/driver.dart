import 'package:cloud_firestore/cloud_firestore.dart';

class Driver {
  final String? uid;
  final String? name;
  final String? username;
  final String? phoneNum;
  final String? icNum;
  final DateTime? birthDate;
  final bool? parkingStatus;
  final String? locationId;
  final bool? profileComplete;
  final double? walletBalance;
  final DocumentSnapshot? snapshot;
  final DocumentReference? reference;
  final String? documentID;

  Driver({
    this.uid,
    this.name,
    this.username,
    this.phoneNum,
    this.icNum,
    this.birthDate,
    this.parkingStatus,
    this.locationId,
    this.profileComplete,
    this.walletBalance,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory Driver.fromFirestore(DocumentSnapshot snapshot) {
    // if (snapshot == null) return null;
    dynamic map = snapshot.data();
    return Driver(
      uid: snapshot.id,
      name: map['name'] ?? null,
      username: map['username'] ?? null,
      phoneNum: map['phoneNum'] ?? null,
      birthDate: map['dateOfBirth'] != null
          ? map['dateOfBirth'].toDate()
          : DateTime.parse("1111-11-11"),
      icNum: map['icNum'] ?? null,
      parkingStatus: map['parkingStatus'] ?? null,
      locationId: map['locationId'] ?? null,
      profileComplete: map['profileComplete'] ?? null,
      walletBalance:
          map['walletBalance'] != null ? map['walletBalance'].toDouble() : 0.00,
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }
  Map<String, dynamic> toMap() => {
        'uid': uid,
        'name': name,
        'username': username,
        'phoneNum': phoneNum,
        'dateOfBirth': birthDate,
        'icNum': icNum,
        'parkingStatus': parkingStatus,
        'locationId': locationId,
        'profileComplete': profileComplete,
        'walletBalance': walletBalance,
      };
}
