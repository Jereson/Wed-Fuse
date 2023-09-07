import 'package:cloud_firestore/cloud_firestore.dart';

class ModelTimeLine{
  
  
  reportPost(String postID, String postName, String describe, String email) async {
   await FirebaseFirestore.instance.collection("reportPost").add({
      "postId":postID,
      "postName":postName,
      "describe":describe,
      "email":email
    });
  }
}