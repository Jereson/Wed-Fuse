import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/utils/base_view_builder.dart';
import 'package:wedme1/viewModel/user_reaction.dart';
import 'package:wedme1/widget/detail_storyline.dart';

class StoryLineScreen extends StatelessWidget {
  const StoryLineScreen({Key? key, required this.name, required this.userId})
      : super(key: key);
  final String? name;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<UserReactionVm>(
        model: getIt(),
        builder: (uVm, _) {
          return StreamBuilder<QuerySnapshot>(
              stream: uVm.getStoryline(userId!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Text('Loading'),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text('Loading'),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                return GridView.builder(
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.docs.reversed.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2.0,
                      mainAxisSpacing: 2.0,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1)),
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => StorylineDetails(
                                    name: name,
                                    storylineUrl:
                                        '${snapshot.data!.docs[index]['image']}',
                                    seenCount: snapshot.data!.docs[index]
                                        ['viewCount'],
                                    storylineId: snapshot.data!.docs[index]
                                        ['id'],
                                    userId: userId,
                                  ))));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 4,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(
                                colors: [Colors.black, Colors.transparent],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                tileMode: TileMode.mirror,
                                stops: [0.0, 0.5]),
                            image: DecorationImage(
                                image: NetworkImage(
                                    '${snapshot.data!.docs[index]['image']}'),
                                // AssetImage(timelineUrls),
                                fit: BoxFit.cover),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    "assets/icons/eye_icon.png",
                                    height: 14,
                                    width: 14,
                                  ),
                                  Text(
                                    '${snapshot.data!.docs[index]['viewCount']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ]),
                          ),
                        ));
                  }),
                );
              });
        });
  }
}
