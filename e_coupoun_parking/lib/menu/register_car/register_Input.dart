import 'dart:math';

import '../../constant.dart';
import 'car_type_chip.dart';
import '../../models/car.dart';
import '../../models/choiceChipSelection.dart';
import '../../models/driver.dart';
import '../../models/driveruid.dart';
import '../../services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RegisterCarInput extends StatefulWidget {
  Map? argument = {};
  RegisterCarInput({Key? key, this.argument}) : super(key: key);

  @override
  State<RegisterCarInput> createState() => _RegisterCarInputState();
}

class _RegisterCarInputState extends State<RegisterCarInput> {
  // dummy data start
  bool conditionRegister = false;
  bool loading = false;
  // dummy data end

  TextEditingController carNamecon = new TextEditingController();
  TextEditingController carBrandcon = new TextEditingController();
  TextEditingController carTypecon = new TextEditingController();
  TextEditingController carPlateNumcon = new TextEditingController();
  TextEditingController carYrManufactcon = new TextEditingController();

  final _formkey = GlobalKey<FormState>();
  String chipselected = '4Wheels';
  var isSelected = false;

  late List<ChoiceChipData> choiceChips = ChoiceChips().all;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // carNamecon = widget.argument!["carName"] != null
    //     ? new TextEditingController(text: widget.argument!["carName"])
    //     : new TextEditingController();
    carBrandcon = widget.argument!["carBrand"] != null
        ? new TextEditingController(text: widget.argument!["carBrand"])
        : new TextEditingController();

