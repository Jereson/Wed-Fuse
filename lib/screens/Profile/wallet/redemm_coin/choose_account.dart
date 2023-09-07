import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import '../confirm_account_screen.dart';
import 'choose_account_class.dart';
import 'choose_coin_class_model.dart';

class ChooseAccount extends StatelessWidget {
  const ChooseAccount({
    super.key, required this.balanceCoin,
  });
  final String balanceCoin;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChooseAccountModel>.reactive(
      viewModelBuilder: () => ChooseAccountModel(),
      builder: (context, viewModel, child) => StreamBuilder<
              List<ChooseAccountClass>>(
          stream: viewModel.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Text("connection..."),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: Text("No bank account added yet"),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ConfirmAccountScreen(
                                bankName: snapshot.data![index].bankName,
                                accountName: snapshot.data![index].accountName,
                                accountNumber:
                                    snapshot.data![index].accountNumber, balanceCoin: balanceCoin,
                              ))),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        margin: const EdgeInsets.only(bottom: 10),
                        height: 60,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.account_balance_outlined,
                              color: Color(0xFF464646),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${snapshot.data![index].accountName} xxxx ${snapshot.data![index].accountNumber.toString().substring(snapshot.data![index].accountNumber.toString().length - 4)}",
                                  style: GoogleFonts.inder(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: const Color(0xFF0E0E0E)),
                                ),

                                Text(
                                  snapshot.data![index].bankName,
                                  style: GoogleFonts.inder(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      color: const Color(0xFF848484)),
                                )
                              ],
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.more_vert,
                              color: Color(0xFF222222),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
