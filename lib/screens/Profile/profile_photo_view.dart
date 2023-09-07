import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ProfilePhotView extends StatelessWidget {
  final String imageUrl;
  const ProfilePhotView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black,
      ),
      body: PhotoView(
        imageProvider: NetworkImage(imageUrl),
        initialScale: 0.5,
      ),
    );
  }
}
