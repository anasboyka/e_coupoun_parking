import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant.dart';
import '../services/auth.dart';
import 'login.dart';
import 'register.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  int currentIndex = 0;
  int animatedpos = 0;

  bool togglePlaces = true;
  bool isHidden2 = true;
  bool isHidden1 = true;
  bool animationEnd = true;
  bool valSwitch = true;
  bool loading = false;

  final usernamecon = new TextEditingController();
  final namecon = new TextEditingController();
  final phoneNumcon = new TextEditingController();
  final emailcon = new TextEditingController();
  final passcon = new TextEditingController();
  final confirmpasscon = new TextEditingController();
  final icNumcon = new TextEditingController();
  final dateOfBirthcon = new TextEditingController();
  final loginEmailcon = new TextEditingController();
  final loginpasscon = new TextEditingController();

  final pagecon = new PageController(initialPage: 0);

  String //username = "",
      //name = "",
      phoneNum = "",
      email = "",
      pass = "",
      confirmPass = "",
      //icNum = "",
      //dateOfBirth = "",
      error = "error";

  final _formkey = GlobalKey<FormState>();
  final AuthService _auth = new AuthService();
  //final MysqlService _sql = new MysqlService();
  DateTime? _date; // = DateTime.now();

  // Future _selectDate(BuildContext context) async {
  //   DateTime? _datePicker = await showDatePicker(
  //     context: context,
  //     initialDate: _date,
  //     firstDate: DateTime(1992),
  //     lastDate: DateTime(2030),
  //   );

  //   if (_datePicker != null && _datePicker != _date) {
  //     setState(() {
  //       _date = _datePicker;
  //       dateOfBirth = DateFormat("yyyy-MM-dd").format(_date).toString();
  //       dateOfBirthcon.text = dateOfBirth;
  //     });
  //     //print(_date.toLocal());
  //     //print(DateFormat("yyyy-MM-dd").format(_date));
  //   }
  // }

  createAlertDialog(BuildContext context, String inputData) {
    Size size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'E-Coupoun Parking',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 19,
                color: const Color(0xff131450),
              ),
              textAlign: TextAlign.left,
            ),
            content: Text(
              'Please enter $inputData',
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
                  //Navigator.of(context).pop("data from dialog");
                  Navigator.of(context).pop();
                },
              )
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(23),
            ),
            actionsPadding: EdgeInsets.fromLTRB(0, 43, 9, 15),
            buttonPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            contentPadding: EdgeInsets.fromLTRB(27, 20, 15, 0),
            insetPadding: EdgeInsets.fromLTRB(55, 0, 55, 0),
            titlePadding: EdgeInsets.fromLTRB(27, 27, 27, 0),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0.05 * size.height),
                child: Image.asset(
                  'assets/icons/logo1.png',
                  height: 185,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50.w, 10.h, 50.w, 0),
                // ((size.width - (size.width * 0.77)) / 2),
                // 0.02 * size.height,
                // ((size.width - (size.width * 0.77)) / 2),
                // 0,
                // ),
                child: Container(
                  //alignment: Alignment.center,
                  height: 60,
                  //width: 0.77 * size.width,
                  //padding: EdgeInsets.only(top: 0.02 * size.height),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [
                        kdarkGreen,
                        kdarkMediumGreen,
                        kmediumGreen,
                        kmediumlightGreen,
                        klightGreen,
                      ],
                    ),
                  ),
                  child:
                      //     CustomSlidingSegmentedControl(
                      //   //clipBehavior: Clip.antiAliasWithSaveLayer,
                      //   //fromMax: true,
                      //   duration: Duration(milliseconds: 300),
                      //   height: 60.h,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(30),
                      //     gradient: LinearGradient(
                      //       colors: [
                      //         kdarkGreen,
                      //         kdarkMediumGreen,
                      //         kmediumGreen,
                      //         kmediumlightGreen,
                      //         klightGreen,
                      //       ],
                      //     ),
                      //   ),
                      //   thumbDecoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(40),
                      //       color: Colors.white),
                      //   isStretch: true,
                      //   //fixedWidth: double.infinity,
                      //   padding: 0,
                      //   innerPadding: 4,
                      //   //duration: Duration(milliseconds: 200),
                      //   //highlightColor: Colors.black,
                      //   //height: 60,
                      //   //padding: 0,

                      //   // backgroundColor: Colors.transparent,
                      //   // padding: EdgeInsets.all(4),
                      //   // groupValue: currentIndex,
                      //   children: {
                      //     0: buildSegment('Login'),
                      //     1: buildSegment('New User'),
                      //   },
                      //   onValueChanged: (groupValue) {
                      //     setState(() {
                      //       currentIndex = groupValue as int;
                      //     });
                      //   },
                      // )
                      LayoutBuilder(
                    builder: (context, constraint) {
                      double gap = 1 / 6 / 2 * constraint.maxHeight;
                      double toRight =
                          constraint.maxWidth - (0.5 * constraint.maxWidth);
                      return Stack(
                        children: [
                          AnimatedPositioned(
                            duration: Duration(milliseconds: 500),
                            left: togglePlaces ? gap : toRight,
                            top: gap,
                            child: Container(
                              alignment: Alignment.center,
                              height: 5 / 6 * constraint.maxHeight,
                              width: (0.5 * constraint.maxWidth) - gap,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Positioned(
                            left: gap,
                            top: gap,
                            child: InkWell(
                              child: Container(
                                alignment: Alignment.center,
                                height: 5 / 6 * constraint.maxHeight,
                                width: (0.5 * constraint.maxWidth) - gap,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 19,
                                    color: animatedpos == 0
                                        ? animationEnd
                                            ? togglePlaces
                                                ? Colors.black
                                                : Colors.white
                                            : Colors.black
                                        : animationEnd
                                            ? togglePlaces
                                                ? Colors.black
                                                : Colors.white
                                            : Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              onTap: () async {
                                pagecon.animateToPage(0,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.linear);
                                setState(() {
                                  animationEnd = false;
                                  if (!togglePlaces) {
                                    togglePlaces = !togglePlaces;
                                  }
                                });
                                await Future.delayed(
                                    Duration(milliseconds: 250));
                                setState(() {
                                  animationEnd = true;
                                  animatedpos = 0;
                                });
                              },
                            ),
                          ),
                          Positioned(
                            right: gap,
                            top: gap,
                            child: InkWell(
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 5 / 6 * constraint.maxHeight,
                                  width: (0.5 * constraint.maxWidth) - gap,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Text(
                                    'New User',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 19,
                                        color: animatedpos == 0
                                            ? animationEnd
                                                ? togglePlaces
                                                    ? Colors.white
                                                    : Colors.black
                                                : Colors.white
                                            : animationEnd
                                                ? togglePlaces
                                                    ? Colors.white
                                                    : Colors.black
                                                : Colors.black,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  )),
                              onTap: () async {
                                pagecon.animateToPage(1,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.linear);
                                setState(() {
                                  if (togglePlaces) {
                                    togglePlaces = !togglePlaces;
                                  }
                                  animationEnd = false;
                                });
                                await Future.delayed(
                                    Duration(milliseconds: 250));
                                setState(() {
                                  animationEnd = true;
                                  animatedpos = 1;
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Container(
                width: size.width,
                height: 563 + 80 + (0.015 * size.height),
                child:
                    //Form(
                    // key: _formkey,
                    // child:
                    PageView(
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  controller: pagecon,
                  children: [
                    LoginPage(),
                    RegisterPage(),
                    //loginInputDesign(size),
                    //registerInputDesign(size),
                  ],
                ),
              ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSegment(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 19,
        //color:
      ),
    );
  }

  // Widget loginInputDesign(Size size) {
  //   return Column(
  //     //mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.fromLTRB(((size.width - (size.width * 0.77)) / 2),
  //             0.015 * size.height, ((size.width - (size.width * 0.77)) / 2), 0),
  //         child: Stack(
  //           children: [
  //             Container(
  //               height: 262,
  //               child: Card(
  //                 margin: EdgeInsets.only(bottom: 48),
  //                 elevation: 3,
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(10),
  //                 ),
  //                 child: Padding(
  //                   padding: EdgeInsets.fromLTRB(28, 38, 28, 0),
  //                   child: LayoutBuilder(
  //                     builder: (context, constraint) {
  //                       //print(constraint.maxWidth);
  //                       return Column(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         //crossAxisAlignment: CrossAxisAlignment.stretch,
  //                         mainAxisSize: MainAxisSize.min,
  //                         children: [
  //                           inputDesign(constraint, 'Username/e-mail',
  //                               loginEmailcon, 'assets/icons/nameIcon.png'),
  //                           Padding(
  //                             padding: EdgeInsets.fromLTRB(0, 38, 0, 38),
  //                             child: Divider(
  //                               color: kgreycolor1,
  //                               thickness: 1.5,
  //                               height: 0,
  //                             ),
  //                           ),
  //                           inputDesign(constraint, 'Password', loginpasscon,
  //                               'assets/icons/passwordIcon.png'),
  //                         ],
  //                       );
  //                     },
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Positioned.fill(
  //               child: Align(
  //                 alignment: Alignment.bottomCenter,
  //                 child: InkWell(
  //                   child: Container(
  //                     alignment: Alignment.center,
  //                     height: 60,
  //                     width: 0.5 * size.width,
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
  //                       'Login',
  //                       style: TextStyle(
  //                         fontFamily: 'Roboto',
  //                         fontSize: 29,
  //                         color: const Color(0xffffffff),
  //                       ),
  //                       textAlign: TextAlign.left,
  //                     ),
  //                   ),
  //                   onTap: () async {
  //                     print("login");
  //                     if (_formkey.currentState!.validate()) {
  //                       if (loginFormValidation()) {
  //                         setState(() => loading = true);
  //                         dynamic result = await AuthService()
  //                             .signInWithEmailAndPassword(
  //                                 loginEmailcon.text, loginpasscon.text);
  //                         //setState(() => loading = false);
  //                         if (result == null) {
  //                           ScaffoldMessenger.of(context).showSnackBar(
  //                               SnackBar(content: Text('No User found')));
  //                           setState(() => loading = false);
  //                         }
  //                         //Navigator.of(context).pushReplacementNamed('/home');
  //                       }
  //                     }
  //                   },
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //       Expanded(
  //         child: Padding(
  //           padding: EdgeInsets.only(top: 30),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Container(
  //                     height: 48,
  //                     alignment: Alignment.centerLeft,
  //                     child: Text(
  //                       'Remember Me',
  //                       style: TextStyle(
  //                         fontFamily: 'Roboto',
  //                         fontSize: 19,
  //                         color: const Color(0xff131450),
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                       textAlign: TextAlign.left,
  //                     ),
  //                   ),
  //                   Switch(
  //                     value: valSwitch,
  //                     activeColor: Color(0xff2AD53A),
  //                     activeTrackColor: Color(0xffADF3C4),
  //                     splashRadius: 20,
  //                     onChanged: (val) {
  //                       print(val);
  //                       setState(() {
  //                         valSwitch = val;
  //                       });
  //                     },
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: 30,
  //               ),
  //               // officerLoginLink(),
  //               // SizedBox(
  //               //   height: 13,
  //               // ),
  //               // adminLoginLink(),
  //               Center(
  //                 child: loading ? CircularProgressIndicator() : SizedBox(),
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Row adminLoginLink() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Text(
  //         'Administrator? ',
  //         style: TextStyle(
  //           fontFamily: 'Roboto',
  //           fontSize: 19,
  //           color: const Color(0xff000000),
  //         ),
  //         textAlign: TextAlign.left,
  //       ),
  //       InkWell(
  //         child: Text(
  //           'Click Here',
  //           style: TextStyle(
  //             fontFamily: 'Roboto',
  //             fontSize: 19,
  //             color: const Color(0xff1F8FEB),
  //             fontWeight: FontWeight.w700,
  //             decoration: TextDecoration.underline,
  //           ),
  //           textAlign: TextAlign.left,
  //         ),
  //         onTap: () {
  //           //Navigator.of(context).pushNamed('/loginadmin');
  //           //Navigator.of(context).pushReplacementNamed('/loginadmin');
  //           Navigator.pushReplacementNamed(
  //             context,
  //             '/loginadmin',
  //           );
  //           print("administrator");
  //         },
  //       ),
  //     ],
  //   );
  // }

  // Row officerLoginLink() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Text(
  //         'Officer? ',
  //         style: TextStyle(
  //           fontFamily: 'Roboto',
  //           fontSize: 19,
  //           color: const Color(0xff000000),
  //         ),
  //         textAlign: TextAlign.left,
  //       ),
  //       InkWell(
  //         child: Text(
  //           'Click Here',
  //           style: TextStyle(
  //             fontFamily: 'Roboto',
  //             fontSize: 19,
  //             color: const Color(0xff1F8FEB),
  //             fontWeight: FontWeight.w700,
  //             decoration: TextDecoration.underline,
  //           ),
  //           textAlign: TextAlign.left,
  //         ),
  //         onTap: () {
  //           //Navigator.of(context).pushNamed('/loginofficer');
  //           Navigator.of(context).pushReplacementNamed('/loginofficer');
  //           print("login as officer");
  //         },
  //       ),
  //     ],
  //   );
  // }

  // Widget registerInputDesign(Size size) {
  //   return Padding(
  //     padding: EdgeInsets.fromLTRB(((size.width - (size.width * 0.77)) / 2),
  //         0.015 * size.height, ((size.width - (size.width * 0.77)) / 2), 80),
  //     child: Column(
  //       children: [
  //         Container(
  //           //height: 563.h,
  //           child: Card(
  //             margin: EdgeInsets.only(bottom: 48.h),
  //             elevation: 3,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(10.r),
  //             ),
  //             child: Padding(
  //               padding: EdgeInsets.fromLTRB(28.w, 20.h, 28.w, 0),
  //               child: LayoutBuilder(
  //                 builder: (context, constraint) {
  //                   //print(constraint.maxWidth);
  //                   return Column(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     //crossAxisAlignment: CrossAxisAlignment.stretch,
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       // inputDesign(constraint, 'Username', usernamecon,
  //                       //     'assets/icons/usernameIcon.png'),
  //                       // Padding(
  //                       //   padding: EdgeInsets.fromLTRB(0, 17.h, 0, 18.h),
  //                       //   child: Divider(
  //                       //     color: kgreycolor1,
  //                       //     thickness: 1.5,
  //                       //     height: 0,
  //                       //   ),
  //                       // ),
  //                       // inputDesign(constraint, 'Name', namecon,
  //                       //     'assets/icons/nameIcon.png'),
  //                       // Padding(
  //                       //   padding: EdgeInsets.fromLTRB(0, 17.h, 0, 18.h),
  //                       //   child: Divider(
  //                       //     color: kgreycolor1,
  //                       //     thickness: 1.5,
  //                       //     height: 0,
  //                       //   ),
  //                       // ),

  //                       inputDesign(constraint, 'E-mail Address', emailcon,
  //                           'assets/icons/emailIcon.png'),
  //                       Padding(
  //                         padding: EdgeInsets.fromLTRB(0, 17, 0, 18),
  //                         child: Divider(
  //                           color: kgreycolor1,
  //                           thickness: 1.5,
  //                           height: 0,
  //                         ),
  //                       ),
  //                       inputDesign(constraint, 'Password', passcon,
  //                           'assets/icons/passwordIcon.png'),
  //                       Padding(
  //                         padding: EdgeInsets.fromLTRB(0, 17, 0, 18),
  //                         child: Divider(
  //                           color: kgreycolor1,
  //                           thickness: 1.5,
  //                           height: 0,
  //                         ),
  //                       ),
  //                       inputDesign(constraint, 'Password Confirmation',
  //                           confirmpasscon, 'assets/icons/passwordIcon.png'),
  //                       Padding(
  //                         padding: EdgeInsets.fromLTRB(0, 17, 0, 18),
  //                         child: Divider(
  //                           color: kgreycolor1,
  //                           thickness: 1.5,
  //                           height: 0,
  //                         ),
  //                       ),
  //                       inputDesign(constraint, 'Phone Number', phoneNumcon,
  //                           'assets/icons/phoneNumberIcon.png'),
  //                       Padding(
  //                         padding: EdgeInsets.fromLTRB(0, 17, 0, 18),
  //                         child: Divider(
  //                           color: kgreycolor1,
  //                           thickness: 1.5,
  //                           height: 0,
  //                         ),
  //                       ),
  //                       // inputDesign(constraint, 'IC Number', icNumcon,
  //                       //     'assets/icons/icNumberIcon.png'),
  //                       // Padding(
  //                       //   padding: EdgeInsets.fromLTRB(0, 17, 0, 18),
  //                       //   child: Divider(
  //                       //     color: kgreycolor1,
  //                       //     thickness: 1.5,
  //                       //     height: 0,
  //                       //   ),
  //                       // ),
  //                       // inputDesign(constraint, 'Date of Birth', dateOfBirthcon,
  //                       //     'assets/icons/birthDateIcon.png'),
  //                     ],
  //                   );
  //                 },
  //               ),
  //             ),
  //           ),
  //         ),
  //         Align(
  //           alignment: Alignment.bottomCenter,
  //           child: InkWell(
  //             child: Container(
  //               alignment: Alignment.center,
  //               height: 60,
  //               width: 0.5 * size.width,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(6),
  //                 gradient: LinearGradient(
  //                   colors: [
  //                     Color(0xff50A356),
  //                     Color(0xff40B74B),
  //                     Color(0xff2CD23C),
  //                     Color(0xff1EE332),
  //                     Color(0xff0BFD24),
  //                   ],
  //                 ),
  //               ),
  //               child: Text(
  //                 'Sign Up',
  //                 style: TextStyle(
  //                   fontFamily: 'Roboto',
  //                   fontSize: 29,
  //                   color: const Color(0xffffffff),
  //                 ),
  //                 textAlign: TextAlign.left,
  //               ),
  //             ),
  //             onTap: registerUser,
  //           ),
  //         ),
  //         Align(
  //           alignment: Alignment.center,
  //           child: loading ? CircularProgressIndicator() : SizedBox(),
  //         )
  //       ],
  //     ),
  //   );
  // }

  void registerUser() async {
    print("register");
    if (_formkey.currentState!.validate()) {
      if (registerFormValidation()) {
        setState(() => loading = true);
        print("start firebase");
        print(emailcon.text);
        print(passcon.text);
        dynamic result = await _auth.registerWithEmailAndPassword(
          emailcon.text,
          passcon.text,
          usernamecon.text,
          namecon.text,
          phoneNumcon.text,
          icNumcon.text,
          _date,
          false,
          false,
        );
        if (result == null) {
          setState(() => error = "please supply a valid email");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$error')),
          );
          setState(() => loading = false);
        } else if (result == 'emailUsed') {
          setState(() => error = "Email is already in used");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$error')),
          );
          setState(() => loading = false);
        } else if (result == 'passwordweak') {
          setState(() => error = "Password is to weak");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$error')),
          );
          setState(() => loading = false);
        }
        print(error);
      }
    }
  }

  bool registerFormValidation() {
    // if (usernamecon.text.isEmpty) {
    //   createAlertDialog(context, "Username");
    //   return false;
    // }
    // if (namecon.text.isEmpty) {
    //   createAlertDialog(context, "name");
    //   return false;
    // }
    if (phoneNumcon.text.isEmpty) {
      createAlertDialog(context, "Phone number");
      return false;
    }
    if (emailcon.text.isEmpty) {
      createAlertDialog(context, "E-mail adrress");
      return false;
    }
    if (passcon.text.isEmpty) {
      createAlertDialog(context, "Password");
      return false;
    }
    if (confirmpasscon.text.isEmpty) {
      createAlertDialog(context, "Password Confirmation");
      return false;
    }
    // if (icNumcon.text.isEmpty) {
    //   createAlertDialog(context, "IC number");
    //   return false;
    // }
    // if (dateOfBirthcon.text.isEmpty) {
    //   createAlertDialog(context, "Date of birth");
    //   return false;
    // }
    if (passcon.text.length < 6) {
      createAlertDialog(context, "Password more than 6 character");
      return false;
    }
    if (passcon.text != confirmpasscon.text) {
      createAlertDialog(context, "Matched password");
      return false;
    }
    return true;
  }

  bool loginFormValidation() {
    if (loginEmailcon.text.isEmpty) {
      createAlertDialog(context, "Username/email");
      return false;
    }
    if (loginpasscon.text.isEmpty) {
      createAlertDialog(context, "Password");
      return false;
    }
    return true;
  }

  Row inputDesign(BoxConstraints constraint, String hintText,
      TextEditingController controller, String assetImage) {
    //print(constraint.maxWidth);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          assetImage,
          height: 26,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Container(
            height: 26,
            alignment: Alignment.center,
            width:
                (hintText == 'Password' || hintText == 'Password Confirmation')
                    ? constraint.maxWidth - 20 - 52
                    : constraint.maxWidth - 20 - 26,
            child: TextFormField(
              // onTap: () {
              //   if (hintText == "Date of Birth") {
              //     _selectDate(context);
              //   }
              // },

              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 22,
                color: Colors.black,
              ),
              readOnly: hintText == "Date of Birth" ? true : false,
              //focusNode: ,
              textAlignVertical: TextAlignVertical.center,
              controller: controller,
              keyboardType: hintText == "Phone Number"
                  ? TextInputType.phone
                  : hintText == "E-mail Address"
                      ? TextInputType.emailAddress
                      : hintText == "Date of Birth"
                          ? TextInputType.datetime
                          : TextInputType.text,
              //textAlign: TextAlign.center,
              //style: ,
              obscureText: (hintText == 'Password')
                  ? isHidden1
                  : hintText == 'Password Confirmation'
                      ? isHidden2
                      : false,
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: EdgeInsets.all(0),
                isDense: true,
                hintStyle: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 22,
                  color: const Color(0xffa8a8a8),
                ),
                border: InputBorder.none,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  //BorderSide(width: 1, color: Color(0xff707070)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  //BorderSide(width: 1, color: Color(0xff707070)),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  //BorderSide(width: 1, color: Color(0xff707070)),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  //BorderSide(width: 1, color: Color(0xff707070)),
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  //BorderSide(width: 1, color: Color(0xff707070)),
                ),
              ),
            ),
          ),
        ),
        hintText == "Password"
            ? SizedBox(
                width: 26,
                height: 26,
                child: IconButton(
                  iconSize: 26,
                  onPressed: () {
                    setState(() {
                      isHidden1 = !isHidden1;
                    });
                  },
                  icon: Icon(
                    isHidden1 ? Icons.visibility : Icons.visibility_off,
                    size: 26,
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(0),
                  splashRadius: 20,
                ),
              )
            : hintText == "Password Confirmation"
                ? SizedBox(
                    width: 26,
                    height: 26,
                    child: IconButton(
                      iconSize: 26,
                      onPressed: () {
                        setState(() {
                          isHidden2 = !isHidden2;
                        });
                      },
                      icon: Icon(
                        isHidden2 ? Icons.visibility : Icons.visibility_off,
                        size: 26,
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(0),
                      splashRadius: 20,
                    ),
                  )
                : SizedBox(
                    width: 0,
                    height: 0,
                  )
      ],
    );
  }
}
