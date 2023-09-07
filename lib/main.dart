import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ndialog/ndialog.dart';
import 'package:record/record.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:wedme1/getit.dart';
import 'package:wedme1/screens/splash_page.dart';
import 'package:wedme1/utils/flushbar_widget.dart';

Future<void> _firebaseMessageBackgroundHandler(RemoteMessage event) async {
  print("Handler a background message ${event.messageId}");

  // Map message = event.toMap();
  // print('The message ${message.toString()}');

  // var payload = message['data'];
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );

  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessageBackgroundHandler);
  await setup();

  // AwesomeNotifications().initialize(
  //     // set the icon to null if you want to use the default app icon
  //     "assets/images/logo.jpg",
  //     [
  //       NotificationChannel(
  //           channelGroupKey: 'wedMe_chat',
  //           channelKey: 'chat_channel',
  //           channelName: 'Call notification',
  //           channelDescription: 'WedMe call notification',
  //           defaultColor: Color(0xFF9D50DD),
  //           ledColor: Colors.white,
  //           playSound: true,
  //           enableVibration: true,
  //           enableLights: true)
  //     ],
  //     // Channel groups are only visual and are not required
  //     channelGroups: [
  //       NotificationChannelGroup(
  //           channelGroupKey: 'wedMe_chat',
  //           channelGroupName: 'Call notification')
  //     ],
  //     debug: true);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String? notificationTitle;
  @override
  void initState() {
    firebaseRequestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(414, 869),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Sizer(builder: (context, orientation, deviceType) {
            return MaterialApp(
              title: 'Wedfuse',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                brightness: Brightness.light,
                canvasColor: Colors.transparent,
                primarySwatch: Colors.red,
              ),
              home: const SplashScreen(),
              // home: RecordingScreen(),
              // home: WalletHome(),
              // home: GoPremiumHome(),
            );
          });
        });
  }

  Future<void> firebaseRequestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('You are autorized');
    }

    const androidInitialize =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    const iOSinitialize = DarwinInitializationSettings();
    const initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSinitialize);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onDidReceiveNotificationResponse: (value) {

      // },
      // onDidReceiveBackgroundNotificationResponse: (value) {

      // },
    );

    // FirebaseMessaging.instance.setForegroundNotificationPresentationOptions();

    FirebaseMessaging.onMessage.listen((event) async {
      print(
          "onMessage: ${event.notification!.title}/${event.notification!.body}");

      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
          event.notification!.body.toString(),
          htmlFormatBigText: true,
          contentTitle: event.notification!.title.toString(),
          htmlFormatContentTitle: true);

      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails('wedfuse', 'wedfuse',
              importance: Importance.high,
              styleInformation: bigTextStyleInformation,
              priority: Priority.high,
              playSound: true);
      NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);
      await flutterLocalNotificationsPlugin.show(0, event.notification!.title,
          event.notification!.body, notificationDetails,
          payload: event.data['body']);
    });
  }
}

class RecordingScreen extends StatefulWidget {
  const RecordingScreen({super.key});

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  final record = Record();
  String? _filePath;
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    audioPlayer = AudioPlayer()
      ..setUrl(
          'https://firebasestorage.googleapis.com/v0/b/wedme-373214.appspot.com/o/audio-path%2F1684341379820143?alt=media&token=b762a35b-efd4-418e-8a0d-88d8f0554d67');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onLongPress: () {
                  startRecording();
                },
                onLongPressEnd: (val) async {
                  await stopRecording();
                },
                child: Text(
                  'Start Recording',
                  style: TextStyle(color: Colors.red),
                )),
            SizedBox(height: 50),
            GestureDetector(
                onTap: () {
                  upload();
                },
                child: Text(
                  'Upload',
                  style: TextStyle(color: Colors.red),
                )),
            Container(
              height: 100,
              child: StreamBuilder<PlayerState>(
                stream: audioPlayer.playerStateStream,
                builder: (context, snapshot) {
                  final playerState = snapshot.data;
                  final processingState = playerState?.processingState;
                  final playing = playerState?.playing;
                  if (!(playing ?? false)) {
                    return IconButton(
                        onPressed: audioPlayer.play,
                        iconSize: 50,
                        icon: Icon(Icons.play_arrow_rounded));
                  } else if (processingState != ProcessingState.completed) {
                    return IconButton(
                        onPressed: audioPlayer.play,
                        iconSize: 50,
                        icon: Icon(Icons.pause_circle_rounded));
                  }
                  return IconButton(
                      onPressed: audioPlayer.play,
                      iconSize: 50,
                      icon: Icon(Icons.play_arrow_rounded));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> stopRecording() async {
    await record.stop();
  }

  Future<void> startRecording() async {
    if (await record.hasPermission()) {
      Directory directory;

      if (Platform.isIOS) {
        directory = await getTemporaryDirectory();
      } else {
        directory = (await getExternalStorageDirectory())!;
      }
      String filePath =
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.acc';

      await record.start(
        path: filePath,
        encoder: AudioEncoder.AAC, // by default
        bitRate: 128000, // by default
        samplingRate: 44100, // by default
      );

      bool isRecording = await record.isRecording();

      setState(() {
        _filePath = filePath;
      });
    } else {
      if (context.mounted) {
        flushbar(
            context: context,
            title: 'Permission Required',
            message: 'Please enable recording permision',
            isSuccess: false);
      }
    }
  }

  Future<void> upload() async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('audio-path/${DateTime.now().microsecondsSinceEpoch}');
    UploadTask uploadTask = ref.putFile(File(_filePath!));
    uploadTask.showCustomProgressDialog(context);
    final down = await uploadTask.whenComplete(() {});

    final downloadedFile = await down.ref.getDownloadURL();

    print('The downloaded file $downloadedFile');
  }
}
