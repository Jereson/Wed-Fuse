import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StreamForComment extends StatelessWidget {
  const StreamForComment({
    super.key,
    required this.id,
    required this.list
  });
  final String id;
  final List list;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("discoverModel")
          .doc(id)
          .collection("comments")
          .snapshots(),
      builder: (_,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
          snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Text(""),
          );
        } else if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const Center(
            child: Text(""),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Comment",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      " (${snapshot.data!.docs.length})",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 23,
                ),
                list.isEmpty? SizedBox(
                  height: 450,
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var filteredDocs = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 26.0),
                        child:Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 100,
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(filteredDocs["picture"]),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16), // add some space between the avatar and the text
                            Expanded(
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                                  maxHeight: double.infinity,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        filteredDocs["name"],
                                        style: const TextStyle(fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        filteredDocs["comment"],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF747474),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            "",
                                            style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF747474),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      );
                    },
                  ),
                ): SizedBox(
                  height: 250,
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var filteredDocs = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 26.0),
                        child:Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 100,
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(filteredDocs["picture"]),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16), // add some space between the avatar and the text
                            Expanded(
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                                  maxHeight: double.infinity,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        filteredDocs["name"],
                                        style: const TextStyle(fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        filteredDocs["comment"],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF747474),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            "",
                                            style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF747474),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      );
                    },
                  ),
                )

              ],
            ),
          );
        }
      },
    );
  }
}
