import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionHistory {
  final double amount;
  final DateTime date;
  final Map? description;
  final bool isPaid;
  final String? type;
  final DocumentSnapshot? snapshot;
  final DocumentReference? reference;
  final String? documentID;

  TransactionHistory({
    required this.amount,
    required this.date,
    this.description,
    required this.isPaid,
    this.type,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory TransactionHistory.fromFirestore(DocumentSnapshot snapshot) {
    //if (snapshot == null) return null;
    dynamic map = snapshot.data();

    return TransactionHistory(
      amount: map['amount'],
      date: map['date']?.toDate(),
      description: map['description'],
      isPaid: map['isPaid'],
      type: map['type'],
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  factory TransactionHistory.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return TransactionHistory(
      amount: map['amount'],
      date: map['date']?.toDate(),
      description: map['description'],
      isPaid: map['isPaid'],
      type: map['type'],
    );
  }

  Map<String, dynamic> toMap() => {
        'amount': amount,
        'date': date,
        'description': description,
        'isPaid': isPaid,
        'type': type,
      };

  TransactionHistory copyWith({
    required double amount,
    required DateTime date,
    Map? description,
    required bool isPaid,
    String? type,
  }) {
    return TransactionHistory(
      amount: amount,
      date: date,
      description: description ?? this.description,
      isPaid: isPaid,
      type: type ?? this.type,
    );
  }

  @override
  String toString() {
    return '${amount.toString()}, ${date.toString()}, ${description.toString()}, ${isPaid.toString()}, ${type.toString()}, ';
  }

  @override
  bool operator ==(other) =>
      other is TransactionHistory && documentID == other.documentID;

  int get hashCode => documentID.hashCode;
}
