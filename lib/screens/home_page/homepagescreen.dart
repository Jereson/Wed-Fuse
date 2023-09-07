import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/screens/Profile/profile_screen/profile_screen.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/viewModel/profile_vm.dart';
import 'package:wedme1/widget/show_home_filter.dart';
import 'package:wedme1/widget/user_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool swt = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BaseViewBuilder<ProfileViewModel>(
        model: getIt(),
        initState: (init) {
          init.allUsers2();
        },
        builder: (pVm, _) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const ProfileScreen();
                    })),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          NetworkImage(pVm.cachedUserDetail!.photoUrl!),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: -12,
                            right: -12,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.transparent,
                              child: Icon(
                                Icons.verified,
                                size: 14,
                                color: pVm.cachedUserDetail!.isVerified!
                                    ? const Color(0xFF0057FF)
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Image.asset(
                      'assets/images/webfuse-logo.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  Row(
                    children: [
                      Transform.translate(
                        offset: const Offset(14, 0),
                        child: IconButton(
                            onPressed: () => showHomeFilterWidget(context),
                            icon: const Icon(
                              Icons.tune,
                              color: Colors.black,
                              size: 28,
                            )),
                      ),
                      Transform.translate(
                        offset: const Offset(14, 0),
                        child: IconButton(
                            onPressed: () => pVm.setHomeShow(),
                            icon: Icon(
                              pVm.isHomeShowGrid
                                  ? Icons.grid_view_rounded
                                  : Icons.format_list_bulleted,
                              size: 28,
                              color: Colors.black,
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
            backgroundColor: Colors.white,
            body: Padding(
                padding: const EdgeInsets.only(top: 14),
                child: !pVm.isUsersLoaded
                    ? const Center(child: CupertinoActivityIndicator())
                    : pVm.userList.isEmpty
                        ? const Center(
                            child: Text('You do not have match yet!'),
                          )
                        : pVm.serchList().isEmpty
                            ? const Center(
                                child: Text('No filter result'),
                              )
                            : ListView.builder(
                                // itemCount: pVm.userList.length,
                                itemCount: pVm.serchList().length,
                                // itemCount: pVm.getFilterSearch().length,

                                physics: const BouncingScrollPhysics(),
                                itemBuilder: ((context, index) {
                                  final userDetail = pVm.serchList()[index];
                                  // final userDetail = pVm.getFilterSearch()[index];
                                  return SizedBox(
                                    // padding: const EdgeInsets.only(bottom: 20),
                                    height: size.height * 0.75,
                                    width: pVm.isHomeShowGrid
                                        ? size.width * 0.9
                                        : double.infinity,
                                    child: UserItem(
                                      userDetail: userDetail,
                                      indexTwo: index,
                                    ),
                                  );
                                }))

                //  Material(
                //     child: pVm.isHomeShowGrid
                //         ? GridView.builder(
                //             padding: const EdgeInsets.all(10),
                //             physics: const BouncingScrollPhysics(),
                //             itemCount: snapshot.data!.length,
                //             gridDelegate:
                //                 const SliverGridDelegateWithFixedCrossAxisCount(
                //                     crossAxisCount: 2,
                //                     crossAxisSpacing: 10.0,
                //                     mainAxisSpacing: 1.0,
                //                     childAspectRatio: 2 / 2),
                //             itemBuilder: ((context, index) {
                //               final userDetail = snapshot.data![index];
                //               return HomeShowGridView(
                //                 userDetail: userDetail,
                //                 indexTwo: index,
                //               );
                //             }),
                //           )
                //         : ListView.builder(
                //             itemCount: snapshot.data!.length,
                //             physics: const BouncingScrollPhysics(),
                //             itemBuilder: ((context, index) {
                //               final userDetail = snapshot.data![index];
                //               return SizedBox(
                //                 // padding: const EdgeInsets.only(bottom: 20),
                //                 height:
                //                     MediaQuery.of(context).size.height *
                //                         0.75,
                //                 child: UserItem(
                //                   userDetail: userDetail,
                //                   indexTwo: index,
                //                 ),
                //               );
                //             })),
                //   );

                ),
          );
        });
  }
}
