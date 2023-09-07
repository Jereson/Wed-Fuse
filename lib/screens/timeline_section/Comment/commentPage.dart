import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../utils/constant_utils.dart';

class CommentPage extends StatelessWidget {
  String id;
  CommentPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  TextEditingController _sendMessageController = TextEditingController();

  String profipix = profileAvaterUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: BottomSheet(
        enableDrag: false,
        onClosing: () {
          return;
        },
        builder: (context) {
          return Container(
            padding: EdgeInsets.only(left: 8, right: 8),
            height: 100,
            color: Colors.red,
            child: Row(
              children: [
                Flexible(
                    child: TextFormField(
                  controller: _sendMessageController,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                )),
                IconButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("DiscoverModel")
                          .doc(id.toString())
                          .collection("Comment")
                          .add({
                        "Comment": _sendMessageController.text.trim(),
                        "profipix": profipix.trim(),
                        "creatAt": Timestamp.now(),
                      });

                      _sendMessageController.clear();
                    },
                    icon: const Icon(Icons.send))
              ],
            ),
          );
        },
      ),
      appBar: AppBar(title: Text("Comment")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("DiscoverModel")
            .doc(id)
            .collection("Comment")
            .snapshots(),
        builder:
            (_, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData && snapshot.data == null) {
            return Center(
              child: Container(child: const CircularProgressIndicator()),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              reverse: false,
              // reverse: true,
              primary: true,
              itemBuilder: (context, index) {
                if (snapshot.data == null) {
                  return const Text("");
                }
                DocumentSnapshot ds = snapshot.data!.docs[index];

                if (snapshot.data == null) {
                  return const Text("");
                } else {
                  return Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.09,
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.white12,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: index % 2 == 0
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.end,
                            children: [
                              ds["Comment"].toString().isEmpty
                                  ? Container()
                                  : Flexible(child: Text(ds["Comment"])),
                              ds["Comment"].toString().isEmpty
                                  ? Container()
                                  : Flexible(
                                      child: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(ds["profipix"]))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
