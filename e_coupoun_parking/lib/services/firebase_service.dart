//untuk CRUD punya firestore query

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_coupoun_parking/models/car.dart';
import 'package:e_coupoun_parking/models/compound.dart';
import 'package:e_coupoun_parking/models/driver.dart';
import 'package:e_coupoun_parking/models/location_parking.dart';
import 'package:e_coupoun_parking/models/parking.dart';
import 'package:e_coupoun_parking/models/transaction_history.dart';
import 'package:flutter/material.dart';

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

  // final CollectionReference carDriverCollection =
  //     FirebaseFirestore.instance.collection('cars_drivers');

  final CollectionReference locationParkCollection =
      FirebaseFirestore.instance.collection('locations');

  final CollectionReference parkingCollection =
      FirebaseFirestore.instance.collection('parkings');

  final CollectionReference compoundCollection =
      FirebaseFirestore.instance.collection('compounds');

  //method untuk CRUD query

  //query untuk drivers punya collection untuk new user or existed user*
  //kalau data tu document id exist, update data tu... kalau x exist, tambah data tu
  // Future updateDriverDataCollection(
  //     String? username,
  //     String? name,
  //     String? phoneNum,
  //     String? icNum,
  //     DateTime? birthDate,
  //     bool? profileComplete,
  //     bool? parkingStatus) async {
  //   return await driverCollection.doc(uid).set({
  //     "username": username,
  //     "name": name,
  //     "phoneNum": phoneNum,
  //     "icNum": icNum,
  //     "dateOfBirth": birthDate,
  //     "profileComplete": profileComplete,
  //     "parkingStatus": parkingStatus
  //   });
  // }

  Future updateDriverDataCollection(Driver driver) async {
    return await driverCollection.doc(uid).set(driver.toMap());
  }

  //query untuk cars punya collection untuk new car or existed car*
  //kalau data tu document id exist, update data tu... kalau x exist, tambah data tu
  Future updateCarDataCollection(
      //String carBrand,
      // String carType, String carPlateNum
      Car car) async {
    return await carCollection.doc(car.carPlateNum).set(car.toMap()
        //   {
        //   "carBrand": carBrand,
        //   "carType": carType,
        //   "carPlateNum": carPlateNum
        // }
        );
  }

  // Future updateLocationDataCollection(LocationParking locationParking) async {
  //   return await LocationParkCollection.add(locationParking.toMap());
  // }

  Future updateParkingDataCollection(Parking parking) async {
    return await parkingCollection.add(parking.toMap());
  }

  Future updateUserTransactionHistory(
      TransactionHistory transactionHistory) async {
    return await driverCollection.doc(uid).collection('transactions').add(
          transactionHistory.toMap(),
        );
  }

  //query untuk cars punya subcollection from driver punya collection*
  //kalau data tu document id exist, update data tu... kalau x exist, tambah data tu
  Future updateCarDataInDriverCollection(
      // String carBrand,
      //   String carType, String carPlateNum,
      Car car) async {
    DocumentReference docRef =
        driverCollection.doc('$uid/Cars/${car.carPlateNum}');
    // DocumentReference docRef = driverCollection.doc('$uid/Cars/$carPlateNum');
    // DocumentSnapshot docSnap = await carCollection.doc(carPlateNum).get();
    docRef.set(
      car.toMap(),
      //   {
      //   "carBrand": carBrand,
      //   "carType": carType,
      //   "carPlateNum": carPlateNum,
      //   "carRef": carCollection.doc(carPlateNum),
      //   "documentID": carPlateNum,
      //   // "snapsot": docSnap
      // }
    );

    // return await driverCollection
    //     .doc(uid)
    //     .collection('Cars')
    //     .doc(carPlateNum)
    //     .set({
    //   //"carName": carName,
    //   "carBrand": carBrand,
    //   "carType": carType,
    //   "carPlateNum": carPlateNum,
    // });
  }

  //query untuk driver punya subcollection from cars punya collection*
  //kalau data tu document id exist, update data tu... kalau x exist, tambah data tu
  Future updateDriverDataInCarCollection(
      // String? name,
      // String? username,
      String? carPlateNum,
      // String? phoneNum,
      // String? icNum,
      // DateTime? birthDate,
      Driver driver) async {
    DocumentReference docRef = carCollection.doc('$carPlateNum/Drivers/$uid');
    return await docRef.set(driver.toMap()
        //   {
        //   "username": username ?? null,
        //   "name": name ?? null,
        //   "phoneNum": phoneNum ?? null,
        //   "icNum": icNum ?? null,
        //   "dateOfBirth": birthDate ?? null,
        //   "driverRef": driverCollection.doc(uid),
        // }
        );
  }

  //method untuk get data from firestore
  //guna untuk generate List dalam bentuk instance Car(refer car.dart dalam folder models)*
  //act as converter nak tukaq data from firestore dalam bentuk querysnapshot kepada bentuk List untuk mudah kerja
  List<Car> _carListFromSnapshot(QuerySnapshot snapshot) {
    //print(snapshot.docs[0].id);
    return snapshot.docs.map((doc) {
      //Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      return Car.fromFirestore(doc);
      // Car(
      //   parkingStatus: data['parkingStatus'],
      //   carBrand: data['carBrand'],
      //   carPlateNum: data['carPlateNum'],
      //   carType: data['carType'],
      //   documentID: data['documentID'],
      //   reference: data['carRef'],
      //   //snapshot: data['snapshot'],
      // );
    }).toList();
  }

  List<LocationParking> _locationListFromSnapshot(QuerySnapshot snapshot) {
    //print(snapshot.docs[0].id);
    return snapshot.docs.map((doc) {
      return LocationParking.fromFirestore(doc);
    }).toList();
  }

  List<Parking> _parkingListFromSnapshot(QuerySnapshot snapshot) {
    //print(snapshot.docs[0].id);
    return snapshot.docs.map((doc) {
      return Parking.fromFirestore(doc);
    }).toList();
  }

  List<TransactionHistory> _transactionListFromSnapshot(
      QuerySnapshot snapshot) {
    //print(snapshot.docs[0].id);
    return snapshot.docs.map((doc) {
      return TransactionHistory.fromFirestore(doc);
    }).toList();
  }

  List<Compound> _compoundListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Compound.fromFirestore(doc);
    }).toList();
  }

  //method untuk get data from firestore
  //guna untuk generate List dalam bentuk instance Driver(refer driver.dart dalam folder models)*
  //act as converter nak tukaq data from firestore dalam bentuk querysnapshot kepada bentuk List untuk mudah kerja
  List<Driver> _driverListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      return Driver.fromFirestore(doc);
      // Driver(
      //   uid: doc.id,
      //   username: data['username'],
      //   phoneNum: data['phoneNum'],
      //   name: data['name'],
      //   icNum: data['icNum'],
      //   birthDate: data['dateOfBirth'],
      // );
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

  Stream<List<LocationParking>> get locations {
    return locationParkCollection.snapshots().map(_locationListFromSnapshot);
  }

  Stream<List<Parking>> get parkings {
    return locationParkCollection
        .orderBy('date')
        .snapshots()
        .map(_parkingListFromSnapshot);
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

  Stream<List<Parking>> get userParkingList {
    return parkingCollection
        .where('driverId', isEqualTo: uid)
        .orderBy('date', descending: true)
        .snapshots()
        .map(_parkingListFromSnapshot);
  }

  Stream<List<TransactionHistory>> get userTransactionHistory {
    return driverCollection
        .doc(uid)
        .collection('transactions')
        .orderBy('date', descending: true)
        .snapshots()
        .map(_transactionListFromSnapshot);
  }

  Stream<List<Compound>> streamCarCompoundListById(String carPlateNum) {
    return compoundCollection
        .where('carId', isEqualTo: carPlateNum)
        .orderBy('dateIssued', descending: true)
        .snapshots()
        .map(_compoundListFromSnapshot);
  }

  Future<List<Compound>> getCarCompoundListById(String carPlateNum) {
    return compoundCollection
        .where('carId', isEqualTo: carPlateNum)
        .orderBy('dateIssued', descending: false)
        .get()
        .then(_compoundListFromSnapshot);
    // .map(_compoundListFromSnapshot);
  }

  Stream<Parking> get userCurrentParking {
    var snap = parkingCollection
        .where('driverId', isEqualTo: uid)
        .orderBy('startTime', descending: true)
        .limit(1)
        .snapshots();
    return snap.map(
      (event) {
        return Parking.fromFirestore(event.docs.first);
      },
    );
  }

  //method untuk dapat stream data untuk sorang driver sahaja from firestore based on current user id*
  Stream<Driver?> get driver {
    return driverCollection.doc(this.uid).snapshots().map((doc) {
      // print(Driver.fromFirestore(doc));
      return Driver.fromFirestore(doc);
    });
  }

  Stream<Car?> getCarById(String id) {
    return carCollection.doc(id).snapshots().map((doc) {
      return Car.fromFirestore(doc);
    });
  }

  Stream<LocationParking?> getLocationById(String id) {
    return locationParkCollection.doc(id).snapshots().map((doc) {
      return LocationParking.fromFirestore(doc);
    });
  }

  //future - data dalam bentuk asynchronous, which means dia kena tunggu and proceed lepas selesai task dia...
  //next line dalam coding x kan berjalan selagi task x abis
  //request jadi lepas perkataan await
  //slalunya guna untuk request dataa yg kemungkinan amik masa. terjadi bila call sahaja.

  //method untuk get data untuk driver from firestore
  //convert requested data dalam bentuk instance Driver
  Future<Driver?> get driverinfo async {
    return await driverCollection.doc(this.uid).get().then(
        (data) => Driver.fromFirestore(data)
        // Driver(
        //     uid: this.uid!,
        //     name: data['name'],
        //     icNum: data['icNum'],
        //     birthDate:
        //         data['dateOfBirth']?.toDate() ?? DateTime.parse("1111-11-11"),
        //     phoneNum: data['phoneNum'],
        //     username: data['username']),
        );
  }

  Future updateDriverParkingStatus(bool status) async {
    return await driverCollection.doc(uid).update({
      'parkingStatus': status,
    });
  }

  Future updateCarParkingStatus(String carPLateNum, bool status) async {
    return await carCollection.doc(carPLateNum).update({
      'parkingStatus': status,
    });
  }

  Future updateDriverWalletBalance(double amount) async {
    return await driverCollection.doc(uid).update({
      'walletBalance': FieldValue.increment(amount),
    });
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

  Future<bool> checkDriverInfoComplete() {
    return driverCollection.doc(this.uid).get().then((snapshot) {
      if ((snapshot.data() as Map)['profileComplete']) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future<bool> checkParkingStatus() {
    return driverCollection.doc(this.uid).get().then((snapshot) {
      if ((snapshot.data() as Map)['parkingStatus']) {
        return true;
      } else {
        return false;
      }
    });
  }

  Stream<bool> streamParkingStatus() {
    return driverCollection.doc(this.uid).snapshots().map((snapshot) {
      if ((snapshot.data() as Map)['parkingStatus']) {
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
        .then((data) => Car.fromFirestore(data)
            //     Car(
            //   // carName: data['carName'],
            //   carBrand: data['carBrand'],
            //   carPlateNum: data['carPlateNum'],
            //   carType: data['carType'],
            // ),
            );
  }

  //method untuk get data car for current driver from car collection*
  //check based on carplateNum*
  Future<Car> getCarInfoCollection(String carPlateNum) async {
    return carCollection
        .doc(carPlateNum)
        .get()
        .then((data) => Car.fromFirestore(data)
            //   Car(
            //   // carName: data['carName'],
            //   carBrand: data['carBrand'],
            //   carPlateNum: data['carPlateNum'],
            //   carType: data['carType'],
            //   parkingStatus: data['parkingStatus']
            // ),
            );
  }

  Future<double> getWalletBalance() async {
    return driverCollection.doc(uid).get().then((snapshot) =>
        (snapshot.data() as Map)['walletBalance']?.toDouble() ?? 0.00);
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
