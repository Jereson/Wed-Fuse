import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wedme1/constants/colors.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/viewModel/user_reaction.dart';

class StorylineDetails extends StatelessWidget {
  const StorylineDetails(
      {Key? key,
      this.name,
      this.storylineUrl,
      this.seenCount,
      this.storylineId,
      this.userId})
      : super(key: key);

  final String? name;
  final String? storylineUrl;
  final int? seenCount;
  final String? storylineId;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.arrow_back),
          iconSize: 20.0,
          onPressed: (() {
            Navigator.pop(context);
          }),
        ),
        title: Text(
          name!,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: BaseViewBuilder<UserReactionVm>(
          model: getIt(),
          initState: (init) {
            init.storylineViewCount(userId!, storylineId!);
          },
          builder: (uVm, _) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: size.height,
                  width: size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            storylineUrl!,
                          ),
                          // image: AssetImage(
                          //   storylineUrl!,
                          // ),
                          fit: BoxFit.cover)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0, bottom: 4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name!.split(' ').first,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/icons/eye_icon.png",
                                height: 14,
                                width: 14,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                '$seenCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 68.0),
                              IconButton(
                                onPressed: () {
                                  uVm.likeStolyline(userId!, storylineId!);
                                },
                                icon: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.white,
                                  child:
                                      Image.asset("assets/icons/like_icon.png"),
                                ),
                              )
                            ]),
                      ],
                    ),
                  ),
                ),
                uVm.isStorylineAnimate
                    ? Animator(
                        duration: const Duration(milliseconds: 300),
                        tween: Tween(begin: 0.2, end: 1),
                        curve: Curves.elasticInOut,
                        cycles: 0,
                        builder: (BuildContext? context,
                                AnimatorState? animatorState, Widget? child) =>
                            Transform.scale(
                              scale: animatorState!.value!.toDouble(),
                              child: const Icon(
                                Icons.thumb_up,
                                size: 80,
                                color: kPrimaryColor,
                              ),
                            ))
                    : const Offstage(),
              ],
            );
          }),
    );
  }
}
