import 'package:e_coupoun_parking/constant.dart';
import 'package:e_coupoun_parking/custom_widget/custom_expansionpanel.dart';
import 'package:e_coupoun_parking/models/driveruid.dart';
import 'package:e_coupoun_parking/services/firebase_service.dart';
import 'package:provider/provider.dart';

import '../../models/compound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CompoundPage extends StatefulWidget {
  Map? argument = {};
  CompoundPage({Key? key, this.argument}) : super(key: key);

  @override
  State<CompoundPage> createState() => _CompoundPageState();
}

class _CompoundPageState extends State<CompoundPage> {
  final searchCon = TextEditingController();
  int currentBtnIndex = 0;

  // List<Compound> compoundList = [
  //   Compound(
  //       //amount: 2000,
  //       dateIssued: DateTime.parse("2021-09-20"),
  //       datePaid: DateTime.parse("2021-09-30"),
  //       locationId: "locationId",
  //       locationName: 'Jalan Tanduk',
  //       carId: 'ABC1234',
  //       officerId: 'officer_Id',
  //       isPaid: false),
  //   Compound(
  //       //amount: 2000,
  //       dateIssued: DateTime.parse("2021-09-20"),
  //       datePaid: DateTime.parse("2021-09-30"),
  //       locationId: "locationId",
  //       locationName: 'Central Squuare',
  //       carId: 'ABC1234',
  //       officerId: 'officer_Id',
  //       isPaid: true),
  //   Compound(
  //       amount: 2000,
  //       dateIssued: DateTime.parse("2021-09-20"),
  //       datePaid: DateTime.parse("2021-09-30"),
  //       locationId: "locationId",
  //       locationName: 'Jalan Tanduk',
  //       carId: 'ABC1234',
  //       officerId: 'officer_Id',
  //       isPaid: true),
  //   Compound(
  //       //amount: 2000,
  //       dateIssued: DateTime.parse("2021-09-20"),
  //       datePaid: DateTime.parse("2021-09-30"),
  //       locationId: "locationId",
  //       locationName: 'Amanjaya mall',
  //       carId: 'ABC1234',
  //       officerId: 'officer_Id',
  //       isPaid: false),
  //   Compound(
  //       amount: 2000,
  //       dateIssued: DateTime.parse("2021-09-20"),
  //       datePaid: DateTime.parse("2021-09-30"),
  //       locationId: "locationId",
  //       locationName: 'Laguna',
  //       carId: 'ABC1234',
  //       officerId: 'officer_Id',
  //       isPaid: true),
  //   Compound(
  //       //amount: 2000,
  //       dateIssued: DateTime.parse("2021-09-20"),
  //       datePaid: DateTime.parse("2021-09-30"),
  //       locationId: "locationId",
  //       locationName: 'Car park central',
  //       carId: 'ABC1234',
  //       officerId: 'officer_Id',
  //       isPaid: false),
  //   Compound(
  //       //amount: 2000,
  //       dateIssued: DateTime.parse("2021-09-20"),
  //       datePaid: DateTime.parse("2021-09-30"),
  //       locationId: "locationId",
  //       locationName: 'Village Mall',
  //       carId: 'ABC1234',
  //       officerId: 'officer_Id',
  //       isPaid: true),
  // ];

  List<Map<String, dynamic>> tabBtn = [
    {'title': 'All', "number": 0},
    // {'title': 'Overdue', 'number': 6},
    {'title': 'Uncompleted', 'number': 4}
  ];

