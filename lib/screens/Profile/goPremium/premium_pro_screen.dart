import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/utils/flushbar_widget.dart';
import 'package:wedme1/viewModel/wallet_vm.dart';
import 'package:wedme1/widget/button_widget.dart';

class PremiumProScreen extends StatelessWidget {
  const PremiumProScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0.0,
      ),
      body: BaseViewBuilder<WalletVm>(
          model: getIt(),
          initState: (init) {
            init.resetPremiumMonthType();
          },
          builder: (wVm, _) {
            return ListView(children: [
              Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    kPrimaryColor.withOpacity(0.9),
                    const Color(0xFF8F1A6E),
                  ])),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              margin: const EdgeInsets.all(12),
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: kPrimaryColor,
                                size: 18,
                              ),
                            ),
                          ),
                          Text(
                            'Premium Pro',
                            style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                        child: Column(
                          children: [
                            Text('Premium subscription',
                                style: GoogleFonts.inder(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20)),
                            Text(
                              "If you're looking for top-of-the-line features and benefits, our Premium plan is the perfect choice.",
                              style: GoogleFonts.inder(
                                  color: const Color(0xFFD9D9D9),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  kPrimaryColor.withOpacity(0.9),
                  const Color(0xFF8F1A6E),
                ])),
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => wVm.setPremiumMonthType('9', 30, 1),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          height: 116,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: wVm.subDays == 30
                                    ? const Color(0xFF1D4ED8)
                                    : const Color(0xFFFF6D6D),
                              ),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('1 month',
                                    style: GoogleFonts.inder(
                                        color: const Color(0xFF1C1B1F),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20)),
                                Row(
                                  children: [
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.circle,
                                      size: 6,
                                      color: Color(0xFF1C1B1F),
                                    ),
                                    Text(' Economy plan',
                                        style: GoogleFonts.inder(
                                            color: const Color(0xFF1C1B1F),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12)),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('128c',
                                    style: GoogleFonts.inder(
                                        color: const Color(0xFF1C1B1F),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                                Text('\$9',
                                    style: GoogleFonts.inder(
                                        color: const Color(0xFF1C1B1F),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 24)),
                                Text('/Monthly',
                                    style: GoogleFonts.inder(
                                        color: const Color(0xFF1C1B1F),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                              ],
                            )
                          ]),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => wVm.setPremiumMonthType('24.3', 90, 3),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          height: 116,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: wVm.subDays == 90
                                    ? const Color(0xFF1D4ED8)
                                    : const Color(0xFFFF6D6D),
                              ),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('3 months',
                                    style: GoogleFonts.inder(
                                        color: const Color(0xFF1C1B1F),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20)),
                                Row(
                                  children: [
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.circle,
                                      size: 6,
                                      color: Color(0xFF1C1B1F),
                                    ),
                                    Text(' Save 10%',
                                        style: GoogleFonts.inder(
                                            color: const Color(0xFF1C1B1F),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.circle,
                                      size: 6,
                                      color: Color(0xFF1C1B1F),
                                    ),
                                    Text(' Get upto 10 Days Free',
                                        style: GoogleFonts.inder(
                                            color: const Color(0xFF1C1B1F),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12)),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('347c',
                                    style: GoogleFonts.inder(
                                        color: const Color(0xFF1C1B1F),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                                Text('\$24.3',
                                    style: GoogleFonts.inder(
                                        color: const Color(0xFF1C1B1F),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 24)),
                                Text('\$8.4/Monthly',
                                    style: GoogleFonts.inder(
                                        color: const Color(0xFF1C1B1F),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                              ],
                            )
                          ]),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => wVm.setPremiumMonthType('43.2', 180, 6),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          height: 116,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: wVm.subDays == 180
                                    ?  const Color(0xFF1D4ED8)
                                    : const Color(0xFFFF6D6D),
                              ),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Text('6 months',
                                        style: GoogleFonts.inder(
                                            color: const Color(0xFF1C1B1F),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20)),
                                    const SizedBox(width: 10),
                                    Container(
                                        alignment: Alignment.center,
                                        width: 75,
                                        height: 17,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                            gradient:
                                                const LinearGradient(colors: [
                                              Color(0xFFFF3131),
                                               Color(0xFF1D4ED8),
                                            ])),
                                        child: Text(
                                          'BEST VALUE',
                                          style: GoogleFonts.inder(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 8),
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.circle,
                                      size: 6,
                                      color: Color(0xFF1C1B1F),
                                    ),
                                    Text(' Save 20%',
                                        style: GoogleFonts.inder(
                                            color: const Color(0xFF1C1B1F),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.circle,
                                      size: 6,
                                      color: Color(0xFF1C1B1F),
                                    ),
                                    Text(' Get upto 30 Days Free',
                                        style: GoogleFonts.inder(
                                            color: const Color(0xFF1C1B1F),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12)),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('617c',
                                    style: GoogleFonts.inder(
                                        color: const Color(0xFF1C1B1F),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                                Text('\$43.2',
                                    style: GoogleFonts.inder(
                                        color: const Color(0xFF1C1B1F),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 24)),
                                Text('\$7.2/Monthly',
                                    style: GoogleFonts.inder(
                                        color: const Color(0xFF1C1B1F),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                              ],
                            )
                          ]),
                        ),
                      ),
                      const SizedBox(height: 50),
                      ProceedButtonWidget(
                        color: kPrimaryColor,
                        size: MediaQuery.of(context).size,
                        text: 'Continue to Subscribe',
                        press: () {
                           if (wVm.premiumMonthType != null &&
                              wVm.subAmount != null) {
                            wVm.initiatePayment(
                                context, '${wVm.subAmount}', 'premium');
                          } else {
                            flushbar(
                                context: context,
                                title: 'Required',
                                message: 'Please select subscription place ',
                                isSuccess: true);
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ]);
          }),
    );
  }
}
