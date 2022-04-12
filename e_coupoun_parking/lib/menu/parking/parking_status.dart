import 'package:e_coupoun_parking/constant.dart';
import 'package:e_coupoun_parking/models/car.dart';
import 'package:e_coupoun_parking/models/driveruid.dart';
import 'package:e_coupoun_parking/models/location_parking.dart';
import 'package:e_coupoun_parking/models/parking.dart';
import 'package:e_coupoun_parking/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ParkingStatus extends StatelessWidget {
  const ParkingStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Driveruid driveruid = Provider.of<Driveruid>(context);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: parkingAppbarDesign('Parking Status'),
      body: StreamBuilder<Parking>(
          stream: FirebaseService(uid: driveruid.uid).userCurrentParking,
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              Parking parking = snapshot.data; //parkings[0];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  Text.rich(
                    TextSpan(
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 49,
                          color: const Color(0xff16aa32),
                        ),
                        children: [
                          TextSpan(
                            text: DateFormat('h:mm')
                                .format(parking.endTime)
                                .toString(),
                          ),
                          TextSpan(
                            text: DateFormat('a')
                                .format(parking.endTime)
                                .toString(),
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 20.sp,
                              color: const Color(0xff8392a7),
                            ),
                          ),
                        ]),
                  ),
                  gaph(h: 33),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Divider(
                      endIndent: 0,
                      height: 0,
                      indent: 0,
                      thickness: 1,
                      color: Color(0xff707070),
                    ),
                  ),
                  gaph(h: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/parkingIcon.png',
                          height: 80.h,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: StreamBuilder(
                              stream: FirebaseService(uid: driveruid.uid)
                                  .getLocationById(parking.locationId!),
                              builder: (_, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  LocationParking locationParking =
                                      snapshot.data;
                                  return ListTile(
                                    title: Text(
                                      locationParking.locationName,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 19,
                                        color: const Color(0xff0c7516),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    subtitle:
                                        Text(locationParking.locationSubname),
                                  );
                                } else {
                                  return Center(
                                      child:
                                          CircularProgressIndicator.adaptive());
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                  gaph(h: 12),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Divider(
                      endIndent: 0,
                      height: 0,
                      indent: 0,
                      thickness: 1,
                      color: Color(0xff707070),
                    ),
                  ),
                  gaph(h: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Row(
                      children: [
                        Icon(
                          Icons.directions_car,
                          color: Color(0xff17B95B),
                          size: 80.h,
                        ),
                        gapw(w: 10),
                        Expanded(
                          child: StreamBuilder(
                              stream: FirebaseService(uid: driveruid.uid)
                                  .getCarById(parking.carId!),
                              builder: (_, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  Car car = snapshot.data;
                                  return ListTile(
                                    title: Text(
                                      car.carBrand,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 19,
                                        color: const Color(0xff0c7516),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    subtitle: Text(car.carPlateNum),
                                  );
                                } else {
                                  return CircularProgressIndicator.adaptive();
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                  gaph(h: 12),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Divider(
                      endIndent: 0,
                      height: 0,
                      indent: 0,
                      thickness: 1,
                      color: Color(0xff707070),
                    ),
                  ),
                  gaph(h: 84),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            height: 67.h,
                            minWidth: double.infinity,
                            elevation: 3,
                            color: kbtnColor,
                            child: Text(
                              'Extend',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 25,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        gapw(w: 12),
                        Expanded(
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            height: 67.h,
                            minWidth: double.infinity,
                            elevation: 3,
                            color: Colors.white,
                            child: Text(
                              'End Now',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 25,
                                color: const Color(0xffbebebe),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            onPressed: () async {
                              Navigator.of(context).pop();
                              await FirebaseService(uid: driveruid.uid)
                                  .updateDriverParkingStatus(false);
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          }),
    );
  }

  AppBar parkingAppbarDesign(String titleAppbar) {
    return AppBar(
      title: Text(
        titleAppbar,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 22.sp,
          color: const Color(0xff707070),
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
      // actions: [],
      flexibleSpace: Image(
        image: AssetImage('assets/icons/header.png'),
        fit: BoxFit.fitWidth,
      ),
      // backgroundColor: Colors.transparent,
      elevation: 1,
    );
  }
}
