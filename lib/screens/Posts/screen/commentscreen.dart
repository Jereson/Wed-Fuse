import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key, required this.postId}) : super(key: key);
  final String postId;

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  _CommentsScreenState();
  TextEditingController sendMessageController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("discoverModel")
                .doc(widget.postId)
                .collection("Comment")
                .snapshots(),
            builder: (_,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (!snapshot.hasData) {
                return const Text("");
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final message = snapshot.data!.docs[index]['comment'] ==
                        FirebaseAuth.instance.currentUser!.uid;
                    snapshot.data!.docs[index];
                    return Align(
                      alignment:
                      (message ? Alignment.topLeft : Alignment.topRight),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(40),
                            ),
                            color:
                            (message ? Colors.grey.shade200 : Colors.black),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            snapshot.data!.docs[index]["comment"],
                            style: TextStyle(
                              fontSize: 15,
                              color: message ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: sendMessageController,
                        decoration: const InputDecoration(
                            hintText: "Write your comment...",
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection("DiscoverModel")
                          .doc(widget.postId)
                          .collection("Comment")
                          .add({
                        "comment": sendMessageController.text.trim(),
                      });
                    },
                    backgroundColor: Colors.red,
                    elevation: 0,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
