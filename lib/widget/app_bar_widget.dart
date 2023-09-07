import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/constants/colors.dart';

import '../screens/Profile/profile_screen/profile_screen.dart';

class CustomAppbar {
  static PreferredSize appBar({BuildContext? context}) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: Padding(
        padding: const EdgeInsets.only(right: 18, left: 20),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context!).push(
                          MaterialPageRoute(
                              builder: ((context) => const ProfileScreen())),
                        );
                      },
                      child: CircleAvatar(
                        radius: 28,
                        backgroundImage: const AssetImage(
                            'assets/images/rectangle_image_bg.png'),
                        child: Stack(
                          children: const [
                            Positioned(
                              bottom: -8,
                              right: -8,
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.transparent,
                                child: Icon(
                                  Icons.verified,
                                  color: Color.fromRGBO(0, 87, 255, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Image.asset(
                        'assets/images/webfuse-logo.png',
                        height: 100,
                        width: 100,
                      ),
                    ),
                    const Icon(
                      Icons.tune,
                      size: 35,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static matchScreenAppBar(BuildContext context,
      {Size? size, required String? photoUrl}) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: ((context) => const ProfileScreen())),
              );
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: kPrimaryColor,
              backgroundImage: NetworkImage(photoUrl??""),
              // const AssetImage('assets/images/rectangle_image_bg.png'),
              child: Stack(
                children: const [
                  Positioned(
                    bottom: -12,
                    right: -12,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Icons.verified,
                        size: 14,
                        color: Color.fromRGBO(0, 87, 255, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: (size!.width / 3) * 0.9),
            child: SizedBox(
              child: Image.asset(
                'assets/images/webfuse-logo.png',
                height: 100,
                width: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static PreferredSize conversationAppBar(
      {BuildContext? context, String? name}) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(110),
      child: Padding(
        padding: const EdgeInsets.only(right: 8, left: 10),
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 2, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.arrow_back_ios,
                      ),
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: const AssetImage(
                            'assets/images/rectangle_image_bg.png'),
                        child: Stack(
                          children: const [
                            Positioned(
                              bottom: -8,
                              right: -8,
                              child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.transparent,
                                  child: Image(
                                      image: AssetImage(
                                          "assets/icons/online_icon.png"))),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Jane',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        )),
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundImage:
                            const AssetImage("assets/icons/red_curve_bg.png"),
                        child: Image.asset("assets/icons/video_call_icon.png"),
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundImage:
                            const AssetImage("assets/icons/red_curve_bg.png"),
                        child: Image.asset("assets/icons/wifi_icon.png"),
                      ),
                      const Icon(Icons.more_vert),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

AppBar simpleAppBar(BuildContext context, [bool multiPop = false]) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    leading: GestureDetector(
      onTap: multiPop
          ? () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            }
          : () => Navigator.pop(context),
      child: const Padding(
        padding: EdgeInsets.only(left: 20, bottom: 2),
        child: CircleAvatar(
          radius: 15,
          backgroundColor: kPrimaryColor,
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

AppBar customAppbar(BuildContext context, String title,
    {bool isPop =false, bool isRedBg = true, List<Widget>? actions}) {
  return AppBar(
    
    automaticallyImplyLeading: false,
    backgroundColor: isRedBg ? kPrimaryColor : Colors.white,
    leading: GestureDetector(
      onTap:() {
        Navigator.of(context).pop();
      },
      child: Container(
        margin: const EdgeInsets.all(12),
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          color: isRedBg ? Colors.white : kPrimaryColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          Icons.arrow_back,
          color: isRedBg ? kPrimaryColor : Colors.white,
          size: 18,
        ),
      ),
    ),
    centerTitle: true,
    title: Text(
      title,
      style: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: isRedBg ? Colors.white : const Color(0xFF010101)),
    ),
    elevation: 0.0,
    actions: actions,
  );
}
