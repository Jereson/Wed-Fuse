import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/utils/string_utils.dart';
import 'package:wedme1/viewModel/wallet_vm.dart';

class HistoryOfTransaction extends StatelessWidget {
  const HistoryOfTransaction({
    super.key,
    required this.inter40016,
  });

  final TextStyle inter40016;

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<WalletVm>(
        model: getIt(),
        initState: (init) {
          init.getTransactionHistory();
        },
        builder: (wVm, _) {
          return !wVm.isTxnHistryLoaded
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : wVm.transactionHistoryModel.isEmpty
                  ? const Center(
                      child: Text('No transaction yet'),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: wVm.transactionHistoryModel.length,
                      itemBuilder: (context, index) {
                        final txnData = wVm.transactionHistoryModel[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(9),
                                height: 39,
                                width: 39,
                                decoration: const BoxDecoration(
                                    color: Color(0xFFEDEDED),
                                    shape: BoxShape.circle),
                                child:
                                    Image.asset('assets/images/send-coin.png'),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    txnData.type ?? '',
                                    style: inter40016,
                                  ),
                                  Text(
                                    '${txnData.creatdAt!.toDate} -  ${txnData.creatdAt!.toTime}',
                                    style: GoogleFonts.inder(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: const Color(0xFFBDBDBD)),
                                  )
                                ],
                              ),
                              const Spacer(),
                              Text(
                                txnData.amount ?? '',
                                style: inter40016.copyWith(
                                  color: const Color(0xFFFF3131),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
        });
  }
}
