import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/screens/Profile/wallet/buy_coin_screen.dart';
import 'package:wedme1/screens/Profile/wallet/gift_coin_screen.dart';
import 'package:wedme1/screens/Profile/wallet/redeem_coin_screen.dart';
import 'package:wedme1/widget/app_bar_widget.dart';

import '../../../getit.dart';
import '../../../models/stack_model/users_model.dart';
import '../../../utils/base_view_builder.dart';
import '../../../viewModel/profile_vm.dart';
import 'package:stacked/stacked.dart';
import 'histroy_transcation/history_transction_ui.dart';

class WalletHome extends StatefulWidget {
  const WalletHome({super.key});

  @override
  State<WalletHome> createState() => _WalletHomeState();
}

class _WalletHomeState extends State<WalletHome> {
  final inter60014 =
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600);
  final inter40016 = GoogleFonts.inder(
      fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black);
  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<ProfileViewModel>(
        model: getIt(),
        builder: (pVm, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            //floatingActionButton: FloatingActionButton(onPressed: () => TransHisModel().createTrans(title: "You received a coin",  price: "800c"),),
            appBar: customAppbar(context, 'Wallet', isPop: true, actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            ]),
            body: ListView(
              children: [
                Container(
                  color: kPrimaryColor,
                  child: Column(
                    children: [
                      Text(
                        'Current Coin Balance',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      const CoinBalance(),
                      const SizedBox(height: 20),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                              color: const Color(0xFF2F2F34),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "1 coin is equivalent to \$0.07",
                            style: GoogleFonts.inter(
                                color: const Color(0xFFFDFDFD)),
                          )),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Material(
                  elevation: 0.0,
                  color: kPrimaryColor,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            coinButtonBlack(
                                'gift-coin',
                                'Gift Coin',
                                () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const GiftCoinScreen()))),
                            GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const BuyCoinScreen(),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(22),
                                    height: 76,
                                    width: 76,
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Color(0xFFFE434E),
                                          Color(0xFF980F0F)
                                        ]),
                                        shape: BoxShape.circle),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text('Buy Coin', style: inter60014)
                                ],
                              ),
                            ),
                            coinButtonBlack(
                                'redeem-coin',
                                'Redeem Coin',
                                () => Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const RedeemCoinScreen(),
                                    ))),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Transaction History',
                              style: GoogleFonts.inder(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: const Color(0xFF222222)),
                            ),
                            Text(
                              'View All',
                              style: GoogleFonts.inder(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: const Color(0xFF383838)),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        HistoryOfTransaction(inter40016: inter40016)
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget coinButtonBlack(String imageUrl, String title, VoidCallback callback) {
    return GestureDetector(
      onTap: callback,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            height: 76,
            width: 76,
            decoration: const BoxDecoration(
                color: Colors.black, shape: BoxShape.circle),
            child: Image.asset('assets/images/$imageUrl.png'),
          ),
          Text(title, style: inter60014)
        ],
      ),
    );
  }
}

class CoinBalance extends StatelessWidget {
  const CoinBalance({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UsersModel>.reactive(
      viewModelBuilder: () => UsersModel(),
      onViewModelReady: (viewModel) async {
        await viewModel.dsNow();
      },
      builder: (context, viewModel, child) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            viewModel.userAccount?.coinBalance.toString() ?? "",
            style: GoogleFonts.urbanist(
                fontSize: 40, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          const SizedBox(width: 16),
          const Icon(
            Icons.visibility_outlined,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
