import 'package:flutter/material.dart';
import 'package:wedme1/models/users_detail_model.dart';

import '../../../getit.dart';
import '../../../utils/base_view_builder.dart';
import '../../../viewModel/profile_vm.dart';
import '../conversation_screen.dart';

class UserItemNow extends StatelessWidget {
  final UsersDetailModel? userDetail;
  const UserItemNow({Key? key, this.userDetail}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return BaseViewBuilder<ProfileViewModel>(
        model: getIt(),
        builder: (pVm, _) {
        return ConversationScreen(
          profilePix: userDetail!.fullName!,
          userNameD: userDetail!.fullName!,
          online: '', ide: userDetail!.userId!, chatID: '', count: "1", block: false, callId: '', coin: pVm.cachedUserDetail!.coinBalance!.toString(), balance: pVm.cachedUserDetail!.balance!.toString(),
        );
      }
    );
  }
}
