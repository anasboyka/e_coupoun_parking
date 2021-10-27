import 'package:e_coupoun_parking/constant.dart';
import 'package:flutter/material.dart';

class Ewallet extends StatelessWidget {
  //const Ewallet({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: eWalletAppbarDesign(),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: bgColor,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Hello User!',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        color: const Color(0xff1e2022),
                        letterSpacing: 1,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 25),
                  Container(
                    height: 220,
                    width: 314,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              // boxShadow: [
                              //   BoxShadow(color: Colors.grey, blurRadius: 3,offset: Offset(0,1)),
                              // ],
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Adobe XD layer: '$' (text)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 2),
                                    child: Text(
                                      'RM',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 28,
                                        color: const Color(0xff8392a7),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ), // Adobe XD layer: '79.68' (text)
                                  Text(
                                    '23.00',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 72,
                                      color: const Color(0xff16aa32),
                                    ),
                                    textAlign: TextAlign.left,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 6,
                                primary: Color(0xff16AA32),
                                minimumSize: Size(142, 62),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(44))),
                            onPressed: () {},
                            child: Text(
                              'TOP UP',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 19,
                                color: const Color(0xffffffff),
                                letterSpacing: 1.3571428985595704,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buttonWalletDesign(
                          'Scan', 'assets/icons/BarcodeScanIcon.png'),
                      buttonWalletDesign(
                          'Transfer', 'assets/icons/transferIcon.png'),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buttonWalletDesign(
                          'Reload', 'assets/icons/reloadIcon.png'),
                      buttonWalletDesign(
                          'Debit Card', 'assets/icons/debitCardIcon.png'),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buttonWalletDesign(String title, String assetPath) {
    return Container(
      height: 110,
      width: 175,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: Offset(0, 0.5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(assetPath),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Montserrat-Regular',
              fontSize: 13,
              color: const Color(0xff8392a7),
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  AppBar eWalletAppbarDesign() {
    return AppBar(
      title: Text(
        'Reload',
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
