import 'package:e_coupoun_parking/constant.dart';
import 'package:e_coupoun_parking/models/driveruid.dart';
import 'package:e_coupoun_parking/models/parking.dart';
import 'package:e_coupoun_parking/services/firebase_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {
  Map? argument = {};

  HistoryPage({Key? key, this.argument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Driveruid driveruid = Provider.of<Driveruid>(context);
    return Scaffold(
      appBar: historyAppbarDesign('History'),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            color: Color(0xffE1F9E0),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 15, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Parking History',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      color: const Color(0xff1e2022),
                      letterSpacing: 1,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 8),
                  StreamBuilder(
                      stream:
                          FirebaseService(uid: driveruid.uid).userParkingList,
                      builder: (_, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          List<Parking> parkings = snapshot.data;
                          return Text(
                            parkings.isEmpty
                                ? 'No parking History'
                                : 'Last parking: ${DateFormat("yyyy-MM-dd").format(parkings[0].date).toString()}',
                            style: TextStyle(
                              fontFamily: 'SFProText-Regular',
                              fontSize: 14,
                              color: const Color(0xff77838f),
                              letterSpacing: 1.0000000305175782,
                            ),
                            textAlign: TextAlign.left,
                          );
                        } else {
                          return Center(
                              child: CircularProgressIndicator.adaptive());
                        }
                      }),
                  gaph(),
                  StreamBuilder(
                      stream:
                          FirebaseService(uid: driveruid.uid).userParkingList,
                      builder: (_, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          List<Parking> parkingHistoryList = snapshot.data;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: parkingHistoryList.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    dense: true,
                                    horizontalTitleGap: 0,
                                    leading: Container(
                                      alignment: Alignment.center,
                                      width: 22,
                                      height: 22,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green),
                                    ),
                                    title: Text(
                                      parkingHistoryList[index].locationName ??
                                          '',
                                      style: TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        fontSize: 14,
                                        color: const Color(0xff242628),
                                        letterSpacing: 1.0000000305175782,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    trailing: Text(
                                      DateFormat("yyyy-MM-dd")
                                          .format(
                                              parkingHistoryList[index].date)
                                          .toString(),
                                      style: TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 12,
                                        color: const Color(0xffaaadaf),
                                        letterSpacing: 1.000000030517578,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  Divider(
                                    thickness: 2,
                                  )
                                ],
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar historyAppbarDesign(String titleAppbar) {
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
