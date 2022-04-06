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
  int currentBtnIndex = 0;

  List<Compound> compoundList = [
    Compound(
        amount: 2000,
        dateCompoundStart: DateTime.parse("2021-09-20"),
        dateCompoundEnd: DateTime.parse("2021-09-30"),
        documentID: "Jalan Mahkota Lama",
        status: "uncompleted",
        read: false),
    Compound(
        amount: 2000,
        dateCompoundStart: DateTime.parse("2021-07-23"),
        dateCompoundEnd: DateTime.parse("2021-08-03"),
        documentID: "Jalan Tun Hussein",
        status: "uncompleted",
        read: false),
    Compound(
        amount: 2000,
        dateCompoundStart: DateTime.parse("2021-03-14"),
        dateCompoundEnd: DateTime.parse("2021-03-24"),
        documentID: "Amanjaya Sport Center",
        status: "uncompleted",
        read: false),
    Compound(
        amount: 2000,
        dateCompoundStart: DateTime.parse("2021-12-28"),
        dateCompoundEnd: DateTime.parse("2022-01-08"),
        documentID: "Village mall",
        status: "paid",
        read: false),
    Compound(
        amount: 2000,
        dateCompoundStart: DateTime.parse("2020-10-11"),
        dateCompoundEnd: DateTime.parse("2020-10-21"),
        documentID: "Hospital Sultan Abdul Halim",
        status: "paid",
        read: false),
    Compound(
        amount: 2000,
        dateCompoundStart: DateTime.parse("2020-08-22"),
        dateCompoundEnd: DateTime.parse("2020-09-02"),
        documentID: "Jalan Ibrahim",
        status: "uncompleted",
        read: false),
    Compound(
        amount: 2000,
        dateCompoundStart: DateTime.parse("2020-07-11"),
        dateCompoundEnd: DateTime.parse("2020-07-21"),
        documentID: "Dataran Amanjaya",
        status: "paid",
        read: false),
    Compound(
        amount: 2000,
        dateCompoundStart: DateTime.parse("2020-06-16"),
        dateCompoundEnd: DateTime.parse("2020-06-26"),
        documentID: "Jalan Taman Pekan Lama",
        status: "paid",
        read: false),
    Compound(
        amount: 2000,
        dateCompoundStart: DateTime.parse("2020-05-14"),
        dateCompoundEnd: DateTime.parse("2020-05-24"),
        documentID: "Jalan Taman Pekan Lama",
        status: "paid",
        read: false),
    Compound(
        amount: 2000,
        dateCompoundStart: DateTime.parse("2020-03-18"),
        dateCompoundEnd: DateTime.parse("2020-03-28"),
        documentID: "Jalan Taman Pekan Lama",
        status: "paid",
        read: false),
  ];

  List<Map<String, dynamic>> tabBtn = [
    {'title': 'All', "number": 0},
    // {'title': 'Overdue', 'number': 6},
    {'title': 'Uncompleted', 'number': 4}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: compoundListAppbarDesign(),
      backgroundColor: Color(0xffE1F9E0),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 15.h, 24.w, 0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Compound list',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20.sp,
                  color: const Color(0xff1e2022),
                  letterSpacing: 1,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 8.h),
              Text(
                'Last modified: 4 Jan 2021',
                style: TextStyle(
                  fontFamily: 'SFProText-Regular',
                  fontSize: 14.sp,
                  color: const Color(0xff77838f),
                  letterSpacing: 1.0000000305175782,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: tabBtn.map((e) {
                  int index = tabBtn.indexOf(e);
                  return buttonTabDesign(index, e['title'], e['number']);
                }).toList(),
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: compoundList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.h, horizontal: 0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: ListTile(
                          horizontalTitleGap: 0,
                          leading: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: compoundList[index].status == "uncompleted"
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                          title: Text(
                            compoundList[index].documentID ?? 'null',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              color: const Color(0xff77838f),
                              letterSpacing: 1.0000000305175782,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          trailing: Text(
                            'due by ${DateFormat("yyyy-MM-dd").format(compoundList[index].dateCompoundEnd).toString()}',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              color: compoundList[index].status == "uncompleted"
                                  ? Color(0xffe30c0c)
                                  : Color(0xff77838F),
                              letterSpacing: 0.8571428833007813,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
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
