import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import '/screens/timeline_section/shareStory/textStory.dart';

import '../notused.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({super.key});

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  List<Widget> imageList = [];
  int currentPage = 0;
  int? lastPage;

  handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent <= .33) return;
    if (currentPage == lastPage) return;
    fetchAllImages();
  }

  fetchAllImages() async {
    lastPage = currentPage;
    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) return PhotoManager.openSetting();

    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: true,
    );

    List<AssetEntity> photos = await albums[0].getAssetListPaged(
      page: currentPage,
      size: 24,
    );

    List<Widget> temp = [];

    for (var asset in photos) {
      temp.add(
        FutureBuilder(
          future: asset.thumbnailDataWithSize(
            const ThumbnailSize(172, 126),
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container();
            }
            return const SizedBox();
          },
        ),
      );
    }

    setState(() {
      imageList.addAll(temp);
      currentPage++;
    });
  }

  @override
  void initState() {
    fetchAllImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: Container(
        height: 115,
        decoration: BoxDecoration(
            color: const Color(0xff525252).withOpacity(0.6),
            image: const DecorationImage(
                image: AssetImage("assets/images/img_1.png")),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50))),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              width: 4,
            ),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TextStory(
                                  users: userW,
                                ),
                              ));
                        },
                        child: const Text(
                          "Text",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ));
                  }
                }),
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
              child: IconButton(
                  onPressed: onCaptureImagePressed,
                  icon: const Icon(Icons.camera_alt)),
            ),
            const Text(
              "Go Live",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            const SizedBox(
              width: 4,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: NotificationListener(
          onNotification: (ScrollNotification scroll) {
            handleScrollEvent(scroll);
            return true;
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 352,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/img_9.png"))),
              ),
              const SizedBox(
                height: 63,
              ),
              InkWell(
                onTap: onCaptureImagePressedG,
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/img_10.png"))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCaptureImagePressed() {
    _captureImage(context);
  }

  void onCaptureImagePressedG() {
    _captureImage(context);
  }

  void _captureImage(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

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
