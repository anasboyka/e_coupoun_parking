import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationSelection extends StatelessWidget {
  Map? args = {};
  LocationSelection({Key? key, this.args}) : super(key: key);
  TextEditingController searchcon = new TextEditingController();

  List<Map<String, String>> location = [
    {
      'location': 'Kawasan Parkir Bateri',
      'subLocation': 'Airport Camp, Taman Patani Jaya.'
    },
    {'location': 'Hentian Tikam Batu', 'subLocation': 'RNR Tikam Batu.'},
    {
      'location': 'Padang Merpati Lot 88',
      'subLocation': 'Lorong 2/3, Padang Merpati.'
    },
    {
      'location': 'Tapak Parking Jam Besar',
      'subLocation': '69, Jalan Ibrahim.'
    },
    {
      'location': 'Amanjaya Mall',
      'subLocation': 'Car Park, Amanjaya Mall, Bandar Amanjaya.'
    },
    {'location': 'Taman Melor Food Court', 'subLocation': 'Taman Melor'},
    {
      'location': 'Kawasan Parkir KTM',
      'subLocation': 'Bangunan MPSP, 3, Jalan Market.'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: locationSelectionAppbarDesign('Choose Location'),
      backgroundColor: Color(0xffE1F9E0),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                elevation: 2,
                child: TextFormField(
                  controller: searchcon,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: InputDecoration(
                    hintText: "Search Location",
                    hintStyle: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      color: const Color(0xffbebebe),
                      fontWeight: FontWeight.w700,
                    ),
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {},
                    ),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Container(
                width: double.infinity,
                child: Card(
                  elevation: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
                        child: Text(
                          'Location List',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            color: const Color(0xff707070),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 14.h),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
                        child: Divider(
                          color: Color(0xffC8C8C8),
                          thickness: 1,
                          height: 0,
                          endIndent: 0,
                          indent: 0,
                        ),
                      ),
                      SizedBox(height: 25.h),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              location[index]['location'] ?? '',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 18,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            subtitle: Text(
                              location[index]['subLocation'] ?? '',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 15,
                                color: const Color(0xffbebebe),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            dense: true,
                            //horizontalTitleGap: 0,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20.w),
                            onTap: () {},
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Divider(
                              color: Color(0xffC8C8C8),
                              thickness: 1,
                              height: 0,
                              endIndent: 0,
                              indent: 0,
                            ),
                          );
                        },
                        itemCount: location.length,
                        shrinkWrap: true,
                      ),
                      SizedBox(height: 30.h)
                      // ListTile(
                      //   title: Text(
                      //     location[0]['location'] ?? '',
                      //     style: TextStyle(
                      //       fontFamily: 'Roboto',
                      //       fontSize: 18,
                      //       color: const Color(0xff000000),
                      //       fontWeight: FontWeight.w700,
                      //     ),
                      //     textAlign: TextAlign.left,
                      //   ),
                      //   subtitle: Text(
                      //     location[0]['subLocation'] ?? '',
                      //     style: TextStyle(
                      //       fontFamily: 'Roboto',
                      //       fontSize: 15,
                      //       color: const Color(0xffbebebe),
                      //       fontWeight: FontWeight.w700,
                      //     ),
                      //     textAlign: TextAlign.left,
                      //   ),
                      //   dense: true,
                      //   //horizontalTitleGap: 0,
                      //   contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                      //   onTap: () {},
                      // )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar locationSelectionAppbarDesign(String titleAppbar) {
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
