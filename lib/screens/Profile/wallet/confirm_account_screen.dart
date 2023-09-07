import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/screens/Profile/wallet/redemm_coin/choose_coin_class_model.dart';
import 'package:wedme1/utils/flushbar_widget.dart';
import 'package:wedme1/utils/form_utils.dart';
import 'package:wedme1/widget/app_bar_widget.dart';
import 'package:wedme1/widget/button_widget.dart';

class ConfirmAccountScreen extends StatefulWidget {
  const ConfirmAccountScreen(
      {super.key,
      required this.bankName,
      required this.accountNumber,
      required this.accountName,
      required this.balanceCoin});
  final String bankName;
  final String accountNumber;
  final String accountName;
  final String balanceCoin;

  @override
  State<ConfirmAccountScreen> createState() => _ConfirmAccountScreenState();
}

class _ConfirmAccountScreenState extends State<ConfirmAccountScreen> {
  TextEditingController priceToWithdraw = TextEditingController();
  String price = "";
  double coinValue = 0.6;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inter22222250016 = GoogleFonts.inder(
        color: const Color(0xFF222222),
        fontWeight: FontWeight.w500,
        fontSize: 16);
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: customAppbar(
        context,
        'Confirm account',
        isRedBg: false,
        isPop: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Checkout Amount:', style: inter22222250016),
          const SizedBox(height: 5),
          TextFormField(
            controller: priceToWithdraw,
            onChanged: (value) {
              setState(() {
                price = value;
                coinValue = double.tryParse(price)! * 0.07;
              });
            },
            decoration: borderTextInputDecoration.copyWith(hintText: '500c'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                Text(
                  'Value (USD)',
                  style: GoogleFonts.inder(
                      fontWeight: FontWeight.w400, fontSize: 14),
                ),
                Text(
                  '\$${coinValue.toStringAsFixed(2)}',
                  style: GoogleFonts.inder(
                      fontWeight: FontWeight.w600, fontSize: 24),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Divider(),
          Text(
            'Payable to:',
            style: GoogleFonts.inder(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          bankDetail('Bank name', widget.bankName),
          bankDetail('Account number:', widget.accountNumber),
          bankDetail('Account name:', widget.accountName),
          const SizedBox(height: 10),
          const Divider(),
          const Spacer(),
          ProceedButtonWidget(
            color: kPrimaryColor,
            size: MediaQuery.of(context).size,
            text: 'Proceed to Redeem',
            press: () {
              int? balanceCoin = int.tryParse(widget.balanceCoin);
              int? withdrawalInput = int.tryParse(priceToWithdraw.text);
              var currentCoinBalance = balanceCoin! - withdrawalInput!;
              if ( balanceCoin <= 0 || balanceCoin < withdrawalInput) {
                print("you can`t withdraw more than your balance");
                 flushbar(
                    context: context,
                    title: 'Insuffiecnt balance',
                    message:
                     'You don`t have a enough fun to complete this transaction',
                    isSuccess: false);
              } else {
                if (priceToWithdraw.text.isNotEmpty) {
                  ChooseAccountModel().transactionHisForWithdrawal(
                      amount: priceToWithdraw.text.trim(),
                      bankName: widget.bankName,
                      accountNumber: widget.accountNumber,
                      amountWithdraw: priceToWithdraw.text.trim(),
                      accountName: widget.accountName,
                      newCoinBalance: currentCoinBalance,
                      context: context);
                  Navigator.pop(context);
                }
              }
            },
          )
        ]),
      ),
    );
  }

  Widget bankDetail(String title, String data) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Text(
            '$title:',
            style: GoogleFonts.inder(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: const Color(0xFF929191)),
          ),
          const Spacer(),
          Text(
            data,
            style: GoogleFonts.inder(
                fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
