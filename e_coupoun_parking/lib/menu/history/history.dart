import '../../models/history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatelessWidget {
  Map? argument = {};

  HistoryPage({Key? key, this.argument}) : super(key: key);

  List<History> historyList = [
    History(datetime: DateTime.now(), location: "Jalan Duta"),
    History(datetime: DateTime.now(), location: "Jalan Keramat"),
    History(datetime: DateTime.now(), location: "Dataran Amanjaya"),
    History(datetime: DateTime.now(), location: "Aman Central Lot C"),
    History(datetime: DateTime.now(), location: "Jalan Ibrahim"),
    History(datetime: DateTime.parse("2021-09-20"), location: "Jalan Duta"),
    History(datetime: DateTime.parse("2021-09-20"), location: "Jalan Keramat"),
    History(
        datetime: DateTime.parse("2021-09-20"), location: "Dataran Amanjaya"),
    History(
        datetime: DateTime.parse("2021-09-20"), location: "Aman Central Lot C"),
    History(datetime: DateTime.parse("2021-09-20"), location: "Jalan Ibrahim"),
  ];

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    'Last modified: 4 Jan 2021',
                    style: TextStyle(
                      fontFamily: 'SFProText-Regular',
                      fontSize: 14,
                      color: const Color(0xff77838f),
                      letterSpacing: 1.0000000305175782,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 25),
                  // Adobe XD layer: 'Today' (text)
                  Text(
                    'Today',
                    style: TextStyle(
                      fontFamily: 'Poppins-Medium',
                      fontSize: 14,
                      color: const Color(0xff67b281),
                      letterSpacing: 1.0000000305175782,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: historyList.length,
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
                                  shape: BoxShape.circle, color: Colors.green),
                            ),
                            title: Text(
                              historyList[index].location ?? '',
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
                                  .format(historyList[index].datetime!)
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
                  )
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
