import 'package:e_coupoun_parking/models/car.dart';
import 'package:e_coupoun_parking/models/driveruid.dart';
import 'package:e_coupoun_parking/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CarSelection extends StatelessWidget {
  Map? args = {};
  CarSelection({Key? key, this.args}) : super(key: key);

  TextEditingController searchCarCon = new TextEditingController();
  // List<Map<String, String>> cars = [
  //   {'plateNum': 'ABC 1234', 'carBrand': 'PERODUA BEZZA'},
  //   {'plateNum': 'DEF 1234', 'carBrand': 'PROTON WIRA'},
  // ];

  // List<Car> cars = [
  //   Car(carBrand: 'PERODUA BEZZA', carType: 'carType', carPlateNum: 'ABC 1234'),
  //   Car(carBrand: 'PROTON WIRA', carType: 'carType', carPlateNum: 'DEF 1234'),
  // ];

  @override
  Widget build(BuildContext context) {
    Driveruid driveruid = Provider.of<Driveruid>(context);
    return Scaffold(
      appBar: carSelectionAppbarDesign('Choose Car'),
      backgroundColor: Color(0xffE1F9E0),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Column(children: [
            // Card(
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(10.r),
            //   ),
            //   elevation: 2,
            //   child: TextFormField(
            //     controller: searchCarCon,
            //     textAlignVertical: TextAlignVertical.center,
            //     style: TextStyle(
            //       fontFamily: 'Roboto',
            //       fontSize: 18,
            //       color: Colors.black,
            //       fontWeight: FontWeight.w700,
            //     ),
            //     decoration: InputDecoration(
            //       hintText: "Search Location",
            //       hintStyle: TextStyle(
            //         fontFamily: 'Roboto',
            //         fontSize: 18,
            //         color: const Color(0xffbebebe),
            //         fontWeight: FontWeight.w700,
            //       ),
            //       prefixIcon: Icon(Icons.search),
            //       suffixIcon: IconButton(
            //         icon: Icon(Icons.clear),
            //         onPressed: () {},
            //       ),
            //       border: InputBorder.none,
            //       filled: true,
            //       fillColor: Colors.white,
            //       contentPadding:
            //           EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
            //       focusedBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10.r),
            //         borderSide: BorderSide.none,
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10.r),
            //         borderSide: BorderSide.none,
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 30.h),
            Container(
              width: double.infinity,
              child: Card(
                elevation: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
                      child: Text(
                        'Car List',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: const Color(0xff707070),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
                      child: Divider(
                        color: Color(0xffC8C8C8),
                        thickness: 1,
                        height: 0,
                        endIndent: 0,
                        indent: 0,
                      ),
                    ),
                    StreamBuilder(
                      stream: FirebaseService(uid: driveruid.uid).userCars,
                      builder: (_, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          List<Car> cars = snapshot.data;
                          return ListView.separated(
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: SizedBox(
                                  height: 36.h,
                                  width: 36.w,
                                  child: Icon(
                                    Icons.directions_car,
                                    size: 36.w,
                                    color: Color(0xff17B95B),
                                  ),
                                ),
                                title: Text(
                                  cars[index].carBrand,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 15.sp,
                                    color: const Color(0xff000000),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                subtitle: Text(
                                  cars[index].carPlateNum,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 13.sp,
                                    color: const Color(0xffbebebe),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                dense: true,
                                //horizontalTitleGap: 0,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 20.w),
                                onTap: () {
                                  Navigator.of(context)
                                      .pop({'car': cars[index]});
                                },
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Divider(
                                  color: Color(0xffC8C8C8),
                                  thickness: 1,
                                  height: 0,
                                  endIndent: 0,
                                  indent: 0,
                                ),
                              );
                            },
                            itemCount: cars.length,
                            shrinkWrap: true,
                          );
                        } else {
                          return CircularProgressIndicator.adaptive();
                        }
                      },
                    ),
                    SizedBox(height: 30.h)
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  AppBar carSelectionAppbarDesign(String titleAppbar) {
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
      actions: [],
      flexibleSpace: Image(
        image: AssetImage('assets/icons/header.png'),
        fit: BoxFit.fitWidth,
      ),
      //backgroundColor: Colors.transparent,
      elevation: 1,
    );
  }
}
