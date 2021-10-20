import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
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
                onPressed: () {},
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
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/home');
                              print("login");
                            },
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
          // bottom: PreferredSize(
          //   preferredSize: Size.fromHeight(0),
          //   child: Container(
          //     //height: double.infinity,
          //     //color: Colors.blueGrey,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Container(
          //           // width: 100,
          //           height: 120,
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             children: [
          //               Text(
          //                 'eWallet Balance',
          //                 style: TextStyle(
          //                   fontFamily: 'Roboto',
          //                   fontSize: 20,
          //                   color: const Color(0xff707070),
          //                   fontWeight: FontWeight.w700,
          //                 ),
          //                 textAlign: TextAlign.left,
          //               ),
          //               Text(
          //                 'RM 0.00',
          //                 style: TextStyle(
          //                   fontFamily: 'Roboto',
          //                   fontSize: 30,
          //                   color: const Color(0xff707070),
          //                   fontWeight: FontWeight.w700,
          //                 ),
          //                 textAlign: TextAlign.left,
          //               ),
          //               InkWell(
          //                 child: Container(
          //                     alignment: Alignment.center,
          //                     height: 40,
          //                     width: 140,
          //                     decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(6),
          //                       gradient: LinearGradient(
          //                         colors: [
          //                           Color(0xff54A059),
          //                           Color(0xff40B74B),
          //                           Color(0xff2CD23C),
          //                           Color(0xff1EE332),
          //                           Color(0xff0BFD24),
          //                         ],
          //                       ),
          //                     ),
          //                     child: Text(
          //                       'Reload',
          //                       style: TextStyle(
          //                         fontFamily: 'Roboto',
          //                         fontSize: 20,
          //                         color: const Color(0xffffffff),
          //                         fontWeight: FontWeight.w700,
          //                       ),
          //                       textAlign: TextAlign.left,
          //                     )),
          //                 onTap: () {
          //                   Navigator.of(context).pushReplacementNamed('/home');
          //                   print("login");
          //                 },
          //               ),
          //             ],
          //           ),
          //         ),
          //         Image.asset(
          //           'assets/icons/mpsp-sungaiPetani.png',
          //           width: 99,
          //         )
          //       ],
          //     ),
          //   ),
          //   // child: Row(
          //   //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   //   crossAxisAlignment: CrossAxisAlignment.start,
          //   //   children: [
          //   //     Container(
          //   //       // width: 100,
          //   //       height: 120,
          //   //       child: Column(
          //   //         mainAxisAlignment: MainAxisAlignment.start,
          //   //         children: [
          //   //           Text(
          //   //             'eWallet Balance',
          //   //             style: TextStyle(
          //   //               fontFamily: 'Roboto',
          //   //               fontSize: 20,
          //   //               color: const Color(0xff707070),
          //   //               fontWeight: FontWeight.w700,
          //   //             ),
          //   //             textAlign: TextAlign.left,
          //   //           ),
          //   //           Text(
          //   //             'RM 0.00',
          //   //             style: TextStyle(
          //   //               fontFamily: 'Roboto',
          //   //               fontSize: 30,
          //   //               color: const Color(0xff707070),
          //   //               fontWeight: FontWeight.w700,
          //   //             ),
          //   //             textAlign: TextAlign.left,
          //   //           ),
          //   //           InkWell(
          //   //             child: Container(
          //   //                 alignment: Alignment.center,
          //   //                 height: 40,
          //   //                 width: 140,
          //   //                 decoration: BoxDecoration(
          //   //                   borderRadius: BorderRadius.circular(6),
          //   //                   gradient: LinearGradient(
          //   //                     colors: [
          //   //                       Color(0xff54A059),
          //   //                       Color(0xff40B74B),
          //   //                       Color(0xff2CD23C),
          //   //                       Color(0xff1EE332),
          //   //                       Color(0xff0BFD24),
          //   //                     ],
          //   //                   ),
          //   //                 ),
          //   //                 child: Text(
          //   //                   'Reload',
          //   //                   style: TextStyle(
          //   //                     fontFamily: 'Roboto',
          //   //                     fontSize: 20,
          //   //                     color: const Color(0xffffffff),
          //   //                     fontWeight: FontWeight.w700,
          //   //                   ),
          //   //                   textAlign: TextAlign.left,
          //   //                 )),
          //   //             onTap: () {
          //   //               Navigator.of(context).pushReplacementNamed('/home');
          //   //               print("login");
          //   //             },
          //   //           ),
          //   //         ],
          //   //       ),
          //   //     ),
          //   //     Image.asset(
          //   //       'assets/icons/mpsp-sungaiPetani.png',
          //   //       width: 99,
          //   //     )
          //   //   ],
          //   // ),
          // ),
        ),
        drawer: Drawer(
          child: Text('test'),
        ),
        //extendBody: true,

        body: Center(
          child: Text('homescreen'),
        ),
      ),
    );
  }
}
