import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/viewModel/user_reaction.dart';
import 'package:wedme1/viewModel/wallet_vm.dart';

class SelectFriendScreen extends StatelessWidget {
  const SelectFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 2),
            child: Transform.translate(
              offset: const Offset(-5, 0),
              child: const CircleAvatar(
                radius: 15,
                backgroundColor: kPrimaryColor,
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Your Friends',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/images/search.png',
                color: Colors.black,
              )),
          const SizedBox(width: 10),
        ],
      ),
      body: BaseViewBuilder<WalletVm>(
          model: getIt(),
          builder: (wVm, _) {
            return BaseViewBuilder<UserReactionVm>(
                model: getIt(),
                initState: (init) {
                  init.getMyFriends();
                },
                builder: (uVm, _) {
                  return uVm.myFriends == null && !uVm.isFriendLoaded
                      ? const Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : uVm.friendsModel.isEmpty
                          ? const Center(
                              child: Text("You don't have active friend yet!"),
                            )
                          : ListView.builder(
                              itemCount: uVm.friendsModel.length,
                              itemBuilder: (context, index) {
                                final uid =
                                    uVm.firebaseInstance.currentUser!.uid;
                                final friendData = uVm.friendsModel[index];
                                String? photo = uid == friendData.senderId
                                    ? friendData.receiverPhoto!
                                    : friendData.senderPhoto;
                                String? name = uid == friendData.senderId
                                    ? friendData.receiverName
                                    : friendData.senderName;

                                String? phone = uid == friendData.senderId
                                    ? friendData.receiverPhone
                                    : friendData.senderPhone;

                                return ListTile(
                                  onTap: () {
                                    // print(
                                    // 'selecting friend ${friendData.}');
                                    wVm.setSelectedFriend(friendData);
                                    Navigator.of(context).pop();
                                  },
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: photo!,
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                        errorWidget: (context, url, error) =>
                                            Center(
                                          child: Text(name![0],
                                              style: GoogleFonts.urbanist(
                                                  fontSize: 24,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  title: Text(name ?? '',
                                      style: GoogleFonts.urbanist(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700)),
                                  subtitle: Text(
                                    phone ?? '',
                                    style: GoogleFonts.urbanist(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF616161)),
                                  ),
                                  trailing: Container(
                                    height: 32,
                                    width: 75,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Select',
                                        style: GoogleFonts.urbanist(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                });
          }),
    );
  }
}
