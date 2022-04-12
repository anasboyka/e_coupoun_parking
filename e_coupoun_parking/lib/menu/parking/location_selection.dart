import 'package:e_coupoun_parking/models/location_parking.dart';
import 'package:e_coupoun_parking/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationSelection extends StatefulWidget {
  Map? args = {};
  LocationSelection({Key? key, this.args}) : super(key: key);

  @override
  State<LocationSelection> createState() => _LocationSelectionState();
}

class _LocationSelectionState extends State<LocationSelection> {
  TextEditingController searchcon = new TextEditingController();
  String query = '';

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
                  onChanged: (value) => setState(() => query = value),
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
                      onPressed: () {
                        searchcon.clear();
                      },
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
                      // SizedBox(height: 25.h),
                      listLocationParkingBuilder(query),
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

  StreamBuilder<List<LocationParking>> listLocationParkingBuilder(
      String query) {
    //print(query);
    return StreamBuilder(
      stream: FirebaseService().locations,
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<LocationParking> locationParkings = snapshot.data;
          if (query.isNotEmpty) {
            List<LocationParking> locationParkingsTemp = [];
            for (var i = 0; i < locationParkings.length; i++) {
              if (locationParkings[i]
                  .locationName
                  .toLowerCase()
                  .startsWith(query.toLowerCase())) {
                locationParkingsTemp.add(locationParkings[i]);
              }
            }
            locationParkings = locationParkingsTemp;
          }

          if (locationParkings.length != 0) {
            return ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                //print(locationParkings.length);
                return ListTile(
                  title: Text(
                    locationParkings[index].locationName, //?? '',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  subtitle: Text(
                    locationParkings[index].locationSubname, //?? '',
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
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                  onTap: () {
                    Navigator.of(context)
                        .pop({'locationParking': locationParkings[index]});
                  },
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
              itemCount: locationParkings.length,
              shrinkWrap: true,
            );
          } else {
            return ListTile(
              title: Text(
                'Location not found',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16.sp,
                  color: const Color(0xff707070),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
        } else {
          print('loading');
          return CircularProgressIndicator.adaptive();
        }
      },
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
