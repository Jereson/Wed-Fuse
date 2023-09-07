import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/screens/Profile/wallet/converter_screen.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/utils/constant_utils.dart';
import 'package:wedme1/utils/form_utils.dart';
import 'package:wedme1/viewModel/wallet_vm.dart';
import 'package:wedme1/widget/app_bar_widget.dart';
import 'package:wedme1/widget/button_widget.dart';

class BuyCoinScreen extends StatefulWidget {
  const BuyCoinScreen({super.key});

  @override
  State<BuyCoinScreen> createState() => _BuyCoinScreenState();
}

class _BuyCoinScreenState extends State<BuyCoinScreen> {
  final formKey = GlobalKey<FormState>();
  @override

  Widget build(BuildContext context) {
    final inter22222250016 = GoogleFonts.inder(
        color: const Color(0xFF222222),
        fontWeight: FontWeight.w500,
        fontSize: 16);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppbar(context, 'Buy coin',
          isRedBg: false,
          isPop: true,
          actions: [
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ConverterScreen())),
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  'Converter',
                  style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white),
                ),
              ),
            )
          ]),
      body: BaseViewBuilder<WalletVm>(
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
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(7),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: const Color(0xFFEA4335)
                                  .withOpacity(0.28),
                              borderRadius: BorderRadius.circular(14)),
                          child:
                          Image.asset('assets/images/color-coin.png'),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          'Wedfuse Coin',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: const Color(0xFF464646)),
                        ),
                        const Icon(Icons.keyboard_arrow_down_rounded,
                            color: Color(0xFF464646)),
                        const Spacer(),
                        Text(
                          '1 coin = \$$coinEquivalent',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: const Color(0xFF848484)),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text('Amount', style: inter22222250016),
                    const SizedBox(height: 5),
                    Form(
                      key: formKey,
                      child: TextFormField(
                        controller: wVm.buyCoinAmountController,
                        decoration: borderTextInputDecoration.copyWith(
                            hintText: 'e.g 500c'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (val) {
                          wVm.convertBuyAmoingOnChange();
                        },
                        validator: wVm.amountValidator,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        'Value (USD) = \$${wVm.buyAmountInUSD ?? '0'}',
                        style: GoogleFonts.inder(
                            fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                    ),
                    ProceedButtonWidget(
                      color: kPrimaryColor,
                      size: MediaQuery.of(context).size,
                      text: 'Instant Purchase',
                      press: () {
                        if (!formKey.currentState!.validate()) return;

                        // wVm.convertCurrency(context);
                        wVm.initiatePayment(context, '${wVm.buyAmountInUSD}', 'buyCoin');
                      },
                    )
                  ]),
            );
          }),
    );
  }
}