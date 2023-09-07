import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image/image.dart' as img;
import '../../../Call/ZegCall/LiveStream.dart';
import 'openGallery.dart';

class CameraScreenChat extends StatefulWidget {
  const CameraScreenChat({Key? key, required this.UIDi}) : super(key: key);
  final String UIDi;

  @override
  State<CameraScreenChat> createState() => _CameraScreenChatState();
}

class _CameraScreenChatState extends State<CameraScreenChat> {
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
    if (cameraController != null) {
      await cameraController.dispose();
    }
    cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      enableAudio: false, // optional: disable audio recording
    );

    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    if (cameraController.value.hasError) {
      print("Camera error: ${cameraController.value.errorDescription}");
    }

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      _showCameraError(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  // Future<void> _initCamera(CameraDescription cameraDescription) async {
  //   if (cameraController != null) {
  //     await cameraController.dispose();
  //   }
  //   cameraController =
  //       CameraController(cameraDescription, ResolutionPreset.high);
  //
  //   cameraController.addListener(() {
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   });
  //
  //   if (cameraController.value.hasError) {
  //     print("Camera error: ${cameraController.value.errorDescription}");
  //   }
  //
  //   try {
  //     await cameraController.initialize();
  //   } on CameraException catch (e) {
  //     _showCameraError(e);
  //   }
  //
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  Widget _cameraPreview() {
    if (cameraController == null || !cameraController.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return AspectRatio(
      aspectRatio: cameraController.value.aspectRatio,
      child: CameraPreview(cameraController),
    );
  }

  Widget _captureButton(BuildContext context) {
    return Expanded(
        child: Align(
            alignment: Alignment.center,
            child: FloatingActionButton(
              onPressed: () {
                _captureImage(context);
              },
              child: const Icon(Icons.camera_alt),
            )));
  }

  Widget _switchCameraButton(BuildContext context) {
    if (cameras == null || cameras.isEmpty) {
      return Container();
    }
    CameraDescription selectedCamera = cameras[selectedCameraIndex];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;
    return FloatingActionButton(
      onPressed: onSwitchCamera,
      child: const Icon(Icons.switch_camera),
    );
  }

  @override
  void initState() {
    super.initState();
    availableCameras().then((value) {
      cameras = value;
      if (cameras.length > 0) {
        setState(() {
          selectedCameraIndex = 1;
        });
        _initCamera(cameras[selectedCameraIndex]).then((value) {});
      } else {
        print("No cameras found");
      }
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   availableCameras().then((value) {
  //     cameras = value;
  //     if (cameras.length > 0) {
  //       // select the front camera
  //       selectedCameraIndex = cameras.indexWhere(
  //             (camera) => camera.lensDirection == CameraLensDirection.front,
  //       );
  //       if (selectedCameraIndex == -1) {
  //         // if the front camera is not found, select the first camera
  //         selectedCameraIndex = 0;
  //       }
  //       _initCamera(cameras[selectedCameraIndex]).then((value) {});
  //     } else {
  //       print("No cameras found");
  //     }
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   availableCameras().then((value) {
  //     cameras = value;
  //     if (cameras.length > 0) {
  //       setState(() {
  //         selectedCameraIndex = 0;
  //       });
  //       _initCamera(cameras[selectedCameraIndex]).then((value) {});
  //     } else {
  //       print("No cameras found");
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
              child: Stack(
            children: [
              SizedBox(height: double.infinity, child: _cameraPreview()),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // selectedCameraIndex = (selectedCameraIndex + 1) % cameras.length;
                          // _initCamera(cameras[selectedCameraIndex]).then((value) {});
                        },
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/icons/img_7.png"),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LivePage(liveID: '', localUserID: '',),));
                        },
                        child: Container(
                          height: 48,
                          width: 107,
                          decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7))),
                          child: const Center(
                            child: Text(
                              "Go Live",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedCameraIndex =
                              (selectedCameraIndex + 1) % cameras.length;
                          _initCamera(cameras[selectedCameraIndex])
                              .then((value) {});
                        },
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/icons/img_5.png"),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  void _showCameraError(CameraException e) {
    String errorText = 'Error: ${e.code}\nError message: ${e.description}';
    print(errorText);
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
      final ImagePicker _picker = ImagePicker();

      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) {
        return; // User has cancelled the camera or went back without capturing an image
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayImageScreenChat(
            imagePath: image.path,
            idUrli: widget.UIDi,
          ),
        ),
      );
    } catch (e) {
      // _showCameraError(e);
    }
  }

  void onSwitchCamera() {
    selectedCameraIndex =
        selectedCameraIndex < cameras.length - 1 ? selectedCameraIndex + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIndex];
    _initCamera(selectedCamera);
  }
}

class DisplayImageScreenChat extends StatefulWidget {
  DisplayImageScreenChat(
      {Key? key, required this.imagePath, required this.idUrli})
      : super(key: key);
  final String imagePath;
  String idUrli;

  @override
  _DisplayImageScreenChatState createState() =>
      _DisplayImageScreenChatState(idUrl: idUrli);
}

class _DisplayImageScreenChatState extends State<DisplayImageScreenChat> {
  _DisplayImageScreenChatState({required this.idUrl});
  UploadTask? _uploadTask;
  String? _downloadUrl;
  //String profilePix = profileAvaterUrl;
  bool _loading = false;
  bool Pload = false;
  String idUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Stack(
        alignment: Alignment.center,
        children: [
          FloatingActionButton(
            onPressed: _uploadImage,
            child: Pload == true
                ? const CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  )
                : const Icon(Icons.send),
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
  }

  void _uploadImage() async {
    Pload == false ? Pload = true : Pload = false;
    setState(() {
      Pload = true;
    });

    try {
      final image = img.decodeImage(File(widget.imagePath).readAsBytesSync());
      final compressedImage = img.encodeJpg(image!, quality: 5);
      setState(() {
        Pload == true;
      });
      _uploadTask = FirebaseStorage.instance
          .ref()
          .child('images/myimage.jpg${DateTime.now().microsecondsSinceEpoch}')
          .putFile(File(widget.imagePath));

      final snapshot = await _uploadTask?.whenComplete(() {});
      final urlDownload =
          await snapshot?.ref.getDownloadURL().then((value) async {
        await FirebaseFirestore.instance
            .collection("chat")
            .doc(idUrl)
            .collection("chatR")
            .add({
          "imageSent": value.toString().trim(),
          "message": "",
          'timestamp': FieldValue.serverTimestamp(),
          "image": "",
          "audio": "",
          "currentUser": FirebaseAuth.instance.currentUser?.uid
        }).then((value) {
          Navigator.of(context).pop();
        });

        setState(() {
          Pload = false;
        });
      });

      setState(() {
        _downloadUrl = urlDownload;
      });
    } catch (e) {
      setState(() {
        Pload = false;
      });
      print(e);
    }
  }
}
