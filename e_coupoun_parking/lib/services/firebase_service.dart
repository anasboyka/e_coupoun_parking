

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService{
  final String uid;
  FirebaseService({required this.uid});
  final CollectionReference parkingCollection = FirebaseFirestore.instance.collection('drivers');
  Future testGetData()async{
    var data = await parkingCollection.doc(uid).get();
    return data.data();
  }

}