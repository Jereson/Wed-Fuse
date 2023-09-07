import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'DocumentGroup.dart';

class ImageFromChatGroup extends StatelessWidget {
  const ImageFromChatGroup({
    super.key,
    required this.widget,
  });

  final DocumentGroup widget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection("groupChat")
            .doc(widget.docId)
            .collection("chatR") .where("imageSent", isNotEqualTo: "")

            .snapshots(),
        builder: (_,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return const Text("");
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text(""));
          } else {
            return Column(
              children: [
                Row(
                  children:  [
                    Text(
                      "Media(${snapshot.data!.docs.length})",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final doc = snapshot.data!.docs[index];
                      return doc["imageSent"] == ""|| doc["isAudio"]==true
                          ? Container()
                          : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                        height: 64,
                        width: 76,
                        decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  color: Colors.red,
                                  image: DecorationImage(
                                      image: NetworkImage(doc["imageSent"]),fit: BoxFit.cover)),
                      ),
                              ),

                            ],
                          );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
