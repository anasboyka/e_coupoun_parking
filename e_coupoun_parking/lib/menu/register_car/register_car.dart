import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_coupoun_parking/models/car.dart';
import 'package:e_coupoun_parking/models/driver.dart';
import 'package:e_coupoun_parking/models/driveruid.dart';
import 'package:e_coupoun_parking/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterCar extends StatefulWidget {
  final Driver? driverInfo;

  RegisterCar({Key? key, this.driverInfo}) : super(key: key);

  @override
  State<RegisterCar> createState() => _RegisterCarState();
}

class _RegisterCarState extends State<RegisterCar> {
  //dummy data start
  String registerCar = '00', personalCar = "00", nonPersonalCar = '00';
  bool registerStatus = false;

  bool conditionList = false;

  //dummy data end
  // final FirebaseAuth auth = FirebaseAuth.instance;
  // String getCurrentUserId() {
  //   final user = auth.currentUser;
  //   return user!.uid;
  // }

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
                fontSize: 19,
                color: const Color(0xff131450),
              ),
              textAlign: TextAlign.left,
            ),
            content: Text(
              'Are you sure you want to delete car $carBrand ?',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 19,
                color: const Color(0xff131450),
              ),
              textAlign: TextAlign.left,
            ),
            actions: [
              InkWell(
                child: Container(
                  width: 74,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xff17B95B),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                onTap: () async {
                  //Navigator.of(context).pop("data from dialog");
                  await FirebaseService(uid: uid)
                      .deleteCarFromUser(carPlateNum);
                  Navigator.of(context).pop();
                },
              ),
              InkWell(
                child: Container(
                  width: 74,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xffF04437),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                onTap: () {
                  //Navigator.of(context).pop("data from dialog");
                  Navigator.of(context).pop();
                },
              )
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(23),
            ),
            actionsPadding: EdgeInsets.fromLTRB(0, 43, 9, 15),
            buttonPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            contentPadding: EdgeInsets.fromLTRB(27, 20, 15, 0),
            insetPadding: EdgeInsets.fromLTRB(55, 0, 55, 0),
            titlePadding: EdgeInsets.fromLTRB(27, 27, 27, 0),
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
      child: SafeArea(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: size.width / 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Registered Car',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    color: const Color(0xff000000),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 14),
                                StreamBuilder(
                                    stream: FirebaseService(uid: driver.uid)
                                        .userCars,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        List<Car> carList =
                                            snapshot.data! as List<Car>;
                                        return Text(
                                          carList.length
                                              .toString()
                                              .padLeft(2, '0'),
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 30,
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
                                            fontSize: 30,
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
                          SizedBox(
                            width: size.width / 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Personal Car',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    color: const Color(0xff000000),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 14),
                                StreamBuilder(
                                    stream: FirebaseService(uid: driver.uid)
                                        .userCars,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        List<Car> carList =
                                            snapshot.data! as List<Car>;
                                        List<Car?> carListPersonal = [];
                                        carList.map((list) {
                                          if (list.carOwnerType == "Personal") {
                                            //print(list.carType);
                                            carListPersonal.add(list);
                                          }
                                        }).toList();
                                        return Text(
                                          carListPersonal.length
                                              .toString()
                                              .padLeft(2, '0'),
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 30,
                                            color: const Color(0xff000000),
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.center,
                                        );
                                      }
                                      {
                                        return Text(
                                          '00',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 30,
                                            color: const Color(0xff000000),
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.center,
                                        );
                                      }
                                    })
                              ],
                            ),
                          ),
                          SizedBox(
                            width: size.width / 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Non-Personal Car',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    color: const Color(0xff000000),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 14),
                                Align(
                                  alignment: Alignment.center,
                                  child: StreamBuilder(
                                      stream: FirebaseService(uid: driver.uid)
                                          .userCars,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          List<Car> carList =
                                              snapshot.data! as List<Car>;
                                          List<Car?> carListNonPersonal = [];
                                          carList.map((list) {
                                            if (list.carOwnerType ==
                                                "Non-Personal") {
                                              carListNonPersonal.add(list);
                                            }
                                          }).toList();
                                          return Text(
                                            carListNonPersonal.length
                                                .toString()
                                                .padLeft(2, '0'),
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 30,
                                              color: const Color(0xff000000),
                                              fontWeight: FontWeight.w700,
                                            ),
                                            textAlign: TextAlign.center,
                                          );
                                        }
                                        {
                                          return Text(
                                            '00',
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 30,
                                              color: const Color(0xff000000),
                                              fontWeight: FontWeight.w700,
                                            ),
                                            textAlign: TextAlign.center,
                                          );
                                        }
                                      }),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    expansionCarDesign('Personal', driver.uid),
                    SizedBox(height: 16),
                    expansionCarDesign('Non-Personal', driver.uid),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Divider(
                        color: Colors.black,
                        height: 1,
                        thickness: 1,
                      ),
                    ),
                    registerCarDesign(),
                    SizedBox(height: 16),
                    // registerCarDesign('Non-Personal'),
                    // SizedBox(
                    //   height: 25,
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget expansionCarDesign(String title, String uid) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 1),
                blurRadius: 1,
              )
            ]),
        child: ExpansionTile(
          tilePadding: EdgeInsets.fromLTRB(20, 7, 20, 7),
          title: Text(
            '$title Car',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
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
                    return listViewCarDivideDesign(title, snapshot, uid);
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, snapshot) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: SizedBox(
                                height: 30,
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

  ListView listViewCarDivideDesign(
      String title, AsyncSnapshot snapshot, String uid) {
    List<Car> carList = snapshot.data! as List<Car>;

    List<Car?> carListPersonal = [];
    carList.map((list) {
      if (list.carOwnerType == "Personal") {
        //print(list.carType);
        carListPersonal.add(list);
      }
    }).toList();
    List<Car?> carListNonPersonal = [];
    carList.map((list) {
      if (list.carOwnerType == "Non-Personal") {
        carListNonPersonal.add(list);
      }
    }).toList();
    if (title == 'Non-Personal' && carListNonPersonal.length > 0) {
      return listViewCarDesign(title, carListNonPersonal, uid);
    } else if (title == 'Personal' && carListPersonal.length > 0) {
      return listViewCarDesign(title, carListPersonal, uid);
    } else if (carListNonPersonal.length < 0 || carListPersonal.length < 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [dividerListview(), noRegisteredCarDesign()],
            );
          });
    }
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            children: [dividerListview(), noRegisteredCarDesign()],
          );
        });
    //return listViewCarDesignn(title, carList);
  }

  ListView listViewCarDesign(String title, List<Car?> carList, String uid) {
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
                  height: 36,
                  width: 36,
                  child: Icon(
                    Icons.directions_car,
                    size: 36,
                    color: Color(0xff17B95B),
                  ),
                ),
                dense: true,
                horizontalTitleGap: 8,
                title: Text(
                  '${carList[index]!.carBrand}',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 12,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                subtitle: Text(
                  '${carList[index]!.carPlateNum}',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 10,
                    color: const Color(0xff808080),
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Material(
                        shape: CircleBorder(),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          padding: EdgeInsets.all(0),
                          iconSize: 30,
                          onPressed: () {
                            print(widget.driverInfo);
                            //_editCarOnPressed();
                            Navigator.of(context)
                                .pushNamed('/registerinputcar', arguments: {
                              "carPlateNum": carList[index]!.carPlateNum,
                              "carBrand": carList[index]!.carBrand,
                              "carOwnerType": carList[index]!.carOwnerType,
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
                    SizedBox(width: 6),
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Material(
                        shape: CircleBorder(),
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          iconSize: 30,
                          onPressed: () {
                            _deleteCarOnPressed(context, carList, index, uid);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Color(0xff17B95B),
                            size: 30,
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
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        thickness: 1,
        height: 1,
        color: Color(0xffC8C8C8),
      ),
    );
  }

  ListTile noRegisteredCarDesign() {
    return ListTile(
      title: Text(
        'No car registered',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          color: const Color(0xff707070),
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.left,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
    );
  }

  Padding registerCarDesign() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 1),
                blurRadius: 1,
              )
            ]),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          leading: Icon(
            Icons.add,
            size: 35,
            color: Color(0xff17B95B),
          ),
          horizontalTitleGap: 4,
          title: Text(
            'Register New Car',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
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
          fontSize: 22,
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
            //print('clicked');
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

  void _editCarOnPressed() {
    print('edit car');
    //Navigator.of(context).pushNamed('/registerinputcar',arguments: {})
  }
}
