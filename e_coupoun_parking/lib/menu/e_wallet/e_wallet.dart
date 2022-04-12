import 'package:e_coupoun_parking/models/driver.dart';
import 'package:e_coupoun_parking/models/driveruid.dart';
import 'package:e_coupoun_parking/models/transaction_history.dart';
import 'package:e_coupoun_parking/services/firebase_service.dart';
import 'package:provider/provider.dart';

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

  // List<TransactionHistory> transactionList = [
  //   TransactionHistory(
  //     amount: 0.6,
  //     date: DateTime.now(),
  //     isPaid: true,
  //   ),
  //   TransactionHistory(
  //     amount: 0.3,
  //     date: DateTime.now(),
  //     isPaid: true,
  //   ),
  //   TransactionHistory(
  //     amount: 1.2,
  //     date: DateTime.now(),
  //     isPaid: true,
  //   ),
  //   TransactionHistory(
  //     amount: 0.6,
  //     date: DateTime.now(),
  //     isPaid: true,
  //   ),
  //   TransactionHistory(
  //     amount: 1.2,
  //     date: DateTime.now(),
  //     isPaid: true,
  //   ),
  //   TransactionHistory(
  //     amount: 0.9,
  //     date: DateTime.now(),
  //     isPaid: true,
  //   ),
  //   TransactionHistory(
  //     amount: 1.5,
  //     date: DateTime.now(),
  //     isPaid: true,
  //   ),
  //   TransactionHistory(
  //     amount: 0.3,
  //     date: DateTime.now(),
  //     isPaid: true,
  //   ),
  //   TransactionHistory(
  //     amount: 1.2,
  //     date: DateTime.now(),
  //     isPaid: true,
  //   ),
  //   TransactionHistory(
  //     amount: 0.9,
  //     date: DateTime.now(),
  //     isPaid: true,
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    Driveruid driveruid = Provider.of<Driveruid>(context);
    //bool isPaid = true;
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
            StreamBuilder(
                stream: FirebaseService(uid: driveruid.uid).driver,
                builder: (_, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    Driver driver = snapshot.data;
                    return Column(
                      children: [
                        gaph(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: Text(
                              'Hello ${driver.name}',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 20.sp,
                                color: const Color(0xff1e2022),
                                letterSpacing: 1,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ), //;
                          // } else {
                          //   return Center(
                          //       child: CircularProgressIndicator.adaptive());
                          // }
                          //}
                          //),
                        ),
                        gaph(h: 25.w),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          driver.walletBalance
                                                  ?.toStringAsFixed(2) ??
                                              '0.00', //'23.00',
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
                        gaph(h: 40),
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            height: double.infinity,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                gaph(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: Text(
                                      'Latest Transaction',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff707070),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                gaph(),
                                Divider(
                                  thickness: 1.5,
                                  endIndent: 0,
                                  height: 0,
                                  indent: 0,
                                ),
                                Expanded(
                                  child: StreamBuilder<
                                          List<TransactionHistory>>(
                                      stream:
                                          FirebaseService(uid: driveruid.uid)
                                              .userTransactionHistory,
                                      builder: (_, AsyncSnapshot snapshot) {
                                        if (snapshot.hasData) {
                                          List<TransactionHistory>
                                              transactionList = snapshot.data;
                                          return ListView.separated(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            itemBuilder: (context, index) {
                                              TransactionHistory transaction =
                                                  transactionList[index];
                                              return ListTile(
                                                horizontalTitleGap: 20,
                                                leading: Image.asset(
                                                  'assets/icons/${transaction.isPaid ? 'cashOutIcon.png' : 'cashInIcon.png'}',
                                                  height: 45.h,
                                                ),
                                                title: Text(
                                                  '${transaction.description?['title'] ?? '${transaction.isPaid ? 'Cash Out' : 'Topup'}'}',
                                                ),
                                                subtitle:
                                                    transaction.description![
                                                                'subtitle'] !=
                                                            null
                                                        ? Text(
                                                            '${transaction.description?['subtitle'] ?? null}',
                                                          )
                                                        : null,
                                                trailing: Text(
                                                  '${transaction.isPaid ? '-' : '+'} RM ${transaction.amount.toStringAsFixed(2)}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: transaction.isPaid
                                                          ? Colors.red
                                                          : Colors.green),
                                                ),
                                              );
                                            },
                                            separatorBuilder: (_, index) {
                                              return Divider(
                                                endIndent: 0,
                                                height: 0,
                                                indent: 0,
                                              );
                                            },
                                            itemCount: transactionList.length,
                                          );
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator
                                                .adaptive(),
                                          );
                                        }
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     buttonWalletDesign(
                        //         context, 'Scan', 'assets/icons/BarcodeScanIcon.png'),
                        //     buttonWalletDesign(
                        //         context, 'Transfer', 'assets/icons/transferIcon.png'),
                        //   ],
                        // ),
                        // SizedBox(height: 20.h),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     buttonWalletDesign(
                        //         context, 'Reload', 'assets/icons/reloadIcon.png'),
                        //     buttonWalletDesign(context, 'Debit Card',
                        //         'assets/icons/debitCardIcon.png'),
                        //   ],
                        // )
                      ],
                    );
                  } else {
                    return Center(child: CircularProgressIndicator.adaptive());
                  }
                }),
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
        // if (title == 'Reload') {
        showBottomPopup(context, 'Wallet').whenComplete(() {
          setState(() {
            hightlightText = '0';
          });
          return print(hightlightText);
        });
        // } else {
        //   print('tbd');
        // }
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
          Driveruid driveruid = Provider.of<Driveruid>(context);
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
                      onPressed: () async {
                        print(amountcon.text);
                        TransactionHistory transactionHistory =
                            TransactionHistory(
                          amount: double.parse(amountcon.text),
                          date: DateTime.now(),
                          isPaid: false,
                          description: {'title': 'Top Up', 'subtitle': null},
                        );
                        await FirebaseService(uid: driveruid.uid)
                            .updateUserTransactionHistory(transactionHistory
                                //-10.00,
                                );
                        await FirebaseService(uid: driveruid.uid)
                            .updateDriverWalletBalance(
                          double.parse(amountcon.text),
                          //-10.00,
                        );
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