  @override
  Widget build(BuildContext context) {
    Driveruid driveruid = Provider.of<Driveruid>(context);
    return Scaffold(
      appBar: compoundListAppbarDesign(),
      backgroundColor: Color(0xffE1F9E0),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 15.h, 24.w, 0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Search by vechicle plate',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16.sp,
                    color: const Color(0xff1e2022),
                    letterSpacing: 1,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              gaph(h: 15),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchCon,
                      //inputFormatters: [UpperCaseTextFormatter()],
                      textCapitalization: TextCapitalization.characters,
                      cursorColor: kprimaryColor,
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: kbtnColor,
                        ),
                        suffixIcon: Material(
                          color: Colors.transparent,
                          child: IconButton(
                            splashRadius: 15,
                            icon: Icon(
                              Icons.clear,
                              color: kbtnColor,
                            ),
                            onPressed: () {
                              searchCon.clear();
                              setState(() {});
                            },
                          ),
                        ),
                        hintStyle:
                            TextStyle(fontSize: 16.sp, color: Colors.grey),
                        hintText: 'Car Plate Number',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                        constraints:
                            BoxConstraints(maxHeight: 40, minHeight: 40),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: kprimaryColor),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: kprimaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: kprimaryColor),
                        ),
                      ),
                    ),
                  ),
                  gapw(w: 10),
                  MaterialButton(
                    height: 40,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    color: kbtnColor,
                    child: Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    onPressed: () {
                      setState(() {});
                    },
                  )
                ],
              ),

              // Text(
              //   'Last modified: 4 Jan 2021',
              //   style: TextStyle(
              //     fontFamily: 'SFProText-Regular',
              //     fontSize: 14.sp,
              //     color: const Color(0xff77838f),
              //     letterSpacing: 1.0000000305175782,
              //   ),
              //   textAlign: TextAlign.left,
              // ),
              SizedBox(height: 8.h),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: tabBtn.map((e) {
              //     int index = tabBtn.indexOf(e);
              //     return buttonTabDesign(index, e['title'], e['number']);
              //   }).toList(),
              // ),
              searchCon.text.isNotEmpty
                  ? FutureBuilder(
                      future: FirebaseService(uid: driveruid.uid)
                          .getCarCompoundListById(searchCon.text.toUpperCase()),
                      builder: (_, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data);
                          List<Compound> compoundList = snapshot.data;
                          if (compoundList.length > 0) {
                            return listviewCompoundView(compoundList);
                          } else {
                            return ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              tileColor: Colors.white,
                              horizontalTitleGap: 0,
                              title: Text(
                                'No Compound Issued for this car',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                  color: const Color(0xff77838f),
                                  letterSpacing: 1.0000000305175782,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            );
                          }
                        } else {
                          return CircularProgressIndicator.adaptive();
                        }
                      })
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget listviewCompoundView(List<Compound> compoundList) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: compoundList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white,
              ),
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  backgroundColor: Colors.transparent,
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  title: Row(
                    children: [
                      listTileData(
                          'Offence Location', compoundList[index].locationName)
                    ],
                  ),
                  children: [
                    gaph(h: 1),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(
                        color: kgreycolor1,
                        thickness: 1.5,
                        height: 0,
                      ),
                    ),
                    gaph(h: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          listTileData(
                            'Offence Date & Time',
                            DateFormat('dd-MM-yyyy')
                                .format(compoundList[index].dateIssued),
                          ),
                          const Spacer(),
                          listTileData(
                            'Amount',
                            'RM ${compoundList[index].amount.toStringAsFixed(2)}',
                          ),
                        ],
                      ),
                    ),
                    gaph(h: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: listTileData(
                        'Type Of Offence',
                        compoundList[index].offenceType,
                      ),
                    ),
                    gaph(h: 12),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Column listTileData(
    String title,
    String data,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 10,
            color: const Color(0xff808080),
          ),
        ),
        gaph(h: 3),
        Text(
          data, //'Hentian Tikam Batu',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 12,
            color: const Color(0xff000000),
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }

  Container buttonTabDesign(int index, String title, int notification) {
    return Container(
      margin: EdgeInsets.only(right: 20.w),
      height: 57.h,
      constraints:
          BoxConstraints(maxHeight: 57.h, minWidth: 57.w, maxWidth: 400.w),
      child: IntrinsicWidth(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: ElevatedButton(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16.sp,
                      color: index == currentBtnIndex
                          ? Color(0xffffffff)
                          : Color(0xff77838f),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: index == currentBtnIndex
                          ? Color(0xff16AA10)
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: Size(53.w, 46.h),
                      maximumSize: Size(200.w, 46.h)),
                  onPressed: () {
                    setState(() {
                      currentBtnIndex = index;
                    });
                  },
                ),
              ),
            ),
            notification != 0
                ? Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      alignment: Alignment.center,
                      width: 22.w,
                      height: 22.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              title == 'Overdue' ? Colors.yellow : Colors.red),
                      child: Text(
                        notification.toString(),
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12.sp,
                          color: const Color(0xffffffff),
                          letterSpacing: 0.6000000000000001,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  AppBar compoundListAppbarDesign() {
    return AppBar(
      title: Text(
        'Compound',
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
      elevation: 1,
    );
  }
}
