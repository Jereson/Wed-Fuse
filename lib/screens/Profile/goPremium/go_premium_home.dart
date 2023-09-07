import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/screens/Profile/goPremium/premium_pro_screen.dart';
import 'package:wedme1/screens/Profile/goPremium/premium_screen.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/viewModel/wallet_vm.dart';
import 'package:wedme1/widget/app_bar_widget.dart';

class GoPremiumHome extends StatelessWidget {
  const GoPremiumHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFF9F9F9),
      backgroundColor: Colors.white,
      appBar: customAppbar(context, 'Go premium', isPop: true, isRedBg: false),
      body: BaseViewBuilder<WalletVm>(
          model: getIt(),
          initState: (init) {
            init.getUserDetail();
          },
          builder: (pVm, _) {
            return pVm.userDetail == null
                ? const Center(
                    child: CupertinoActivityIndicator(),
                  )
                : ListView(padding: const EdgeInsets.all(20), children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        GestureDetector(
                          onTap: () {
                            pVm.setSubscriptionType('premium');
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const PremiumScreen()));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            height: 116,
                            decoration: BoxDecoration(
                                color: const Color(0xFFFF6D6D),
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Premium',
                                      style: GoogleFonts.inder(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20)),
                                  Row(
                                    children: [
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Icons.circle,
                                        size: 6,
                                        color: Colors.white,
                                      ),
                                      Text(' Pucket Friendly',
                                          style: GoogleFonts.inder(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12)),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('85c',
                                      style: GoogleFonts.inder(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12)),
                                  Text('\$6',
                                      style: GoogleFonts.inder(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 24)),
                                  Text('/month',
                                      style: GoogleFonts.inder(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12)),
                                ],
                              )
                            ]),
                          ),
                        ),
                        Positioned(
                          top: -10,
                          left: MediaQuery.of(context).size.width * 0.35,
                          child: Container(
                              alignment: Alignment.center,
                              width: 90,
                              height: 17,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.07)),
                                  borderRadius: BorderRadius.circular(9)),
                              child: Text(
                                'MOST POPULAR',
                                style: GoogleFonts.inder(
                                    color: const Color(0xFF464646),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 8),
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        GestureDetector(
                          onTap: () {
                            pVm.setSubscriptionType('proPremium');
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const PremiumProScreen()));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            height: 116,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFFF6D6D),
                                ),
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Premium PRO',
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
                                      Text(' Best value',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('85c',
                                      style: GoogleFonts.inder(
                                          color: const Color(0xFF1C1B1F),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12)),
                                  Text('\$6',
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
                        Positioned(
                          top: -10,
                          left: MediaQuery.of(context).size.width * 0.35,
                          child: Container(
                              alignment: Alignment.center,
                              width: 90,
                              height: 17,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  gradient: const LinearGradient(colors: [
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
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    RichText(
                        text: TextSpan(
                            text: 'Note: ',
                            children: [
                              TextSpan(
                                  text:
                                      '3 months subscription give u a 10% reduction of the one month subscription; while 6 months subscription gives u a 20% reduction of the one month subscription.',
                                  style: GoogleFonts.inder(
                                      color: const Color(0xFF464646),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12))
                            ],
                            style: GoogleFonts.inder(
                                color: const Color(0xFF464646),
                                fontWeight: FontWeight.w600,
                                fontSize: 12)))
                  ]);
          }),
    );
  }
}
