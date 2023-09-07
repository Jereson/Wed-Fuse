import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class OpenGallery extends StatefulWidget {
   OpenGallery({Key? key, required this.UIDS}) : super(key: key);
  String UIDS;

  @override
  State<OpenGallery> createState() => _OpenGalleryState(uidE: UIDS);
}

class _OpenGalleryState extends State<OpenGallery> {

  _OpenGalleryState({required this.uidE});
  String uidE;

  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {


    }
  }

  PlatformFile? selecteImage;
  UploadTask? uploadTask;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: uploadToFirebase,child: isLoading==false?const CircularProgressIndicator(backgroundColor: Colors.white,): const Icon(Icons.send),),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [
            selecteImage?.path==null?Text(""):Container(
              height: MediaQuery.of(context).size.height*0.60,
              child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.file(File(selecteImage!.path!))),
            ),
           const Text("Select Picture"),
            Container(
              child: IconButton(onPressed:selectImage, icon: Icon(Icons.image)),
            ),
          ],
        ),
      ),
    );
  }
  Future selectImage() async {

    FilePickerResult? resultImage = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );



    if(resultImage != null){

      print("Has pictures");

      setState(() {
        selecteImage=resultImage.files.single;

      });

      resultImage.files.forEach((f){



      });

      print(resultImage);
      print(resultImage.files.length);
      print(resultImage);
      print(resultImage.paths);

    } else {
      print("Null or doesn't have pictures");
    }

  }


  Future<void> uploadToFirebase() async {
    isLoading=true;
    setState(() {

    });
      final pathImage = "file/audio/${selecteImage!.name}";
      final fileImage = File(selecteImage!.path!);


      final refImage = await FirebaseStorage.instance.ref().child(pathImage);
      uploadTask = refImage.putFile(fileImage);
      setState(() {
        // Pload=true;

      });
      try {
        final snapshot = await uploadTask!.whenComplete(() {});
        final snapshotImage = await uploadTask!.whenComplete(() {});
        final urlDownloadImag = await snapshotImage.ref.getDownloadURL();
        final urlDownload = await snapshot.ref.getDownloadURL().then((
            value) async {

          await FirebaseFirestore.instance
              .collection("chat")
              .doc(uidE)
              .collection("chatR")
              .add({
            "imageSent":value.toString().trim(),
            "message": "",
            'timestamp': FieldValue.serverTimestamp(),
            "image": "",
            "audio": ""
          }).then((value) {
            Navigator.of(context).pop();
          });
        }
        );

        setState(() {
          isLoading=false;

        });
        print("downloaded url ${urlDownload}");
      } catch (e) {
        print("this is the error $e ");


        setState(() {
          isLoading=false;

        });
      }
    }
  }

