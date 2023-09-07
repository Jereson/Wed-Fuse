import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/screens/Profile/wallet/select_friend_screen.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/utils/flushbar_widget.dart';
import 'package:wedme1/utils/form_utils.dart';
import 'package:wedme1/viewModel/user_reaction.dart';
import 'package:wedme1/viewModel/wallet_vm.dart';
import 'package:wedme1/widget/app_bar_widget.dart';
import 'package:wedme1/widget/button_widget.dart';

class GiftCoinScreen extends StatefulWidget {
  const GiftCoinScreen({super.key});

  @override
  State<GiftCoinScreen> createState() => _GiftCoinScreenState();
}

class _GiftCoinScreenState extends State<GiftCoinScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final inter22222250016 = GoogleFonts.inder(
        color: const Color(0xFF222222),
        fontWeight: FontWeight.w500,
        fontSize: 16);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppbar(context, 'Gift coin', isPop: true, isRedBg: false),
      body: BaseViewBuilder<UserReactionVm>(
          model: getIt(),
          builder: (uVm, _) {
            return BaseViewBuilder<WalletVm>(
                model: getIt(),
                initState: (init) {
                  init.getUserDetail();
                },
                builder: (wVm, _) {
                  return wVm.userDetail == null
                      ? const Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : SingleChildScrollView(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Gift a Wedfuse user',
                                    style: GoogleFonts.inder(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Easy gift system, with just a Wedfuse username send funds across to another Wedfuse user',
                                    style: GoogleFonts.inder(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                  const SizedBox(height: 20),
                                  Text('Username', style: inter22222250016),
                                  const SizedBox(height: 5),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SelectFriendScreen()));
                                    },
                                    child: TextFormField(
                                      controller: wVm.giftingFriendController,
                                      decoration:
                                          borderTextInputDecoration.copyWith(
                                              enabled: false,
                                              filled: false,
                                              hintText: 'Select friend',
                                              suffixIcon: Container(
                                                  width: 120,
                                                  alignment: Alignment.center,
                                                  margin:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: const Color(
                                                          0xFF464646)),
                                                  child: Text(
                                                    'See Friends List',
                                                    style: GoogleFonts.inter(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white),
                                                  ))),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text('Amount', style: inter22222250016),
                                  const SizedBox(height: 5),
                                  TextFormField(
                                    controller: wVm.giftingAmountController,
                                    decoration:
                                        borderTextInputDecoration.copyWith(
                                            filled: false,
                                            hintText: 'e.g 500c'),
                                    onChanged: (value) {
                                      wVm.convertGitfCoinOnChange();
                                    },
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(
                                          RegExp(r'\s')),
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    validator: uVm.amountValidator,
                                  ),
                                  const SizedBox(height: 20),
                                  Center(
                                    child: Text(
                                      'Value = \$${wVm.gitftingAMount ?? '0'}',
                                      style: GoogleFonts.inder(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                  ),
                                  ProceedButtonWidget(
                                    color: kPrimaryColor,
                                    size: MediaQuery.of(context).size,
                                    text: 'Continue to Purchase',
                                    press: () {
                                      if (wVm.giftingFriendController.text
                                          .isEmpty) {
                                        return flushbar(
                                            context: context,
                                            title: 'Friend Required',
                                            message: 'Please select friend',
                                            isSuccess: false);
                                      }
                                      if (!formKey.currentState!.validate()) {
                                        return;
                                      }

                                      // for (var id in uVm.myFriends!.member!) {
                                      //   if (id !=
                                      //       wVm.firebaseInstance.currentUser!
                                      //           .uid) {
                                      //     friendId = id;
                                      //   }
                                      // }
                                      // print('The receiving id $friendId');

                                      wVm.giftCoinToFriend(context);
                                    },
                                  ),
                                ]),
                          ),
                        );
                });
          }),
    );
  }
}