    if (widget.argument!["carType"] != null) {
      String carTypeInitial = widget.argument!["carType"];
      chipselected = carTypeInitial;
      final chipInit =
          choiceChips.firstWhere((element) => element.label == carTypeInitial);
      choiceChips = ChoiceChips().geteditedList(chipselected);
      //print(choiceChips);
    }
    // carTypecon = widget.argument!["carType"] != null
    //     ? new TextEditingController(text: widget.argument!["carType"])
    //     : new TextEditingController();
    carPlateNumcon = widget.argument!["carPlateNum"] != null
        ? new TextEditingController(text: widget.argument!["carPlateNum"])
        : new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final driveruid = Provider.of<Driveruid?>(context);
    final driverinfo = widget.argument!['driverInfo'];
    return Scaffold(
      appBar: registerCarInputAppbarDesign(widget.argument!['appbarTitle']),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            color: Color(0xffE1F9E0),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    widget.argument!["appbarTitle"] == 'Edit Car'
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: Text(
                              ' Car Plate Number :',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          )
                        : SizedBox(),
                    textFormInputDesign('Car Plate Number', carPlateNumcon),

                    SizedBox(height: 23.h),
                    widget.argument!["appbarTitle"] == 'Edit Car'
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: Text(
                              ' Car Name :',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          )
                        : SizedBox(),
                    textFormInputDesign('Car Brand', carBrandcon),
                    SizedBox(height: 23.h),
                    // widget.argument!["appbarTitle"] == 'Edit Car'
                    //     ?
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: Text(
                        ' Car Type :',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    buildChoiceChips(),
                    // SizedBox(height: 23),
                    // widget.argument!["appbarTitle"] == 'Edit Car'
                    //     ? Padding(
                    //         padding: EdgeInsets.only(bottom: 20),
                    //         child: Text(
                    //           ' Car Name:',
                    //           style: TextStyle(
                    //             fontFamily: 'Roboto',
                    //             fontSize: 16,
                    //             color: Colors.black,
                    //             fontWeight: FontWeight.w700,
                    //           ),
                    //           textAlign: TextAlign.left,
                    //         ),
                    //       )
                    //     : SizedBox(),
                    // textFormInputDesign('Car Name', carNamecon),
                    //SizedBox(height: 16),
                    SizedBox(
                      height: 23.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xff16AA10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              fixedSize: Size(190.w, 70.h)),
                          onPressed: () async {
                            await saveCar(driveruid, driverinfo, context);
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 25.sp,
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
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              fixedSize: Size(190.w, 70.h)),
                          onPressed: () async {
                            carBrandcon.text = '';
                            carPlateNumcon.text = '';
                            carTypecon.text = '';
                          },
                          child: Text(
                            'Clear',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 25.sp,
                              color: const Color(0xffBEBEBE),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 50.h),
                    Center(
                        child:
                            loading ? CircularProgressIndicator() : SizedBox())
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> saveCar(
      Driveruid? driveruid, driverinfo, BuildContext context) async {
    String carPlateNum = carPlateNumcon.text.trim().toUpperCase();
    if (
        //carNamecon.text.isNotEmpty &&
        carBrandcon.text.isNotEmpty &&
            //carTypecon.text.isNotEmpty &&
            carPlateNumcon.text.isNotEmpty) {
      setState(() => loading = true);
      bool carExistFromDriver = await FirebaseService(uid: driveruid!.uid)
          .checkCarExistFromDriver(carPlateNum);
      String appbarTitle = widget.argument!["appbarTitle"];
      //if car not exist in driver
      if (!carExistFromDriver || appbarTitle == "Edit Car") {
        bool carExistCollection =
            await FirebaseService().checkCarExistCollection(carPlateNum);
        //if car not exist in collection or status is editing
        if (!carExistCollection || appbarTitle == "Edit Car") {
          await FirebaseService().updateCarDataCollection(
              //carNamecon.text.trim().toUpperCase(),
              carBrandcon.text.trim().toUpperCase(),
              chipselected,
              //carTypecon.text.trim().toUpperCase(),
              carPlateNum);
          await FirebaseService(uid: driveruid.uid)
              .updateDriverDataInCarCollection(carPlateNum, driverinfo
                  // driverinfo.name,
                  // driverinfo.username,

                  // driverinfo.phoneNum!,
                  // driverinfo.icNum!,
                  // driverinfo.birthDate!,
                  );

          await FirebaseService(uid: driveruid.uid)
              .updateCarDataInDriverCollection(
                  //carNamecon.text.trim().toUpperCase(),
                  carBrandcon.text.trim().toUpperCase(),
                  chipselected,
                  //carTypecon.text.trim().toUpperCase(),
                  carPlateNum);
          // await FirebaseService(uid: driveruid.uid)
          //     .updateDriverPathInCarCollection(carPlateNum);
          // await FirebaseService(uid: driveruid.uid)
          //     .updateCarPathInDriverCollection(carPlateNum);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Car Registered Successfully'),
              duration: Duration(seconds: 3),
            ),
          );
          Navigator.of(context).pop();
        } else {
          await FirebaseService(uid: driveruid.uid)
              .updateCarDataInDriverCollection(
            //carNamecon.text.trim().toUpperCase(),
            carBrandcon.text.trim().toUpperCase(),
            chipselected,
            //carTypecon.text.trim().toUpperCase(),
            carPlateNum,
          );
          await FirebaseService(uid: driveruid.uid)
              .updateDriverDataInCarCollection(
                  carPlateNum,
                  // driverinfo.name,
                  // driverinfo.username,

                  // driverinfo.phoneNum!,
                  // driverinfo.icNum!,
                  // driverinfo.birthDate!,
                  driverinfo);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Car Registered Successfully'),
              duration: Duration(seconds: 3),
            ),
          );
          Navigator.of(context).pop();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Car Already Exist'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please input all the field'),
          duration: Duration(seconds: 3),
        ),
      );
    }
    setState(() => loading = false);
  }

  Container textFormInputDesign(
      String hintText, TextEditingController controller) {
    return Container(
      alignment: Alignment.center,
      height: 70.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 2),
        ],
        //border: Border.all(color: Colors.grey, width: 1),
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
        enabled: hintText == "Car Plate Number"
            ? widget.argument!['appbarTitle'] == 'Edit Car'
                ? false
                : true
            : true,

        style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16.sp,
            color: Colors.black,
            decoration: TextDecoration.none),
        decoration: InputDecoration(
          filled: widget.argument!['appbarTitle'] == 'Edit Car'
              ? hintText == "Car Plate Number"
                  ? true
                  : false
              : false,
          fillColor: Colors.grey[200],
          contentPadding:
              EdgeInsets.symmetric(vertical: 27.h, horizontal: 27.w),
          hintStyle: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16.sp,
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

  AppBar registerCarInputAppbarDesign(String titleAppbar) {
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
          iconSize: 35.w,
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

  ChoiceChip choiceChipDesign(String chipTitle) {
    Color textColor = Colors.black;
    return ChoiceChip(
      label: Text(
        chipTitle,
        textAlign: TextAlign.center,
      ),
      labelStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16.sp,
        color: textColor,
        fontWeight: FontWeight.normal,
      ),
      selected: isSelected,
      backgroundColor: Colors.white,
      elevation: 1,
      labelPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
        //side: BorderSide(color: Colors.grey, width: 1),
      ),
      onSelected: (selected) {
        setState(() {
          isSelected = selected;
        });
      },
      selectedColor: Color(0xff16AA10),
    );
  }

  Widget buildChoiceChips() => Wrap(
        runSpacing: 3,
        spacing: 10,
        children: choiceChips
            .map((choiceChip) => ChoiceChip(
                  label: Text(choiceChip.label),
                  labelStyle: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16.sp,
                    color: choiceChip.textColor,
                    fontWeight: FontWeight.normal,
                  ),
                  onSelected: (isSelected) => setState(() {
                    //print(choiceChip.label);
                    chipselected = choiceChip.label;
                    choiceChips = choiceChips.map((otherChip) {
                      final newChip = otherChip.copy(
                          isSelected: false, textColor: Colors.black);
                      return choiceChip == newChip
                          ? newChip.copy(
                              isSelected: isSelected, textColor: Colors.white)
                          : newChip;
                    }).toList();
                  }),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    //side: BorderSide(color: Colors.grey, width: 1),
                  ),
                  labelPadding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                  selected: choiceChip.isSelected,
                  selectedColor: choiceChip.selectedColor,
                  backgroundColor: Colors.white,
                ))
            .toList(),
      );
}

class ChipWidgetDesign extends StatefulWidget {
  final String chipTitle;
  ChipWidgetDesign({Key? key, required this.chipTitle}) : super(key: key);

  @override
  _ChipWidgetDesignState createState() => _ChipWidgetDesignState();
}

class _ChipWidgetDesignState extends State<ChipWidgetDesign> {
  var isSelected = false;
  Color textColor = Colors.black;
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        widget.chipTitle,
        textAlign: TextAlign.center,
      ),
      labelStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16.sp,
        color: textColor,
        fontWeight: FontWeight.normal,
      ),
      selected: isSelected,
      backgroundColor: Colors.white,
      elevation: 1,
      labelPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
        //side: BorderSide(color: Colors.grey, width: 1),
      ),
      onSelected: (selected) {
        setState(() {
          isSelected = selected;
          if (isSelected) {
            textColor = Colors.white;
          } else {
            textColor = Colors.black;
          }
        });
      },
      selectedColor: Color(0xff16AA10),
    );
  }
}
