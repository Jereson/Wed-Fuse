import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/utils/form_utils.dart';
import 'package:wedme1/utils/string_utils.dart';
import 'package:wedme1/utils/styles.dart';
import 'package:wedme1/widget/app_bar_widget.dart';
import 'package:wedme1/widget/button_widget.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {

  final TextEditingController coinConvert = TextEditingController();
  final TextEditingController priceConvert = TextEditingController();

  void convertCoinToDollar() {
    double coinValue = double.tryParse(priceConvert.text) ?? 0;
    double dollarValue = coinValue * 0.07;
    coinConvert.text = '\$${dollarValue.toStringAsFixed(3)}';
  }

  @override
  void initState() {
    super.initState();
    priceConvert.addListener(convertCoinToDollar);
  }

  @override
  void dispose() {
    priceConvert.removeListener(convertCoinToDollar);
    priceConvert.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppbar(context,isPop: true, 'Converter', actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ))
      ]),
      body: ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                  height: 200,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  decoration: const BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(120),
                        bottomRight: Radius.circular(120),
                      )),
                  child: Column(
                    children: [
                      Text('Convert calculator',
                          style: GoogleFonts.inder(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20)),
                      Text(
                        "A convert calculator is a handy tool that allows you to quickly convert unit of coin and see equivalency in fiat.",
                        style: GoogleFonts.inder(
                            color: const Color(0xFFD9D9D9),
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                        textAlign: TextAlign.center,
                      )
                    ],
                  )),
              Positioned(
                  left: MediaQuery.of(context).size.width * 0.15,
                  bottom: -210,
                  child: SizedBox(
                    // height: 100,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,
                                  offset: Offset(1, 2), // Shadow position
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
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
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    child: Image.asset(
                                        'assets/images/color-coin.png'),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Coin',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: const Color(0xFF464646)),
                                  ),
                                  const Icon(Icons.keyboard_arrow_down_rounded,
                                      color: Color(0xFF464646)),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      controller: priceConvert,
                                      decoration: borderTextInputDecoration
                                          .copyWith(hintText: '500c'),
                                      keyboardType: TextInputType.number,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 5),
                              const Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('Equivalent to:')),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFEA4335)
                                            .withOpacity(0.28),
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    child:
                                        Image.asset('assets/images/naira.png'),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'USD',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: const Color(0xFF464646)),
                                  ),
                                  const Icon(Icons.keyboard_arrow_down_rounded,
                                      color: Color(0xFF464646)),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      onChanged: (value) {
                                        final double amount = double.parse(value);
                                        final double convertedAmount = amount * 0.07;
                                        coinConvert.text = '\$${convertedAmount.toInt()}';
                                      },
                                      controller: coinConvert,
                                      decoration: borderTextInputDecoration
                                          .copyWith(hintText: '\$35'),
                                      keyboardType: TextInputType.number,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),
                        ProceedButtonWidget(
                          color: kPrimaryColor,
                          size: MediaQuery.of(context).size,
                          text: 'Convert',
                          press: () {},
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
