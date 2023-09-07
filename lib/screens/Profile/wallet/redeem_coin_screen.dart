import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:wedme1/constants/colors.dart';

import 'package:wedme1/screens/Profile/wallet/redemm_coin/choose_account.dart';
import 'package:wedme1/screens/Profile/wallet/redemm_coin/redeem_coin_class_model.dart';
import 'package:wedme1/utils/form_utils.dart';
import 'package:wedme1/widget/app_bar_widget.dart';
import 'package:stack_trace/stack_trace.dart';
import '../../../getit.dart';
import '../../../models/stack_model/users_model.dart';
import '../../../utils/base_view_builder.dart';
import '../../../viewModel/profile_vm.dart';

class RedeemCoinScreen extends StatefulWidget {
  const RedeemCoinScreen({super.key});

  @override
  State<RedeemCoinScreen> createState() => _RedeemCoinScreenState();
}

class _RedeemCoinScreenState extends State<RedeemCoinScreen> {
  @override
  Widget build(BuildContext context) {
    final inter22222250016 = GoogleFonts.inder(
        color: const Color(0xFF222222),
        fontWeight: FontWeight.w500,
        fontSize: 16);
    return ViewModelBuilder<UsersModel>.reactive( onViewModelReady: (viewModel) async {
      await viewModel.dsNow();
    },viewModelBuilder: () => UsersModel(), builder: (context, viewModel, child) =>  Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: customAppbar(
        context,
        'Redeem coin',
        isRedBg: false,
      ),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Text('Amount', style: inter22222250016),
        const SizedBox(height: 5),
        TextFormField(
          decoration: borderTextInputDecoration.copyWith(
              filled: false, hintText: 'e.g 500c'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 20),
        Center(
          child: Text(
            'Balance = ${viewModel.userAccount?.coinBalance!.toString()}',
            style: GoogleFonts.inder(
                fontWeight: FontWeight.w400, fontSize: 14),
          ),
        ),
        const SizedBox(height: 10),
        const Divider(),
        Text(
          'Choose account',
          style: GoogleFonts.inder(
              fontWeight: FontWeight.w600, fontSize: 16),
        ),
         ChooseAccount(balanceCoin: viewModel.userAccount?.coinBalance.toString()??"",),
        const SizedBox(height: 30),
        TextButton(
            onPressed: () => RedeemCoin(userName: viewModel.userAccount?.fullName??"").showBottomSheet(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add, color: kPrimaryColor),
                Text(
                  'Add bank details',
                  style: GoogleFonts.inder(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            )),

      ]),
    ),);
  }
}
