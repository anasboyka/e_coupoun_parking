//untuk CRUD punya firestore query

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_coupoun_parking/models/car.dart';
import 'package:e_coupoun_parking/models/driver.dart';
import 'package:provider/provider.dart';

class FirebaseService {
  //untuk assign user id siap2 bila call untuk buat query
  final String? uid;
  FirebaseService({this.uid});

  //declare instance untuk collection drivers
  final CollectionReference driverCollection =
      FirebaseFirestore.instance.collection('drivers');

  //declare instance untuk collection cars
  final CollectionReference carCollection =
      FirebaseFirestore.instance.collection('cars');

  //method untuk CRUD query

  //query untuk drivers punya collection untuk new user or existed user*
  //kalau data tu document id exist, update data tu... kalau x exist, tambah data tu
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

  //query untuk cars punya collection untuk new car or existed car*
  //kalau data tu document id exist, update data tu... kalau x exist, tambah data tu
  Future updateCarDataCollection(/*String carName,*/ String carBrand,
      String carType, String carPlateNum) async {
    return await carCollection.doc(carPlateNum).set({
      //"carName": carName,
      "carBrand": carBrand,
      "carType": carType,
      "carPlateNum": carPlateNum
    });
  }

  //query untuk cars punya subcollection from driver punya collection*
  //kalau data tu document id exist, update data tu... kalau x exist, tambah data tu
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

  //query untuk driver punya subcollection from cars punya collection*
  //kalau data tu document id exist, update data tu... kalau x exist, tambah data tu
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

  //method untuk get data from firestore
  //guna untuk generate List dalam bentuk instance Car(refer car.dart dalam folder models)*
  //act as converter nak tukaq data from firestore dalam bentuk querysnapshot kepada bentuk List untuk mudah kerja
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

  //method untuk get data from firestore
  //guna untuk generate List dalam bentuk instance Driver(refer driver.dart dalam folder models)*
  //act as converter nak tukaq data from firestore dalam bentuk querysnapshot kepada bentuk List untuk mudah kerja
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

  //method untuk dapat stream data untuk drivers dalam bentuk list*
  //List<Driver> to Stream<List<Driver>>*
  //data dalam bentuk stream which means data akan realtime update whenever data berubah.
  Stream<List<Driver>> get drivers {
    return driverCollection.snapshots().map(_driverListFromSnapshot);
  }

  //method untuk dapat stream data untuk Car dalam bentuk list*
  //List<Car> to Stream<List<Car>>*
  //data dalam bentuk stream which means data akan realtime update whenever data berubah.
  Stream<List<Car>> get userCars {
    return driverCollection
        .doc(this.uid)
        .collection('Cars')
        .snapshots()
        .map(_carListFromSnapshot);
  }

  //method untuk dapat stream data untuk sorang driver sahaja from firestore based on current user id*
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

  //future - data dalam bentuk asynchronous, which means dia kena tunggu and proceed lepas selesai task dia...
  //next line dalam coding x kan berjalan selagi task x abis
  //request jadi lepas perkataan await
  //slalunya guna untuk request dataa yg kemungkinan amik masa. terjadi bila call sahaja.

  //method untuk get data untuk driver from firestore
  //convert requested data dalam bentuk instance Driver
  Future<Driver?> get driverinfo async {
    return await driverCollection.doc(this.uid).get().then((data) => Driver(
        uid: this.uid!,
        name: data['name'],
        icNum: data['icNum'],
        birthDate: data['dateOfBirth'].toDate(),
        phoneNum: data['phoneNum'],
        username: data['username']));
  }

  //method untuk delete data kat firestore which is from cars collection
  //the specified document will be deleted and all the data from that document will be gone
  Future<void> deleteCar(String carPlateNum) {
    return carCollection.doc(carPlateNum).delete();
  }

  //method untuk delete data kat firestore which is from drivers collection
  //the specified document will be deleted and all the data from that document will be gone
  Future<void> deleteCarFromUser(String carPlateNum) {
    return driverCollection
        .doc(this.uid)
        .collection('Cars')
        .doc(carPlateNum)
        .delete();
  }

  //method untuk check data car exist ke x untuk current driver dalam drivers collection*
  //check based on driver id dgn carplateNum*
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

  //method untuk check data car exist ke x dalam cars collection*
  //check based on carplateNum*
  Future<bool> checkCarExistCollection(String carPlateNum) {
    return carCollection.doc(carPlateNum).get().then((snapshot) {
      if (snapshot.exists) {
        return true;
      } else {
        return false;
      }
    });
  }

  //method untuk get data car for current driver from car subcollection in driver collection*
  //check based on driver id dgn carplateNum*
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

  //method untuk get data car for current driver from car collection*
  //check based on carplateNum*
  Future<Car> getCarInfoCollection(String carPlateNum) async {
    return carCollection.doc(carPlateNum).get().then((data) => Car(
          carName: data['carName'],
          carBrand: data['carBrand'],
          carPlateNum: data['carPlateNum'],
          carType: data['carType'],
        ));
  }

  //method untuk get data number of cars for current driver from driver collection*
  //check based on driver id dgn carplateNum*
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
