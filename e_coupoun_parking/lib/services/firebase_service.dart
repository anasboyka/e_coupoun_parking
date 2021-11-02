import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_coupoun_parking/models/car.dart';

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
      "username": username,
      "name": name,
      "phoneNum": phoneNum,
      "icNum": icNum,
      "dateOfBirth": birthDate
    });
  }

  Stream get drivers {
    return driverCollection.snapshots();
  }

  Future updateCarDataDriver(String carBrand, String carType,
      String carPlateNum, String carOwnerType) async {
    return await driverCollection
        .doc(uid)
        .collection('Cars')
        .doc(carPlateNum)
        .set({
      "carBrand": carBrand,
      "carType": carType,
      "carPlateNum": carPlateNum,
      "carOwnerType": carOwnerType
    });
  }

  Future updateCarDataCollection(String carBrand, String carType,
      String carPlateNum, String carOwnerType) async {
    return await carCollection.doc(carPlateNum).set({
      "carBrand": carBrand,
      "carType": carType,
      "carPlateNum": carPlateNum,
      "carOwnerType": carOwnerType
    });
  }

  List<Car> _carListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      return Car(
          carBrand: data['carBrand'],
          carOwnerType: data['carOwnerType'],
          carPlateNum: data['carPlateNum'],
          carType: data['carType']);
    }).toList();
  }

  Stream<List<Car>> get cars {
    return carCollection.snapshots().map(_carListFromSnapshot);
  }

  Stream<List<Car>> get userCars {
    return driverCollection
        .doc(this.uid)
        .collection('Cars')
        .snapshots()
        .map(_carListFromSnapshot);
  }

  Future<void> deleteCar(String carPlateNum) {
    return carCollection.doc(carPlateNum).delete();
  }

  Future<void> deleteCarFromUser(String carPlateNum) {
    return driverCollection
        .doc(this.uid)
        .collection('Cars')
        .doc(carPlateNum)
        .delete();
  }

  Future<bool> checkCarExistFromUser(String carPlateNum) {
    return driverCollection
        .doc(this.uid)
        .collection('Cars')
        .doc(carPlateNum)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future<bool> checkCarExist(String carPlateNum) {
    return carCollection.doc(carPlateNum).get().then((snapshot) {
      if (snapshot.exists) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future<int> getNumberOfCarsFromDriver() async {
    QuerySnapshot doc =
        await driverCollection.doc(this.uid).collection('Cars').get();
    List<DocumentSnapshot> docList = doc.docs;
    print(docList.length);
    return docList.length;
  }

  //test data start
  Future testGetData() async {
    var data = await driverCollection.doc(uid).get();
    return data.data();
  }
  //test data end

}
