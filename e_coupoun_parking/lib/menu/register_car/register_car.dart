import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_coupoun_parking/models/car.dart';
import 'package:e_coupoun_parking/models/driver.dart';
import 'package:e_coupoun_parking/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterCar extends StatefulWidget {
  @override
  State<RegisterCar> createState() => _RegisterCarState();
}

class _RegisterCarState extends State<RegisterCar> {
  //dummy data start
  String registerCar = '00', personalCar = "00", otherCar = '00';
  bool registerStatus = false;

  bool conditionList = false;

  //dummy data end
  final FirebaseAuth auth = FirebaseAuth.instance;
  String getCurrentUserId() {
    final user = auth.currentUser;
    return user!.uid;
  }

  createAlertDialog(BuildContext context, String carBrand, String carPlateNum) {
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
                  await FirebaseService(uid: getCurrentUserId())
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
    return StreamProvider<List<Car>>.value(
      initialData: [],
      value: FirebaseService(uid: getCurrentUserId()).userCars,
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
                            width: 105,
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
                                    stream:
                                        FirebaseService(uid: getCurrentUserId())
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
                            width: 105,
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
                                    stream:
                                        FirebaseService(uid: getCurrentUserId())
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
                            width: 105,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Other Car',
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
                                      stream: FirebaseService(
                                              uid: getCurrentUserId())
                                          .userCars,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          List<Car> carList =
                                              snapshot.data! as List<Car>;
                                          List<Car?> carListOther = [];
                                          carList.map((list) {
                                            if (list.carOwnerType ==
                                                "Others") {
                                              //print(list.carType);
                                              carListOther.add(list);
                                            }
                                          }).toList();
                                          return Text(
                                            carListOther.length
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
                    expansionCarDesign('Personal'),
                    SizedBox(height: 16),
                    registerCarDesign('Personal'),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Divider(
                        color: Colors.black,
                        height: 1,
                        thickness: 1,
                      ),
                    ),
                    expansionCarDesign('Other'),
                    SizedBox(height: 16),
                    registerCarDesign('Other'),
                    SizedBox(
                      height: 25,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget expansionCarDesign(String title) {
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
                stream: FirebaseService(uid: getCurrentUserId()).userCars,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print('hasdata');

                    // print("data other = ${carListOther.length}");
                    // print("data personal = ${carListPersonal.length}");
                    return listViewCarDivideDesign(title, snapshot);
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
                          // return Column(
                          //   children: [
                          //     dividerListview(),
                          //     noRegisteredCarDesign()
                          //   ],
                          // );
                        });
                  }
                }),
            // dividerListview(),
            // noRegisteredCarDesign()
          ],
        ),
      ),
    );
  }

  ListView listViewCarDivideDesign(String title, AsyncSnapshot snapshot) {
    List<Car> carList = snapshot.data! as List<Car>;

    List<Car?> carListPersonal = [];
    carList.map((list) {
      if (list.carOwnerType == "Personal") {
        print(list.carType);
        carListPersonal.add(list);
      }
    }).toList();
    List<Car?> carListOther = [];
    carList.map((list) {
      if (list.carOwnerType == "Others") {
        carListOther.add(list);
      }
    }).toList();
    if (title == 'Other' && carListOther.length > 0) {
      return listViewCarDesign(title, carListOther);
    } else if (title == 'Personal' && carListPersonal.length > 0) {
      return listViewCarDesign(title, carListPersonal);
    } else if (carListOther.length < 0 || carListPersonal.length < 0) {
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

  ListView listViewCarDesign(String title, List<Car?> carList) {
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
                  //'${car[index]['carName']}',
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
                  //'${car[index]['carPlate']}',
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
                        //borderRadius: BorderRadius.circular(5),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          padding: EdgeInsets.all(0),
                          iconSize: 30,
                          onPressed: () {
                            print('edit');
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
                            createAlertDialog(
                              context,
                              '${carList[index]!.carBrand}',
                              '${carList[index]!.carPlateNum}',
                            );
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

  Padding registerCarDesign(String title) {
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
            'Register New $title Car',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
              color: const Color(0xff000000),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
          onTap: () async {
            Navigator.of(context).pushNamed('/registerinputcar',
                arguments: {"ownerType": title});
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
            print('clicked');
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
