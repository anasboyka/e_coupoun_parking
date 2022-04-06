import 'package:cloud_firestore/cloud_firestore.dart';

class Compound {
  final double amount;
  final bool read;
  final String status;
  final DateTime dateCompoundStart;
  final DateTime dateCompoundEnd;
  final DateTime? datePaid;
  final DocumentReference? officerId;
  final DocumentReference? parkingId;
  final DocumentSnapshot? snapshot;
  final DocumentReference? reference;
  final String? documentID;

  Compound({
    required this.amount,
    required this.read,
    required this.status,
    required this.dateCompoundStart,
    required this.dateCompoundEnd,
    this.officerId,
    this.parkingId,
    this.datePaid,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory Compound.fromFirestore(DocumentSnapshot snapshot) {
    //if (snapshot == null) return null;
    dynamic map = snapshot.data();

    return Compound(
      amount: map['amount'],
      read: map['read'],
      status: map['status'],
      dateCompoundStart: map['dateCompoundStart']?.toDate(),
      dateCompoundEnd: map['dateCompoundEnd']?.toDate(),
      datePaid: map['datePaid']?.toDate() ?? null,
      officerId: map['officerId'],
      parkingId: map['parkingId'],
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  factory Compound.fromMap(Map<String, dynamic> map) {
    //if (map == null) return null;

    return Compound(
      amount: map['amount'],
      read: map['read'],
      status: map['status'],
      dateCompoundStart: map['dateCompoundStart']?.toDate(),
      dateCompoundEnd: map['dateCompoundEnd']?.toDate(),
      datePaid: map['datePaid']?.toDate() ?? null,
      officerId: map['officerId'],
      parkingId: map['parkingId'],
    );
  }

  Map<String, dynamic> toMap() => {
        'amount': amount,
        'read': read,
        'status': status,
        'dateCompoundStart': dateCompoundStart,
        'dateCompoundEnd': dateCompoundEnd,
        'datePaid': datePaid,
      };

  Compound copyWith({
    required double amount,
    required bool read,
    required String status,
    required DateTime dateCompoundStart,
    required DateTime dateCompoundEnd,
    DateTime? datePaid,
    required DocumentReference officerId,
    required DocumentReference parkingId,
  }) {
    return Compound(
      amount: amount,
      read: read,
      status: status,
      dateCompoundStart: dateCompoundStart,
      dateCompoundEnd: dateCompoundEnd,
      datePaid: datePaid,
      officerId: officerId,
      parkingId: parkingId,
    );
  }

  @override
  String toString() {
    return '${amount.toString()}, ${read.toString()}, ${status.toString()}, ${dateCompoundStart.toString()},${dateCompoundEnd.toString()}, ${datePaid.toString()}, ';
  }

  @override
  bool operator ==(other) =>
      other is Compound && documentID == other.documentID;

  int get hashCode => documentID.hashCode;
}
