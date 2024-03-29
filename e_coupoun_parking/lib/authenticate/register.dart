import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant.dart';
import '../services/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isHidden2 = true;
  bool isHidden1 = true;
  bool loading = false;

  String //username = "",
      //name = "",
      phoneNum = "",
      email = "",
      pass = "",
      confirmPass = "",
      //icNum = "",
      //dateOfBirth = "",
      error = "error";

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

  final _formkey = GlobalKey<FormState>();
  final AuthService _auth = new AuthService();
  DateTime? _date;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(50.w, 18.h, 50.w, 44.h),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(28.w, 38.h, 28.w, 52.h),
                  child: LayoutBuilder(builder: (context, constraint) {
                    return Form(
                      key: _formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          inputDesign(constraint, 'E-mail Address', emailcon,
                              'assets/icons/emailIcon.png'),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 17.h, 0, 18.h),
                            child: Divider(
                              color: kgreycolor1,
                              thickness: 1.5,
                              height: 0,
                            ),
                          ),
                          inputDesign(constraint, 'Password', passcon,
                              'assets/icons/passwordIcon.png'),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 17.h, 0, 18.h),
                            child: Divider(
                              color: kgreycolor1,
                              thickness: 1.5,
                              height: 0,
                            ),
                          ),
                          inputDesign(constraint, 'Password Confirmation',
                              confirmpasscon, 'assets/icons/passwordIcon.png'),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 17, 0, 18),
                            child: Divider(
                              color: kgreycolor1,
                              thickness: 1.5,
                              height: 0,
                            ),
                          ),
                          inputDesign(constraint, 'Phone Number', phoneNumcon,
                              'assets/icons/phoneNumberIcon.png'),
                          // Padding(
                          //   padding: EdgeInsets.only(top: 17.h),
                          //   child: Divider(
                          //     color: kgreycolor1,
                          //     thickness: 1.5,
                          //     height: 0,
                          //   ),
                          // ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      height: 60.h,
                      width: 210.w, //0.5 * size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff54A059),
                            Color(0xff40B74B),
                            Color(0xff2CD23C),
                            Color(0xff1EE332),
                            Color(0xff0BFD24),
                          ],
                        ),
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 29,
                          color: const Color(0xffffffff),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    onTap: registerUser),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void registerUser() async {
    //print("register");
    if (_formkey.currentState!.validate()) {
      if (registerFormValidation()) {
        setState(() => loading = true);
        // print("start firebase");
        // print(emailcon.text);
        // print(passcon.text);
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

  bool registerFormValidation() {
    // if (usernamecon.text.isEmpty) {
    //   createAlertDialog(context, "Username");
    //   return false;
    // }
    // if (namecon.text.isEmpty) {
    //   createAlertDialog(context, "name");
    //   return false;
    // }å
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
    if (phoneNumcon.text.isEmpty) {
      createAlertDialog(context, "Phone number");
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
}
