import 'package:cloud_firestore/cloud_firestore.dart';

class Compound {
  //final double amount;
  final bool isPaid;
  final String carId;
  final String carBrand;
  final DateTime dateIssued;
  final DateTime? datePaid;
  final String officerId;
  final String locationId;
  final String locationName;
  final String invoiceNum;

  final DocumentSnapshot? snapshot;
  final DocumentReference? reference;
  final String? documentID;

  Compound({
    //required this.amount,
    required this.isPaid,
    required this.carId,
    required this.carBrand,
    required this.dateIssued,
    required this.officerId,
    required this.locationId,
    required this.locationName,
    required this.invoiceNum,
    this.datePaid,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory Compound.fromFirestore(DocumentSnapshot snapshot) {
    //if (snapshot == null) return null;
    dynamic map = snapshot.data();

    return Compound(
      //amount: map['amount'].toDouble(),
      isPaid: map['isPaid'],
      carId: map['carId'],
      carBrand: map['carBrand'],
      dateIssued: map['dateIssued']?.toDate(),
      officerId: map['officerId'],
      locationId: map['locationId'],
      locationName: map['locationName'],
      datePaid: map['dateIssued']?.toDate(),
      invoiceNum: map['invoiceNum'],
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  factory Compound.fromMap(Map<String, dynamic> map) {
    //if (map == null) return null;

    return Compound(
      //amount: map['amount'],
      isPaid: map['isPaid'],
      carId: map['carId'],
      carBrand: map['carBrand'],
      dateIssued: map['dateIssued']?.toDate(),
      officerId: map['officerId'],
      locationId: map['locationId'],
      locationName: map['locationName'],
      datePaid: map['datePaid']?.toDate(),
      invoiceNum: map['invoiceNum'],
    );
  }

  Map<String, dynamic> toMap() => {
        //'amount': amount,
        'isPaid': isPaid,
        'carId': carId,
        'carBrand': carBrand,
        'dateIssued': dateIssued,
        'officerId': officerId,
        'datePaid': datePaid,
        'locationId': locationId,
        'locationName': locationName,
        'invoiceNum': invoiceNum,
      };

  Compound copyWith({
    required double amount,
    required bool isPaid,
    required String carId,
    required String carBrand,
    required DateTime dateIssued,
    DateTime? datePaid,
    required String officerId,
    required String locationId,
    required String locationName,
    required String invoiceNum,
  }) {
    return Compound(
      //amount: this.amount,
      isPaid: this.isPaid,
      carId: this.carId,
      carBrand: this.carBrand,
      dateIssued: this.dateIssued,
      datePaid: this.datePaid,
      officerId: this.officerId,
      locationId: this.locationId,
      locationName: this.locationName,
      invoiceNum: this.invoiceNum,
    );
  }

  @override
  String toString() {
    return '{amount.toString()}, ${isPaid.toString()}, ${carId.toString()}, ${dateIssued.toString()},${officerId.toString()}, ${datePaid.toString()}, ';
  }

  @override
  bool operator ==(other) =>
      other is Compound && documentID == other.documentID;

  int get hashCode => documentID.hashCode;
}
