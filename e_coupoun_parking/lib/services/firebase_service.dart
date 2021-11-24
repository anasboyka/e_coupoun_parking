import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_coupoun_parking/models/car.dart';
import 'package:e_coupoun_parking/models/driver.dart';
import 'package:provider/provider.dart';

class FirebaseService {
  final String? uid;
  FirebaseService({this.uid});

  final CollectionReference driverCollection =
      FirebaseFirestore.instance.collection('drivers');

  final CollectionReference carCollection =
      FirebaseFirestore.instance.collection('cars');

  Future updateDriverDataCollection(String username, String name,
      String phoneNum, String icNum, DateTime birthDate) async {
    return await driverCollection.doc(uid).set({
      "username": username,
      "name": name,
      "phoneNum": phoneNum,
      "icNum": icNum,
      "dateOfBirth": birthDate
    });
  }

  Future updateCarDataCollection(/*String carName,*/ String carBrand,
      String carType, String carPlateNum) async {
    return await carCollection.doc(carPlateNum).set({
      //"carName": carName,
      "carBrand": carBrand,
      "carType": carType,
      "carPlateNum": carPlateNum
    });
  }

  Future updateCarDataFromDriver(/*String carName,*/ String carBrand,
      String carType, String carPlateNum) async {
    return await driverCollection
        .doc(uid)
        .collection('Cars')
        .doc(carPlateNum)
        .set({
      //"carName": carName,
      "carBrand": carBrand,
      "carType": carType,
      "carPlateNum": carPlateNum,
    });
  }

  Future updateDriverDataFromCar(
      String? name,
      String? username,
      String? carPlateNum,
      String? phoneNum,
      String? icNum,
      DateTime? birthDate) async {
    return await carCollection
        .doc(carPlateNum)
        .collection('Drivers')
        .doc(this.uid)
        .set({
      "username": username,
      "name": name,
      "phoneNum": phoneNum,
      "icNum": icNum,
      "dateOfBirth": birthDate
    });
  }

  List<Car> _carListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      return Car(
        //carName: data['carName'],
        carBrand: data['carBrand'],
        carPlateNum: data['carPlateNum'],
        carType: data['carType'],
      );
    }).toList();
  }

  List<Driver> _driverListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      return Driver(
        uid: doc.id,
        username: data['username'],
        phoneNum: data['phoneNum'],
        name: data['name'],
        icNum: data['icNum'],
        birthDate: data['dateOfBirth'],
      );
    }).toList();
  }

  //stream - data dalam bentuk real time xperlu handle
  //data dalam continous loop
  //xperlu call bnyak kali, sbb dia sentiasa berjalan dalam loop
  //slalunya guna untuk update ui tanpa tekan button

  //method untuk dapat stream data untuk cars dalam bentuk list*
  //List<Car> to Stream<List<Car>>*
  //data dalam bentuk stream which means data akan realtime update whenever data berubah.
  Stream<List<Car>> get cars {
    return carCollection.snapshots().map(_carListFromSnapshot);
  }

  Stream<List<Driver>> get drivers {
    return driverCollection.snapshots().map(_driverListFromSnapshot);
  }

  Stream<List<Car>> get userCars {
    return driverCollection
        .doc(this.uid)
        .collection('Cars')
        .snapshots()
        .map(_carListFromSnapshot);
  }

  Stream<Driver?> get driver {
    return driverCollection.doc(this.uid).snapshots().map((doc) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      print(data['name']);
      return Driver(
          uid: this.uid!,
          name: data['name'],
          username: data['username'],
          phoneNum: data['phoneNum'],
          birthDate: data['dateOfBirth'].toDate(),
          icNum: data['icNum']);
    });
  }

  Future<Driver?> get driverinfo async {
    return await driverCollection.doc(this.uid).get().then((data) => Driver(
        uid: this.uid!,
        name: data['name'],
        icNum: data['icNum'],
        birthDate: data['dateOfBirth'].toDate(),
        phoneNum: data['phoneNum'],
        username: data['username']));
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

  Future<bool> checkCarExistFromDriver(String carPlateNum) {
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

  Future<bool> checkCarExistCollection(String carPlateNum) {
    return carCollection.doc(carPlateNum).get().then((snapshot) {
      if (snapshot.exists) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future<Car> getCarInfoFromDriver(String carPlateNum) async {
    return driverCollection
        .doc(this.uid)
        .collection("Cars")
        .doc(carPlateNum)
        .get()
        .then((data) => Car(
              // carName: data['carName'],
              carBrand: data['carBrand'],
              carPlateNum: data['carPlateNum'],
              carType: data['carType'],
            ));
  }

  Future<Car> getCarInfoCollection(String carPlateNum) async {
    return carCollection.doc(carPlateNum).get().then((data) => Car(
          carName: data['carName'],
          carBrand: data['carBrand'],
          carPlateNum: data['carPlateNum'],
          carType: data['carType'],
        ));
  }

  Future<int> getNumberOfCarsFromDriver() async {
    QuerySnapshot doc =
        await driverCollection.doc(this.uid).collection('Cars').get();
    List<DocumentSnapshot> docList = doc.docs;
    print(docList.length);
    return docList.length;
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///test data firebase////

  //test data start
  Future testGetData() async {
    var data = await driverCollection.doc(uid).get();
    return data.data();
  }
  //test data end
}
