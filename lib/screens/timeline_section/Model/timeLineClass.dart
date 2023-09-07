import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Discover with ChangeNotifier {
  final Username;
  final profilePic;
  final age;
  final writeUp;
  final time;
  final img;
  final id;
  bool like;

  final Addlike;
  Discover(
      {this.Addlike,
      required this.profilePic,
      this.like = false,
      required this.id,
      required this.img,
      required this.Username,
      required this.age,
      required this.writeUp,
      required this.time});
}

class DiscoverModel with ChangeNotifier {
  Stream<List<Discover>> get bookd {
    return FirebaseFirestore.instance
        .collection("DiscoverModel")
        .snapshots()
        .map((e) => e.docs
            .map((e) => Discover(
                Username: e.data()["name"],
                age: e.data()["name"],
                writeUp: e.data()["writeUp"],
                time: e.data()["time"],
                img: e.data()["img"],
                id: e.data()["id"],
                Addlike: e.data()["Addlike"],
                profilePic: e.data()["profilePic"]))
            .toList());
  }

// List<Book> _books = [];
//
// List<Book> get books => _books;
//
// void setBooks(List<Book> books) {
//   _books = books;
//   notifyListeners();
// }
// final  snjapshot = await FirebaseFirestore.instance.collection("Books").snapshots().map((event) => Book(name: event.docs.map((e) => e.data()["name"]), age: event.docs.map((e) => e.data()["name"])));

//   Future<void> fetchBooks() async {
//     List<Book> books = [];
//
// print(snjapshot);
//
//     final  snapshot = await FirebaseFirestore.instance.collection("Books").get();
//     books = snapshot.docs.map((e) {
//        //print(snapshot.docs.map((e) => e.data()["name"]));
//       return Book(name: e.data(), age: snapshot.docs.map((e) => e.data()["name"]));
//     }).toList();
//     notifyListeners();
//
//    // print(books);
//   }
}
