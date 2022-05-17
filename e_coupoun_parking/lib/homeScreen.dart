//homescreen kalau user dah sign in
import 'dart:async';
import 'dart:io';

import 'package:e_coupoun_parking/models/driver.dart';
import 'package:e_coupoun_parking/models/driveruid.dart';
import 'package:e_coupoun_parking/provider/firebaseProvider.dart';
import 'package:e_coupoun_parking/provider/location_provider.dart';
import 'package:e_coupoun_parking/services/auth.dart';
import 'package:e_coupoun_parking/services/firebase_service.dart';
import 'package:e_coupoun_parking/services/mysql_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _auth = AuthService();
  //test database start
  String driveridmysql = 'null',
      icnummysql = 'null',
      namemysql = 'null',
      phonenummysql = 'null',
      emailmysql = 'null',
      birthdatemysql = 'null';
  String driveridnosql = 'null',
      icnumnosql = 'null',
      namenosql = 'null',
      phonenumnosql = 'null',
      emailnosql = 'null',
      birthdatenosql = 'null';
//test database end
//final StreamController _streamController = StreamController();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final driverinfo = Provider.of<Driver>(context);
    final location = Provider.of<LocationProvider>(context);

    print(location.position?.latitude);
    return Scaffold(
      appBar: appBarDesign(context, driverinfo),
      drawer: Drawer(
        child: driverinfo == null
            ? Text('null')
            : Text('data = ${driverinfo.name}'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -
              appBarDesign(context, driverinfo).preferredSize.height -
              MediaQuery.of(context).padding.top,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  menuDesign(
                      'Parking', 'assets/icons/parkingIcon.png', '/parking', {
                    "driverInfo": driverinfo,
                  }),
                  menuDesign('Register Car', 'assets/icons/carIcon.png',
                      '/registercar', driverinfo)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  menuDesign('Compound', 'assets/icons/compoundIcon.png',
                      '/compound', {"driverInfo": driverinfo}),
                  menuDesign('E-wallet', 'assets/icons/walletIcon.png',
                      '/ewallet', {"driverInfo": driverinfo}),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  menuDesign('History', 'assets/icons/historyIcon.png',
                      '/history', {"driverInfo": driverinfo}),
                  menuDesign('Profile', 'assets/icons/profileIcon.png',
                      '/profile', {"driverInfo": driverinfo}),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Column menuDesign(
      String title, String imagePath, String navigationPath, Object? args) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(70),
          splashColor: Colors.green,
          child: Container(
            alignment: Alignment.center,
            height: 100.h,
            width: 100.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffCBF0C1),
                boxShadow: [
                  BoxShadow(color: Colors.grey, blurRadius: 6),
                ]),
            child: Image.asset(
              imagePath,
            ),
          ),
          onTap: () {
            print(title);
            print(args);
            Navigator.of(context).pushNamed(navigationPath, arguments: args);
          },
        ),
        SizedBox(
          height: 12.h,
        ),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20.sp,
            color: const Color(0xff000000),
          ),
          textAlign: TextAlign.left,
        )
      ],
    );
  }

  AppBar appBarDesign(BuildContext context, Driver? driver) {
    return AppBar(
      toolbarHeight: Platform.isAndroid
          ? 190 - MediaQuery.of(context).padding.top
          : 172 - MediaQuery.of(context).padding.top,
      leading: Align(
        alignment: Alignment.topLeft,
        child: Builder(
          builder: (context) => IconButton(
            iconSize: 35,
            icon: Icon(
              Icons.menu,
              color: Color(0xff17B95B),
            ),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            splashRadius: 25,
            onPressed: () {
              print('clicked');
              return Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      actions: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () async {
              //Navigator.of(context).pushReplacementNamed('/');
              await _auth.signOut();
            },
            icon: Icon(
              Icons.power_settings_new,
              color: Color(0xff17B95B),
            ),
            iconSize: 35,
            splashRadius: 25,
          ),
        )
      ],
      backgroundColor: Colors.transparent,
      flexibleSpace: Stack(
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: [
          Image(
            image: AssetImage('assets/icons/header.png'),
            fit: BoxFit.fitHeight,
          ),
          Container(
            height: double.infinity,
            //color: Colors.blueGrey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // width: 100,
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'eWallet Balance',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          color: const Color(0xff707070),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        driver != null
                            ? 'RM ${driver.walletBalance?.toStringAsFixed(2) ?? '0.00'}'
                            : 'RM 0.00', //'RM 0.00',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 30,
                          color: const Color(0xff707070),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      InkWell(
                        child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff54A059),
                                  Color(0xff40B74B),
                                  Color(0xff2CD23C),
                                  Color(0xff1EE332),
                                  Color(0xff0BFD24),
                                ],
                              ),
                            ),
                            child: Text(
                              'Reload',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 20,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            )),
                        onTap: () {
                          Navigator.of(context).pushNamed('/ewallet',
                              arguments: {"driverInfo": driver});
                        },
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/icons/logo1.png',
                  width: 99,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView testDataBase() {
    return SingleChildScrollView(
      child: Container(
        height: 600,
        //color: Colors.grey,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'PHPMYADMIN',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.red),
                //textAlign: TextAlign.center,
              ),
              Text(
                'driverId mysql = $driveridmysql',
                style: style(),
              ),
              Text(
                'icNumber mysql = $icnummysql',
                style: style(),
              ),
              Text(
                'name mysql = $namemysql',
                style: style(),
              ),
              Text(
                'phone number mysql =$phonenummysql',
                style: style(),
              ),
              Text(
                'email mysql = $emailmysql',
                style: style(),
              ),
              Text(
                'birth date mysql = $birthdatemysql',
                style: style(),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Firebase',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.red),
              ),
              Text(
                'driverId nosql = $driveridnosql',
                style: style(),
              ),
              Text(
                'icNumber nosql = $icnumnosql',
                style: style(),
              ),
              Text(
                'name nosql = $namenosql',
                style: style(),
              ),
              Text(
                'phone number nosql =$phonenumnosql',
                style: style(),
              ),
              Text(
                'email nosql = $emailnosql',
                style: style(),
              ),
              Text(
                'birth date nosql = $birthdatenosql',
                style: style(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: InkWell(
                  child: Container(
                    width: 200,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueGrey),
                    child: Center(
                      child: Text(
                        'Get Data',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onTap: () async {
                    getDataMysqlPhpmyadmin();
                    getDataNosqlFirebase();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future getDataMysqlPhpmyadmin() async {
    dynamic data = await MysqlService().getMethod();
    setState(() {
      driveridmysql = data[0]['driverId'].toString();
      icnummysql = data[0]['icNum'].toString();
      namemysql = data[0]['name'].toString();
      phonenummysql = data[0]['phone_num'].toString();
      emailmysql = data[0]['email'].toString();
      birthdatemysql = data[0]['birth_date'].toString();
    });
  }

  Future getDataNosqlFirebase() async {
    FirebaseService serv = new FirebaseService(uid: 'kVhRni1TNzcSiicMdNAg');
    dynamic data = await serv.testGetData();

    setState(() {
      driveridnosql = data['driverId'].toString();
      icnumnosql = data['icNum'].toString();
      namenosql = data['name'].toString();
      phonenumnosql = data['phone_num'].toString();
      emailnosql = data['email'].toString();
      birthdatenosql = DateFormat("yyyy-MM-dd")
          .format(data['birth_date'].toDate())
          .toString();
    });
  }

  TextStyle style() {
    return TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  }
}
