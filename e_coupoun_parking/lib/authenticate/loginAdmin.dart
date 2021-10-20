import 'package:e_coupoun_parking/constant.dart';
import 'package:flutter/material.dart';

class LoginAdminPage extends StatefulWidget {
  const LoginAdminPage({Key? key}) : super(key: key);

  @override
  _LoginAdminPageState createState() => _LoginAdminPageState();
}

class _LoginAdminPageState extends State<LoginAdminPage> {
  bool isHidden = true;
  double gap = 140;

  final usernameadmincon = new TextEditingController();
  final passwordadmincon = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color(0xff0D7919),
      //Color(0xff0E9D1D),
      //Color(0xff0FBA20),
      //Color(0xff10DA24),
      Color(0xff11E726),
      //Color(0xff1BE732),
      //Color(0xff33E84D),
      //Color(0xff53EA73),
      Color(0xff78EC9D),
    ],
  ).createShader(Rect.fromLTWH(80.0, 0.0, 270.0, 60.0));

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 0.05 * size.height),
                  child: Image.asset(
                    'assets/icons/mpsp-sungaiPetani.png',
                    height: 185,
                  ),
                ),
                SizedBox(
                  height: 0.025 * size.height,
                ),
                Text(
                  'Admin Login',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 45,
                    //color: const Color(0xffffffff),
                    fontWeight: FontWeight.w700,
                    foreground: Paint()..shader = linearGradient,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 0.036 * size.height,
                ),
                Container(
                  height: gap,
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          //height: 90,
                          width: 0.356 * size.height,
                          //color: Colors.grey,
                          child: inputDesignLogin(usernameadmincon,
                              "Admin Username", 'assets/icons/adminIcon.png'),
                        ),
                        Container(
                          //height: 90,
                          width: 0.356 * size.height,
                          //color: Colors.grey,
                          child: inputDesignLogin(passwordadmincon, "Password",
                              'assets/icons/passwordIcon.png'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.03 * size.height,
                ),
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: 0.5 * size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff50A356),
                          Color(0xff40B74B),
                          Color(0xff2CD23C),
                          Color(0xff1EE332),
                          Color(0xff0BFD24),
                        ],
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 29,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  onTap: () async {
                    print("login");
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        gap = 140;
                      });
                      print('validated');
                    } else {
                      setState(() {
                        gap = 180;
                      });
                    }

                    // if (_formkey.currentState!.validate()) {
                    //   // ScaffoldMessenger.of(context).showSnackBar(
                    //   //   const SnackBar(content: Text('Processing Data')),
                    //   // );
                    //   setState(() => loading = true);
                    //   // dynamic result = await _auth.registerWithEmailAndPassword(
                    //   //     email, password, name, mobileNo);
                    //   // if (result == null) {
                    //   //   setState(() {
                    //   //     error = "Please supply a valid email";
                    //   //     loading = false;
                    //   //   });
                    //   // }
                    // }
                  },
                ),
                SizedBox(
                  height: 0.043 * size.height,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'User? ',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 19,
                        color: const Color(0xff000000),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    InkWell(
                      child: Text(
                        'Click Here',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 19,
                          color: const Color(0xff1F8FEB),
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/');
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 13,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Officer? ',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 19,
                        color: const Color(0xff000000),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    InkWell(
                      child: Text(
                        'Click Here',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 19,
                          color: const Color(0xff1F8FEB),
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/loginofficer');
                        //Navigator.of(context).pushReplacementNamed('/loginadmin');
                        print("officer");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputDesignLogin(
      TextEditingController controller, String hintText, String imageasset) {
    return TextFormField(
      controller: controller,
      obscureText: hintText == "Password" ? isHidden : false,
      validator: (val) {
        if (val!.isEmpty) {
          return "field cannot be empty";
        }
      },
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Image.asset(
            imageasset,
            height: 26,
            width: 26,
          ),
        ),
        prefixIconConstraints: BoxConstraints(maxHeight: 26, minHeight: 26),
        suffixIcon: hintText == "Password"
            ? Padding(
                padding: EdgeInsets.only(right: 5),
                child: IconButton(
                  icon: Icon(
                    isHidden ? Icons.visibility : Icons.visibility_off,
                    size: 26,
                    color: Colors.black,
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(0),
                  splashRadius: 20,
                  onPressed: () {
                    setState(() {
                      isHidden = !isHidden;
                    });
                  },
                ),
              )
            : SizedBox(
                height: 20,
                width: 20,
              ),
        contentPadding: EdgeInsets.symmetric(vertical: 22, horizontal: 0),
        hintStyle: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 19,
          color: const Color(0xffa8a8a8),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 0.2, color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 0.2, color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 0.2, color: Colors.black),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 0.2, color: Colors.red),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 0.2, color: Colors.black),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 0.2, color: Colors.red),
        ),
      ),
    );
  }
}
