import '../../models/driver.dart';
import '../../models/driveruid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  Map? argument = {};
  ProfilePage({Key? key, this.argument}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with InputValidationMixin {
  List<bool> enabled = List.filled(5, false);

  Driver? driverInfo;
  String username = '', name = '', icNum = '', dateOfBirth = '', phoneNum = '';

  TextEditingController usernamecon = new TextEditingController();
  TextEditingController namecon = new TextEditingController();
  TextEditingController icNumcon = new TextEditingController();
  TextEditingController dateOfBirthcon = new TextEditingController();
  TextEditingController phoneNumcon = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // FocusNode nodeusername = FocusNode();
  // FocusNode nodename = FocusNode();
  // FocusNode nodeicnum = FocusNode();
  // FocusNode nodedateofbirth = FocusNode();

  List<FocusNode> node = List.filled(4, new FocusNode());

  List<String> label = [
    'Name',
    'Phone Number',
    "Username",
    "IC Number",
    "Date Of Birth"
  ];

  DateTime _date = DateTime.now();

  Future _selectDate(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1992),
      lastDate: DateTime(2030),
    );

    if (_datePicker != null && _datePicker != _date) {
      setState(() {
        _date = _datePicker;
        dateOfBirth = DateFormat("yyyy-MM-dd").format(_date).toString();
        dateOfBirthcon.text = dateOfBirth;
      });
      //print(_date.toLocal());
      //print(DateFormat("yyyy-MM-dd").format(_date));
    }
  }

  createAlertDialog(BuildContext context, String inputData, String title) {
    Size size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 19,
                color: const Color(0xff131450),
              ),
              textAlign: TextAlign.left,
            ),
            content: Text(
              inputData,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 19,
                color: const Color(0xff131450),
              ),
              textAlign: TextAlign.left,
            ),
            actions: [
              InkWell(
                child: Container(
                  width: 74,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xffF04437),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                onTap: () {
                  //Navigator.of(context).pop("data from dialog");
                  Navigator.of(context).pop();
                },
              ),
              InkWell(
                child: Container(
                  width: 74,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xff16AA32),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                onTap: () {
                  if (title == 'Clear') {
                    namecon.clear();
                    phoneNumcon.clear();
                    usernamecon.clear();
                    icNumcon.clear();
                    dateOfBirthcon.text = DateFormat('yyyy-MM-dd')
                        .format(DateTime.parse("1111-11-11"));
                    Navigator.of(context).pop();
                  } else if (title == 'Save') {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(23),
            ),
            actionsPadding: EdgeInsets.fromLTRB(0, 43, 9, 15),
            buttonPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            contentPadding: EdgeInsets.fromLTRB(27, 20, 15, 0),
            insetPadding: EdgeInsets.fromLTRB(55, 0, 55, 0),
            titlePadding: EdgeInsets.fromLTRB(27, 27, 27, 0),
          );
        });
  }

  @override
  void initState() {
    driverInfo = widget.argument!['driverInfo'];
    print(driverInfo!.name);
    initDriverData();
    // TODO: implement initState
    //widget.argument!['driverinfo']==null?usernamecon = new TextEditingController():usernamecon = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppbarDesign('Profile'),
      backgroundColor: Color(0xffE1F9E0),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                textFieldDesign(namecon, 0, 'assets/icons/nameIcon.png'),
                textFieldDesign(
                    phoneNumcon, 1, 'assets/icons/phoneNumberIcon.png'),
                textFieldDesign(
                    usernamecon, 2, 'assets/icons/usernameIcon.png'),
                textFieldDesign(icNumcon, 3, 'assets/icons/icNumberIcon.png'),
                textFieldDesign(
                    dateOfBirthcon, 4, 'assets/icons/birthDateIcon.png'),
                SizedBox(height: 100.h),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(
                            //minWidth: size.width / 2 - 30.w,
                            minHeight: 62.h,
                            maxHeight: 66.h,
                            minWidth: double.infinity
                            //maxHeight: 40,
                            ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff16AA32),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            'Save',
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 20.sp,
                              color: const Color(0xffffffff),
                              letterSpacing: 1.0714286041259766,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            if (!isNameValid(namecon.text)) {
                              print('name');
                              createAlertDialog(
                                  context, 'Name cannot be empty', 'Name');
                            } else if (!isPhoneNumValid(phoneNumcon.text)) {
                              print('phone');
                              createAlertDialog(
                                  context,
                                  'Phone Number cannot be empty',
                                  'Phone Number');
                            } else if (!isUserNameValid(usernamecon.text)) {
                              print('username');
                              createAlertDialog(context,
                                  'username cannot be empty', 'username');
                            } else if (!isIcNumValid(icNumcon.text)) {
                              print('Ic num');
                              createAlertDialog(context,
                                  'IC Number cannot be empty', 'IC Number');
                            } else if (!isDateBirthValid(dateOfBirthcon.text)) {
                              print('date');
                              createAlertDialog(
                                  context,
                                  'Date of birth cannot be empty or invalid',
                                  'Date of birth');
                            } else {
                              createAlertDialog(
                                  context, 'Save all credential?', 'Save');
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(
                            //minWidth: size.width / 2 - 30.w,
                            minHeight: 62.h,
                            maxHeight: 66.h,
                            minWidth: double.infinity
                            //maxHeight: 40,
                            ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            'Clear',
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 20.sp,
                              color: const Color(0xffBEBEBE),
                              letterSpacing: 1.0714286041259766,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            createAlertDialog(
                                context,
                                'Are you sure you want to clear all credential?',
                                'Clear');
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void initDriverData() {
    if (driverInfo != null) {
      String date = driverInfo!.birthDate?.toString() ?? '';

      if (driverInfo!.username!.isNotEmpty) {
        usernamecon =
            new TextEditingController(text: driverInfo?.username ?? '');
      }
      if (driverInfo!.name!.isNotEmpty) {
        namecon = new TextEditingController(text: driverInfo?.name ?? '');
      }
      if (driverInfo!.icNum!.isNotEmpty) {
        icNumcon = new TextEditingController(text: driverInfo?.icNum ?? '');
      }
      if (driverInfo!.phoneNum!.isNotEmpty) {
        phoneNumcon =
            new TextEditingController(text: driverInfo?.phoneNum ?? '');
      }
      if (date.isNotEmpty) {
        dateOfBirthcon = new TextEditingController(
            text: DateFormat('yyyy-MM-dd')
                .format(driverInfo?.birthDate ?? DateTime.parse("1111-11-11"))
                .toString());
      }
    }
  }

  AppBar profileAppbarDesign(String titleAppbar) {
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

      flexibleSpace: Image(
        image: AssetImage('assets/icons/header.png'),
        fit: BoxFit.fitWidth,
      ),
      //backgroundColor: Colors.transparent,
      elevation: 1,
    );
  }

  Widget textFieldDesign(
      TextEditingController controller, int index, String imagePath) {
    return Container(
      width: double.infinity,
      height: 80.h,
      child: Card(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 20.w),
            Expanded(
              child: TextFormField(
                controller: controller,
                enabled: enabled[index],
                // focusNode: node[0],
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  color: enabled[index] ? Colors.black : Color(0xffBEBEBE),
                  fontWeight: FontWeight.w700,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  icon: Image.asset(
                    imagePath,
                    width: 26.w,
                  ),
                  labelText: label[index],
                  labelStyle: TextStyle(
                    fontFamily: 'Roboto',
                    //fontSize: 13.sp,
                    color: const Color(0xffbebebe),
                    fontWeight: FontWeight.w700,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffC8C8C8)),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (label[index] != "Date Of Birth") {
                    enabled[index] = !enabled[index];
                  } else {
                    enabled[index] = true;
                    _selectDate(context);
                    enabled[index] = false;
                  }
                });
              },
              icon: enabled[index] ? Icon(Icons.check) : Icon(Icons.edit),
            )
          ],
        ),
      ),
    );
  }
}

mixin InputValidationMixin {
  bool isNameValid(String? name) => name != null ? name.isNotEmpty : false;

  bool isPhoneNumValid(String? phoneNum) =>
      phoneNum != null ? phoneNum.isNotEmpty : false;

  bool isUserNameValid(String? username) =>
      username != null ? username.isNotEmpty : false;

  bool isIcNumValid(String? icNum) => icNum != null ? icNum.isNotEmpty : false;

  bool isDateBirthValid(String? dateBirth) => dateBirth != null
      ? dateBirth != '1111-11-11'
          ? dateBirth.isNotEmpty
          : false
      : false;
}
