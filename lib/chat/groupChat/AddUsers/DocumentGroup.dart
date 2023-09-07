import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'AudioFromChatGroup.dart';
import 'ImageFromChatGroup.dart';

class DocumentGroup extends StatefulWidget {
  const DocumentGroup({Key? key, required this.docId}) : super(key: key);
  final String docId;

  @override
  State<DocumentGroup> createState() => _DocumentGroupState();
}

class _DocumentGroupState extends State<DocumentGroup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0,right: 15,top: 15),
        child: Column(
          children: [
            ImageFromChatGroup(widget: widget),
            const SizedBox(height: 32,),
            //AudioFromChatGroup(widget: widget),
            Expanded(child: Text("")),
            Expanded(child: Text("")),
          ],
        ),
      ),
    );
  }
}

