import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '/screens/timeline_section/shareStory/textStory.dart';

import '../../getit.dart';
import '../../utils/base_view_builder.dart';
import '../../utils/constant_utils.dart';
import '../../viewModel/profile_vm.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController cameraController = CameraController(
      const CameraDescription(
          name: "name",
          lensDirection: CameraLensDirection.back,
          sensorOrientation: 2),
      ResolutionPreset.high);
  List<CameraDescription> cameras = [];
  int selectedCameraIndex = 0;
  String imagePath = "";

  Future<void> _initCamera(CameraDescription cameraDescription) async {
    await cameraController.dispose();
    cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);

    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    if (cameraController.value.hasError) {}

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      _showCameraError(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  Widget _cameraPreview() {
    if (!cameraController.value.isInitialized) {
      return Container(
        color: Colors.white,
      );
    }
    return Container(
      color: Colors.white,
    );
  }

  @override
  void initState() {
    super.initState();
    availableCameras().then((value) {
      cameras = value;
      if (cameras.isNotEmpty) {
        setState(() {
          selectedCameraIndex = 0;
        });
        _initCamera(cameras[selectedCameraIndex]).then((value) {});
      } else {}
    });
  }

  void _onCaptureImagePressed() {
    _captureImage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: _cameraPreview()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("listOfFirends")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError &&
                        !snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("");
                    } else {
                      return InkWell(
                          onTap: () {
                            final data = snapshot.data!.get("friends") as List;
                            var my = FirebaseAuth.instance.currentUser!.uid;

                            List userW = [my, ...data];
                            //print(userW);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TextStory(
                                    users: userW,
                                  ),
                                ));
                          },
                          child: const Text(
                            "Aa",
                            style: TextStyle(color: Colors.white),
                          ));
                    }
                  }),
              const SizedBox(
                width: 20,
              ),
              FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: _onCaptureImagePressed,
                child: const Icon(Icons.camera_alt, size: 30),
              ),
              const SizedBox(
                width: 20,
              ),
              const Text(
                "Live",
                style: TextStyle(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _showCameraError(CameraException e) {
    String errorText = 'Error: ${e.code}\nError message: ${e.description}';
    //print(errorText);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Camera Error'),
          content: Text(errorText),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _captureImage(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) {
        return; // User has cancelled the camera or went back without capturing an image
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayImageScreen(
            imagePath: image.path,
          ),
        ),
      );
    } catch (e) {
      // _showCameraError(e);
    }
  }
}

class DisplayImageScreen extends StatefulWidget {
  const DisplayImageScreen({Key? key, required this.imagePath})
      : super(key: key);
  final String imagePath;

  @override
  DisplayImageScreenState createState() => DisplayImageScreenState();
}

class DisplayImageScreenState extends State<DisplayImageScreen> {
  String profilePix = profileAvaterUrl;
  bool pload = false;

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<ProfileViewModel>(
        model: getIt(),
        builder: (pVm, _) {
          return Scaffold(
            floatingActionButton: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("listOfFirends")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError &&
                              !snapshot.hasData &&
                              snapshot.connectionState ==
                                  ConnectionState.waiting) {
                            return const Text("");
                          } else {
                            return CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 35,
                              child: InkWell(
                                onTap: () {
                                 // print(widget.imagePath.toString());
                                  pload == false ? pload = true : pload = false;
                                  final data = snapshot.data!.get("friends") as List;
                                  var my = FirebaseAuth.instance.currentUser!.uid;

                                  List userW = [my, ...data];
                                  _uploadImage(
                                      image: pVm.cachedUserDetail!.photoUrl!,
                                      friends: userW);
                                },
                                child: pload
                                    ? const CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                      )
                                    : Image.asset("assets/images/img_3.png"),
                              ),
                            );
                          }
                        }),
                  ],
                ),
              ],
            ),
            backgroundColor: Colors.white,
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(File(widget.imagePath)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        });
  }

  void _uploadImage({
    required String image,
    required List friends,
  }) async {
    setState(() {
      pload = true;
    });

    try {
      final path = "status/pic/${widget.imagePath}";
      final file = File(widget.imagePath);
      final ref = FirebaseStorage.instance.ref().child(path);
      var uploadTask = ref.putFile(file);

      final snapshot = await uploadTask.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance.collection("status").add({
        "id": "",
        "color": 1,
        "profilePix": image,
        "imgUrl": urlDownload,
        "friends": friends
      }).then((value) {
        setState(() {
          pload =false;
        });
      });
      setState(() {
        pload = false;
      });
    } catch (e) {
      setState(() {
        pload = false;
      });
      setState(() {
        pload = false;
      });
      //print(e);
    }
  }
}
