import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/car.dart';
import '../../models/driver.dart';
import '../../models/driveruid.dart';
import '../../services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RegisterCar extends StatefulWidget {
  final Driver? driverInfo;

  RegisterCar({Key? key, this.driverInfo}) : super(key: key);

  @override
  State<RegisterCar> createState() => _RegisterCarState();
}

class _RegisterCarState extends State<RegisterCar> {
  String registerCar = '00';
  bool registerStatus = false;

  bool conditionList = false;

  createAlertDialog(
      BuildContext context, String carBrand, String carPlateNum, String uid) {
    Size size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Delete Car',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 19.sp,
                color: const Color(0xff131450),
              ),
              textAlign: TextAlign.left,
            ),
            content: Text(
              'Are you sure you want to delete car $carBrand ?',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 19.sp,
                color: const Color(0xff131450),
              ),
              textAlign: TextAlign.left,
            ),
            actions: [
              InkWell(
                child: Container(
                  width: 74.w,
                  height: 42.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xff17B95B),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16.sp,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                onTap: () async {
                  await FirebaseService(uid: uid)
                      .deleteCarFromUser(carPlateNum);
                  Navigator.of(context).pop();
                },
              ),
              InkWell(
                child: Container(
                  width: 74.w,
                  height: 42.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xffF04437),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16.sp,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              )
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(23),
            ),
            actionsPadding: EdgeInsets.fromLTRB(0, 43.h, 9.w, 15.h),
            buttonPadding: EdgeInsets.fromLTRB(8.w, 0.h, 8.w, 0),
            contentPadding: EdgeInsets.fromLTRB(27.w, 20.h, 15.w, 0),
            insetPadding: EdgeInsets.fromLTRB(55.w, 0, 55.w, 0),
            titlePadding: EdgeInsets.fromLTRB(27.w, 27.h, 27, 0),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final driver = Provider.of<Driveruid?>(context);

    return MultiProvider(
      providers: [
        StreamProvider<List<Car>>.value(
          initialData: [],
          value: FirebaseService(uid: driver!.uid).userCars,
        ),
      ],
      child: Scaffold(
        appBar: registerCarAppbarDesign(),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              color: Color(0xffF1F1F1),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 0.131 * size.height,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffE1F9E0),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 6),
                      ],
                    ),
                    child: SizedBox(
                      width: size.width / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Registered Car',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16.sp,
                              color: const Color(0xff000000),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 14.h),
                          StreamBuilder(
                              stream: FirebaseService(uid: driver.uid).userCars,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<Car> carList =
                                      snapshot.data! as List<Car>;
                                  return Text(
                                    carList.length.toString().padLeft(2, '0'),
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 30.sp,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  );
                                } else {
                                  return Text(
                                    '00',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 30.sp,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  );
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  registerCarDesign(),
                  Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Divider(
                      color: Colors.black,
                      height: 1,
                      thickness: 1,
                    ),
                  ),
                  StreamBuilder(
                      stream: FirebaseService(uid: driver.uid).userCars,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print('hasdata');
                          return listViewCarDesign(snapshot, driver.uid);
                        } else {
                          print('nodata');
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (context, snapshot) {
                                return Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Center(
                                    child: SizedBox(
                                      height: 30.h,
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                );
                              });
                        }
                      }),
                  SizedBox(height: 16.h),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget expansionCarDesign(String title, String uid) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 1),
                blurRadius: 1,
              )
            ]),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
          title: Text(
            '$title Car',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16.sp,
              color: const Color(0xff707070),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
          iconColor: Color(0xff16AA10),
          collapsedIconColor: Color(0xff16AA10),
          children: [
            StreamBuilder(
                stream: FirebaseService(uid: uid).userCars,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print('hasdata');
                    return listViewCarDesign(snapshot, uid);
                  } else {
                    print('nodata');
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, snapshot) {
                          return Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Center(
                              child: SizedBox(
                                height: 30.h,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          );
                        });
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget listViewCarDesign(AsyncSnapshot snapshot, String uid) {
    List<Car> carList = snapshot.data! as List<Car>;
    //if (carList.length == 0) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20.w),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 1),
                blurRadius: 3,
              )
            ]),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Text(
                'LIST CAR REGISTERED',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 12.sp,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            carList.length < 1
                ? listviewNoCarDesignBuilder()
                : listViewCarDesignBuilder(carList, uid),
          ],
        ),
      ),
    );
    // } else {
    //   return ListView.builder(
    //       shrinkWrap: true,
    //       itemCount: 1,
    //       itemBuilder: (context, snapshot) {
    //         return noRegisteredCarDesign();
    //       });
    // }
  }

  ListView listViewCarDesignBuilder(List<Car?> carList, String uid) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: carList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            children: [
              dividerListview(),
              ListTile(
                leading: SizedBox(
                  height: 36.h,
                  width: 36.w,
                  child: Icon(
                    Icons.directions_car,
                    size: 36.w,
                    color: Color(0xff17B95B),
                  ),
                ),
                dense: true,
                horizontalTitleGap: 8.w,
                title: Text(
                  '${carList[index]!.carBrand}',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 12.sp,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
                subtitle: Text(
                  '${carList[index]!.carPlateNum}',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 10.sp,
                    color: const Color(0xff808080),
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 30.w,
                      height: 30.h,
                      child: Material(
                        shape: CircleBorder(),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          padding: EdgeInsets.all(0),
                          iconSize: 30.w,
                          onPressed: () {
                            print(widget.driverInfo);

                            Navigator.of(context)
                                .pushNamed('/registerinputcar', arguments: {
                              //"carName": carList[index]!.carName,
                              "carPlateNum": carList[index]!.carPlateNum,
                              "carBrand": carList[index]!.carBrand,
                              "carType": carList[index]!.carType,
                              "appbarTitle": "Edit Car",
                              "driverInfo": widget.driverInfo
                            });
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Color(0xff17B95B),
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    SizedBox(
                      width: 30.w,
                      height: 30.h,
                      child: Material(
                        shape: CircleBorder(),
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          iconSize: 30.w,
                          onPressed: () {
                            _deleteCarOnPressed(context, carList, index, uid);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Color(0xff17B95B),
                            size: 30.w,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  void _deleteCarOnPressed(
      BuildContext context, List<Car?> carList, int index, String uid) {
    createAlertDialog(
      context,
      '${carList[index]!.carBrand}',
      '${carList[index]!.carPlateNum}',
      uid,
    );
  }

  Padding dividerListview() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Divider(
        thickness: 1,
        height: 1,
        color: Color(0xffC8C8C8),
      ),
    );
  }

  Widget listviewNoCarDesignBuilder() {
    return ListView(
      shrinkWrap: true,
      children: [
        dividerListview(),
        noRegisteredCarDesign(),
      ],
    );
  }

  Widget noRegisteredCarDesign() {
    return ListTile(
      title: Text(
        'No car registered',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16.sp,
          color: const Color(0xff707070),
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
    );
  }

  Widget registerCarDesign() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 1),
                blurRadius: 1,
              )
            ]),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          leading: Icon(
            Icons.add,
            size: 35.w,
            color: Color(0xff17B95B),
          ),
          horizontalTitleGap: 4.w,
          title: Text(
            'Register New Car',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16.sp,
              color: const Color(0xff000000),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
          onTap: () async {
            Navigator.of(context).pushNamed('/registerinputcar', arguments: {
              "appbarTitle": "Register New Car",
              "driverInfo": widget.driverInfo
            });
          },
        ),
      ),
    );
  }

  AppBar registerCarAppbarDesign() {
    return AppBar(
      title: Text(
        'Register Car',
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
          iconSize: 35.w,
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
      elevation: 1,
    );
  }

  void _editCarOnPressed() {
    print('edit car');
  }
}
