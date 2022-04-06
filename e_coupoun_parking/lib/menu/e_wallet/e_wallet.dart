import '../../constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Ewallet extends StatefulWidget {
  Map? argument = {};
  Ewallet({Key? key, this.argument}) : super(key: key);
  @override
  State<Ewallet> createState() => _EwalletState();
}

class _EwalletState extends State<Ewallet> {
  String hightlightText = '0';
  TextEditingController amountcon = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: eWalletAppbarDesign(),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: bgColor,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Hello User!',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20.sp,
                        color: const Color(0xff1e2022),
                        letterSpacing: 1,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Container(
                    height: 220.h,
                    width: 314.w,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 200.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 2.w),
                                    child: Text(
                                      'RM',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 28.sp,
                                        color: const Color(0xff8392a7),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Text(
                                    '23.00',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 72.sp,
                                      color: const Color(0xff16aa32),
                                    ),
                                    textAlign: TextAlign.left,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 6,
                              primary: Color(0xff16AA32),
                              minimumSize: Size(142.w, 62.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(44.r),
                              ),
                            ),
                            onPressed: () {
                              showBottomPopup(context, "wallet")
                                  .whenComplete(() {
                                setState(() {
                                  hightlightText = '0';
                                });
                                return print(hightlightText);
                              });
                            },
                            child: Text(
                              'TOP UP',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 19.sp,
                                color: const Color(0xffffffff),
                                letterSpacing: 1.3571428985595704,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buttonWalletDesign(
                          context, 'Scan', 'assets/icons/BarcodeScanIcon.png'),
                      buttonWalletDesign(
                          context, 'Transfer', 'assets/icons/transferIcon.png'),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buttonWalletDesign(
                          context, 'Reload', 'assets/icons/reloadIcon.png'),
                      buttonWalletDesign(context, 'Debit Card',
                          'assets/icons/debitCardIcon.png'),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonWalletDesign(
      BuildContext context, String title, String assetPath) {
    return InkWell(
      child: Container(
        height: 110.h,
        width: 175.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              offset: Offset(0, 0.5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(assetPath),
            SizedBox(height: 10.h),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Montserrat-Regular',
                fontSize: 13.sp,
                color: const Color(0xff8392a7),
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      onTap: () {
        if (title == 'Reload') {
          showBottomPopup(context, 'Wallet').whenComplete(() {
            setState(() {
              hightlightText = '0';
            });
            return print(hightlightText);
          });
        } else {
          print('tbd');
        }
      },
    );
  }

  Future<dynamic> showBottomPopup(BuildContext context, String title) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
        ),
        isScrollControlled: true,
        //isDismissible: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setModalState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 35.h, 20.w, 30.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Payment Via',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 19.sp,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 19.sp,
                        color: const Color(0xff35c642),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 25.h),
                    Text(
                      'One-Time Top Up',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 19.sp,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        btnAmountDesign('5', setModalState),
                        btnAmountDesign('10', setModalState),
                        btnAmountDesign('20', setModalState)
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        btnAmountDesign('50', setModalState),
                        btnAmountDesign('100', setModalState),
                        btnAmountDesign('200', setModalState)
                      ],
                    ),
                    SizedBox(height: 35.h),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'RM',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 28.sp,
                            color: const Color(0xff0c7516),
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Form(
                            child: TextFormField(
                              controller: amountcon,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 28.sp,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Input Top-pup Amount',
                                contentPadding: EdgeInsets.all(0),
                                isDense: true,
                                hintStyle: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 28.sp,
                                  color: const Color(0xffc8c8c8),
                                ),
                                border: InputBorder.none,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 35.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          primary: Color(0xff16AA32),
                          fixedSize:
                              Size(MediaQuery.of(context).size.width, 60.h)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Pay Now',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 19.sp,
                          color: const Color(0xffffffff),
                          letterSpacing: 1.3571428985595704,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  Widget btnAmountDesign(String amount, StateSetter setModalState) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        width: 120.w,
        height: 60.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xff35C642),
            width: hightlightText == amount ? 3 : 1,
          ),
        ),
        child: Text(
          amount,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 25.sp,
            color: const Color(0xff000000),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      onTap: () {
        print(amount);
        setModalState(() {
          amountcon.text = amount;
          hightlightText = amount;
        });
        print(hightlightText);
      },
    );
  }

  AppBar eWalletAppbarDesign() {
    return AppBar(
      title: Text(
        'Reload',
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
            //print('clicked');
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
