import 'package:flutter/material.dart';

class RegisterCarInput extends StatefulWidget {
  //const RegisterCarInput({ Key? key }) : super(key: key);

  @override
  State<RegisterCarInput> createState() => _RegisterCarInputState();
}

class _RegisterCarInputState extends State<RegisterCarInput> {
  // dummy data start
  bool conditionRegister = false;
  // dummy data end
  TextEditingController carBrandcon = new TextEditingController();

  TextEditingController carTypecon = new TextEditingController();

  TextEditingController carPlateNumcon = new TextEditingController();

  TextEditingController carYrManufactcon = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  var ownerTypeList = ['Personal', 'Others'];

  var _currentItemSelected = "Personal";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: registerCarInputAppbarDesign(),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              color: Color(0xffE1F9E0),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      textFormInputDesign('Car Brand', carBrandcon),
                      SizedBox(height: 23),
                      textFormInputDesign('Car Type', carTypecon),
                      SizedBox(height: 23),
                      textFormInputDesign('Car Plate Number', carPlateNumcon),
                      SizedBox(height: 23),
                      Text(
                        ' Car Owner Type :',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 16),
                      dropDownDesign(),
                      SizedBox(height: 23),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xff16AA10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                fixedSize: Size(190, 70)),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Car Registered Successfully'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Save',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 25,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xffffffff),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                fixedSize: Size(190, 70)),
                            onPressed: () {
                              carBrandcon.text = '';
                              carPlateNumcon.text = '';
                              carTypecon.text = '';
                            },
                            child: Text(
                              'Clear',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 25,
                                color: const Color(0xffBEBEBE),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 50),
                      Center(
                          child: conditionRegister
                              ? CircularProgressIndicator()
                              : SizedBox())
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container dropDownDesign() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 2),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: DropdownButton(
              onChanged: (String? newValueSelected) {
                onDropDownItemSelected(newValueSelected!);
              },
              value: _currentItemSelected,
              underline: SizedBox(),
              isExpanded: true,
              items: ownerTypeList.map((String item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList()),
        ),
      ),
    );
  }

  Container textFormInputDesign(
      String hintText, TextEditingController controller) {
    return Container(
      alignment: Alignment.center,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 2),
        ],
      ),
      child: TextFormField(
        validator: (val) {
          if (val!.isEmpty) {
            return "field cannot be empty";
          }
        },
        //autocorrect: true,
        textCapitalization: TextCapitalization.characters,
        controller: controller,
        style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16,
            color: Colors.black,
            decoration: TextDecoration.none),
        decoration: InputDecoration(
          filled: true,
          contentPadding: EdgeInsets.all(27),
          hintStyle: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16,
            color: const Color(0xffa8a8a8),
          ),
          hintText: hintText,
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
    );
  }

  AppBar registerCarInputAppbarDesign() {
    return AppBar(
      title: Text(
        'Register New Car',
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
            print('clicked');
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

  void onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }
}
