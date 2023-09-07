import 'package:flutter/material.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/models/users_detail_model.dart';
import 'package:wedme1/screens/Profile/profile_screen/profile_screen.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/viewModel/profile_vm.dart';
import 'package:wedme1/widget/user_list_item.dart';

import 'UserItemNow.dart';

class ChatNow extends StatelessWidget {
  const ChatNow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<ProfileViewModel>(
        model: getIt(),
        builder: (pVm, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.only(top: 14),
              child: StreamBuilder<List<UsersDetailModel>>(
                  stream: pVm.allUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Text('Loading...'),
                      );
                    }
                    // print('object lenght ${snapshot.data![0].}');
                    // return UserListScreen();
                    return snapshot.data!.isEmpty
                        ? const Center(
                      child: Text('You do not have match yet!'),
                    )
                        : ListView.builder(
                        itemCount: snapshot.data!.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: ((context, index) {
                          final userDetail = snapshot.data![index];
                          return SizedBox(
                            // height: 550,
                            height:
                            MediaQuery.of(context).size.height * 0.75,
                            child: UserItemNow(userDetail: userDetail),
                          );
                        }));
                  }),
            ),
          );
        });
  }
}
