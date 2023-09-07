import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedme1/constants/colors.dart';
class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VideoCallScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/video_call_bg.png"),
                  fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.white10,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, bottom: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset("assets/images/video_call_img.png"),
                              ],
                            ),
                          ),
                          Text(
                            "Shawn Cater",
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          Text(
                            "Calling",
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: (size.height / 3),
                ),
                Container(
                  width: 200,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(10), left: Radius.circular(10)),
                    color: Colors.white10,

                    // image: DecorationImage(
                    //     image: AssetImage("assets/icons/video_bg.png"))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: kPrimaryColor,
                          radius: 22,
                          child:
                              Image.asset("assets/icons/video_call_icon.png"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 22,
                          backgroundImage:
                              const AssetImage("assets/icons/oval_gray.png"),
                          child: Image.asset("assets/icons/speaker_plus.png"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 22,
                          backgroundImage:
                              const AssetImage("assets/icons/oval_gray.png"),
                          child: Image.asset("assets/icons/square.png"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}





//
//
// class AgoraTokenGenerator {
//   static Future<String> generateToken(String appId, String appCertificate,
//       String channelName, int uid, int expirationTimeInSeconds) async {
//     final rtmTokenBuilder = AgoraRtmTokenBuilder();
//     rtmTokenBuilder.appId = appId;
//     rtmTokenBuilder.appCertificate = appCertificate;
//     rtmTokenBuilder.userId = uid.toString();
//     rtmTokenBuilder.role = RtmTokenBuilderRole.Rtm_User;
//     rtmTokenBuilder.channelName = channelName;
//     rtmTokenBuilder.expireTimestamp = expirationTimeInSeconds;
//
//     final token = await rtmTokenBuilder.buildToken();
//     return token;
//   }
// }
//
// void main() async {
//   // Initialize the Agora SDK
//   final appId = "your_app_id";
//   final appCertificate = "your_app_certificate";
//   final channelName = "your_channel_name";
//   final uid = 0;
//   final expirationTimeInSeconds = 3600;
//
//   final token = await AgoraTokenGenerator.generateToken(
//       appId, appCertificate, channelName, uid, expirationTimeInSeconds);
//
//   print("Token: $token");
// }



