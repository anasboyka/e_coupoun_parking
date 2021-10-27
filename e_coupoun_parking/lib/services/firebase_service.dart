import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final String? uid;
  FirebaseService({this.uid});
  final CollectionReference driverCollection =
      FirebaseFirestore.instance.collection('drivers');
  final CollectionReference carCollection =
      FirebaseFirestore.instance.collection('cars');

  Future updateDriverData(String username, String name, String phoneNum,
      String icNum, DateTime birthDate) async {
    return await driverCollection.doc(uid).set({
      "username":username,
      "name": name,
      "phoneNum": phoneNum,
      "icNum": icNum,
      "dateOfBirth": birthDate
    });
  }

  Stream get drivers {
    return driverCollection.snapshots();
  }

  Future updateCarData(String carBrand, String carType, String carPlateNum,
      DateTime carOwnerType) async {
    return await carCollection.doc(uid).set({
      "carBrand": carBrand,
      "carType": carType,
      "carPlateNum": carPlateNum,
      "carOwnerType": carOwnerType
    });
  }

  Stream get cars {
    return carCollection.snapshots();
  }

  //test data start
  Future testGetData() async {
    var data = await driverCollection.doc(uid).get();
    return data.data();
  }
  //test data end

}
