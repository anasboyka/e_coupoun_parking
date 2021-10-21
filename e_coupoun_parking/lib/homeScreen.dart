import 'package:e_coupoun_parking/services/auth.dart';
import 'package:e_coupoun_parking/services/firebase_service.dart';
import 'package:e_coupoun_parking/services/mysql_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _auth = AuthService();

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 190,

          //title: Text('data'),
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
                  Navigator.of(context).pushReplacementNamed('/');
                  //await _auth.signOut();
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
                            'RM 0.00',
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
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/icons/mpsp-sungaiPetani.png',
                      width: 99,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: Text('test'),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 600,
            //color: Colors.grey,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
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

    // print(driveridmysql);
    // print(icnummysql);
    // print(namemysql);
    // print(phonenummysql);
    // print(emailmysql);
    // print(birthdatemysql);
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
      birthdatenosql = data['birth_date'].toString();
    });
  }

  TextStyle style() {
    return TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  }
}
