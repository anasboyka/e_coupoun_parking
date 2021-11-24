import 'package:e_coupoun_parking/models/compound.dart';
import 'package:flutter/material.dart';
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
        dateTime: DateTime.parse("2021-09-20"),
        location: "Jalan Mahkota Lama",
        status: "problem",
        read: false),
    Compound(
        dateTime: DateTime.parse("2021-07-23"),
        location: "Jalan Tun Hussein",
        status: "problem",
        read: false),
    Compound(
        dateTime: DateTime.parse("2021-03-14"),
        location: "Amanjaya Sport Center",
        status: "problem",
        read: false),
    Compound(
        dateTime: DateTime.parse("2021-12-28"),
        location: "Village mall",
        status: "problem",
        read: false),
    Compound(
        dateTime: DateTime.parse("2020-10-11"),
        location: "Hospital Sultan Abdul Halim",
        status: "problem",
        read: false),
    Compound(
        dateTime: DateTime.parse("2020-08-22"),
        location: "Jalan Ibrahim",
        status: "problem",
        read: false),
    Compound(
        dateTime: DateTime.parse("2020-07-11"),
        location: "Dataran Amanjaya",
        status: "problem",
        read: false),
    Compound(
        dateTime: DateTime.parse("2020-05-14"),
        location: "Jalan Taman Pekan Lama",
        status: "problem",
        read: false),
  ];

  List<String> tabBtn = ['All', 'Overdue', 'Uncompleted'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: registerCarAppbarDesign(),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            color: Color(0xffE1F9E0),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.only(left: 24.0),
                  child: Text(
                    'Compound list',
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
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.only(left: 24.0),
                  child: Text(
                    'Last modified: 4 Jan 2021',
                    style: TextStyle(
                      fontFamily: 'SFProText-Regular',
                      fontSize: 14,
                      color: const Color(0xff77838f),
                      letterSpacing: 1.0000000305175782,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: tabBtn.map((e) {
                    int index = tabBtn.indexOf(e);
                    return buttonTabDesign(index, e);
                  }).toList(),
                ),
                ListView.builder(
                    itemCount: compoundList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            title: // Adobe XD layer: 'Hot Pepper Sauce' (text)
                                Text(
                              compoundList[index].location ?? 'null',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: const Color(0xff77838f),
                                letterSpacing: 1.0000000305175782,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            trailing: // Adobe XD layer: '1kg' (text)
                                Text(
                              'due by ${DateFormat("yyyy-MM-dd").format(compoundList[index].dateTime!).toString()}',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 12,
                                color: const Color(0xffe30c0c),
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
          )
        ],
      ),
    );
  }

  Container buttonTabDesign(int index, String title) {
    return Container(
      height: 57,
      constraints: BoxConstraints(maxHeight: 57, minWidth: 57, maxWidth: 400),
      child: IntrinsicWidth(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: ElevatedButton(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
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
                      minimumSize: Size(53, 46),
                      maximumSize: Size(200, 46)),
                  onPressed: () {
                    setState(() {
                      currentBtnIndex = index;
                    });
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                alignment: Alignment.center,
                width: 22,
                height: 22,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                child: Text(
                  '5',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 12,
                    color: const Color(0xffffffff),
                    letterSpacing: 0.6000000000000001,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar registerCarAppbarDesign() {
    return AppBar(
      title: Text(
        'Compound',
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
