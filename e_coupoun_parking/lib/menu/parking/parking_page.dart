import 'dart:async';

import 'package:e_coupoun_parking/constant.dart';
import 'package:e_coupoun_parking/models/car.dart';
import 'package:e_coupoun_parking/models/driver.dart';
import 'package:e_coupoun_parking/models/driveruid.dart';
import 'package:e_coupoun_parking/models/location_parking.dart';
import 'package:e_coupoun_parking/models/parking.dart';
import 'package:e_coupoun_parking/models/transaction_history.dart';
import 'package:e_coupoun_parking/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ParkingPage extends StatefulWidget {
  Map? argument = {};
  ParkingPage({Key? key, this.argument}) : super(key: key);

  @override
  _ParkingPageState createState() => _ParkingPageState();
}

class _ParkingPageState extends State<ParkingPage> {
  int duration = 30;
  double price = 0.3;
  DateTime _dateTime = DateTime.now();
  Timer? _timer;
  Car? car;
  LocationParking? locationParking;

  GoogleMapController? mapController;
  BitmapDescriptor? sourceIcon;
  Set<Marker> _markers = Set<Marker>();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14,
  );

  LatLng? currentLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    //dateTime = DateTime.now();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer!.cancel();
    super.dispose();
    mapController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Car? car = data1?['car'] ?? null; //widget.argument?['car'] ?? null;
    //print(car?.carPlateNum ?? 'null');
    Driveruid driveruid = Provider.of<Driveruid>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: parkingAppbarDesign('Parking', driveruid.uid),
      backgroundColor: Color(0xffE1F9E0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 350.h,
                width: double.infinity,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: onMapCreated,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                )
                //color: Colors.blue,
                ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (duration > 30) {
                              duration -= 30;
                              price -= 0.30;
                            }
                          });
                        },
                        icon: Icon(
                          Icons.remove,
                          color: Color(0xff0C7516),
                          size: 35.w,
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 52,
                              color: const Color(0xff16aa32),
                            ),
                            children: [
                              TextSpan(
                                text: duration.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: 'MIN',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 20.sp,
                                  color: const Color(0xff8392a7),
                                ),
                              ),
                            ]),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            duration += 30;
                            price += 0.30;
                          });
                        },
                        icon: Icon(
                          Icons.add,
                          color: Color(0xff0C7516),
                          size: 35.w,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                    endIndent: 0,
                    height: 0,
                    indent: 0,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 5.h, 0, 24.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'End Time',
                                style: TextStyle(
                                  fontFamily: 'Montserrat-Regular',
                                  fontSize: 14,
                                  color: const Color(0xff8392a7),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Builder(builder: (context) {
                                return Text.rich(
                                  TextSpan(
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 49,
                                        color: const Color(0xff16aa32),
                                      ),
                                      children: [
                                        TextSpan(
                                          text: DateFormat('h:mm')
                                              .format(_dateTime.add(
                                                  Duration(minutes: duration)))
                                              .toString(),
                                        ),
                                        TextSpan(
                                          text: DateFormat('a')
                                              .format(_dateTime.add(
                                                  Duration(minutes: duration)))
                                              .toString(),
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 20.sp,
                                            color: const Color(0xff8392a7),
                                          ),
                                        ),
                                      ]),
                                );
                              }),
                            ],
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 5.h, 0, 24.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Cost',
                                style: TextStyle(
                                  fontFamily: 'Montserrat-Regular',
                                  fontSize: 14,
                                  color: const Color(0xff8392a7),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.h),
                                    child: Text(
                                      'RM',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 20.sp,
                                        color: const Color(0xff8392a7),
                                      ),
                                      //textAlign: TextAlign.end,
                                    ),
                                  ),
                                  Text(
                                    price.toStringAsFixed(2),
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 49,
                                      color: const Color(0xff16aa32),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                    endIndent: 0,
                    height: 0,
                    indent: 0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/parkingIcon.png',
                          height: 80.h,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              locationParking != null
                                  ? '${locationParking!.locationName}'
                                  : 'Select Location',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 19,
                                color: const Color(0xff0c7516),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            subtitle: locationParking != null
                                ? Text(
                                    '${locationParking!.locationSubname}',
                                    textAlign: TextAlign.left,
                                  )
                                : null,
                            onTap: () async {
                              Navigator.of(context)
                                  .pushNamed('/locationSelection')
                                  .then((value) {
                                if (value != null) {
                                  locationParking =
                                      (value as Map)['locationParking'];
                                } else {
                                  locationParking = null;
                                }
                                //print(locationParking!.documentID);
                                return locationParking;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                    endIndent: 0,
                    height: 0,
                    indent: 0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    child: Row(
                      children: [
                        Icon(
                          Icons.directions_car,
                          color: Color(0xff17B95B),
                          size: 80.h,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              car != null ? '${car!.carBrand}' : 'Select Car',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 19,
                                color: const Color(0xff0c7516),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            subtitle: car != null
                                ? Text(
                                    '${car!.carPlateNum}',
                                    textAlign: TextAlign.left,
                                  )
                                : null,
                            onTap: () async {
                              Navigator.of(context)
                                  .pushNamed('/carSelection')
                                  .then((value) {
                                if (value != null) {
                                  car = (value as Map)['car'];
                                } else {
                                  car = null;
                                }
                                return car;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                    endIndent: 0,
                    height: 0,
                    indent: 0,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    constraints: BoxConstraints(
                        //minWidth: size.width / 2 - 30.w,
                        minHeight: 62.h,
                        maxHeight: 66.h,
                        minWidth: double.infinity
                        //maxHeight: 40,
                        ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kbtnColor,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        'Proceed',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 20.sp,
                          color: const Color(0xffffffff),
                          letterSpacing: 1.0714286041259766,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () async {
                        if (car != null && locationParking != null) {
                          double balance =
                              await FirebaseService(uid: driveruid.uid)
                                  .getWalletBalance();
                          if (balance >= price) {
                            Parking parking = Parking(
                              carId: car!.documentID,
                              driverId: driveruid.uid,
                              locationId: locationParking!.documentID,
                              locationName: locationParking!.locationName,
                              cost: (price * 100).round() / 100,
                              date: _dateTime,
                              duration: duration,
                              startTime: _dateTime,
                              endTime: _dateTime.add(
                                Duration(minutes: duration),
                              ),
                            );
                            TransactionHistory transactionHistory =
                                TransactionHistory(
                              amount: (price * 100).round() / 100,
                              date: _dateTime,
                              isPaid: true,
                              description: {
                                'title': 'Parking',
                                'subtitle': locationParking!.locationName
                              },
                            );

                            await FirebaseService()
                                .updateParkingDataCollection(parking);
                            await FirebaseService(uid: driveruid.uid)
                                .updateDriverParkingStatus(true);
                            await FirebaseService(uid: driveruid.uid)
                                .updateCarParkingStatus(car!.carPlateNum, true);
                            await FirebaseService(uid: driveruid.uid)
                                .updateUserTransactionHistory(
                                    transactionHistory);
                            await FirebaseService(uid: driveruid.uid)
                                .updateDriverWalletBalance(
                                    (price * -1 * 100).round() / 100);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Insufficient Wallet Balance'),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Please fill in all the information needed'),
                            ),
                          );
                        }
                        //print(_dateTime.add(Duration(minutes: duration)));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 38.h,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _getTime() {
    setState(() {
      _dateTime = DateTime.now();
    });
  }

  AppBar parkingAppbarDesign(String titleAppbar, String uid) {
    return AppBar(
      title: Text(
        titleAppbar,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 22.sp,
          color: const Color(0xff17B95B),
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.left,
      ),
      leading: Builder(
        builder: (context) => IconButton(
          iconSize: 35,
          icon: Icon(
            Icons.chevron_left,
            color: Color(0xff17B95B),
          ),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          splashRadius: 25,
          onPressed: () {
            return Navigator.of(context).pop();
          },
        ),
      ),
      actions: [
        InkWell(
          onTap: () => Navigator.of(context).pushNamed('/ewallet'),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.green.shade300.withOpacity(0.75),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.monetization_on,
                  size: 24,
                ),
                gapw(w: 5),
                StreamBuilder(
                    stream: FirebaseService(uid: uid).driver,
                    builder: (_, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        Driver driver = snapshot.data;
                        return Text(
                          'RM ${driver.walletBalance?.toStringAsFixed(2) ?? '0.00'}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        );
                      } else {
                        return CircularProgressIndicator.adaptive();
                      }
                    }),
                gapw(w: 5),
              ],
            ),
          ),
        ),
        gapw(w: 10),
      ],
      // flexibleSpace: Image(
      //   image: AssetImage('assets/icons/header.png'),
      //   fit: BoxFit.fitWidth,
      // ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    final LatLngBounds visibleRegion = await controller.getVisibleRegion();
    setState(() {
      mapController = controller;
    });
  }
}
