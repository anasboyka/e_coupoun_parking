import 'package:e_coupoun_parking/services/firebase_service.dart';
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

  List car = [
    {
      'carName': 'PERODUA ARUZ',
      'carPlate': 'ABC1234',
      'categoryOwn': 'Personal'
    },
    {
      'carName': 'TOYOTA AVANZA',
      'carPlate': 'DEF5678',
      'categoryOwn': 'Personal'
    },
    {
      'carName': 'PERODUA MYVI',
      'carPlate': 'GHI8765',
      'categoryOwn': 'Personal'
    },
    {
      'carName': 'TOYOTA SUPRA',
      'carPlate': 'JKL4321',
      'categoryOwn': 'Personal'
    }
  ];

  bool conditionList = false;

  //dummy data end

  createAlertDialog(BuildContext context, String inputData) {
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
              'Are you sure you want to delete car $inputData ?',
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
                onTap: () {
                  //Navigator.of(context).pop("data from dialog");
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamProvider.value(
      initialData: null,
      value: FirebaseService().cars,
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
                                Text(
                                  registerCar,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 30,
                                    color: const Color(0xff000000),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                )
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
                                Text(
                                  personalCar,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 30,
                                    color: const Color(0xff000000),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                )
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
                                  child: Text(
                                    otherCar,
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 30,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
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



  Padding expansionCarDesign(String title) {
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
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 2,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return conditionList
                      ? Column(
                          children: [
                            dividerListview(),
                            noRegisteredCarDesign()
                          ],
                        )
                      : Column(
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
                                '${car[index]['carName']}',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 0),
                              subtitle: Text(
                                '${car[index]['carPlate']}',
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
                                          createAlertDialog(context,
                                              '${car[index]['carName']}');
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
                }),
            // dividerListview(),
            // noRegisteredCarDesign()
          ],
        ),
      ),
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
          onTap: () {
            Navigator.of(context).pushNamed('/registerinputcar');
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
