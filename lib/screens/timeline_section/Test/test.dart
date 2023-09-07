
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class Testa extends StatefulWidget {
  const Testa({Key? key}) : super(key: key);

  @override
  State<Testa> createState() => _TestaState();
}

class _TestaState extends State<Testa> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    iniRecorder();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //recorder.closeRecorder();
  }


  final  recorder = FlutterSoundRecorder();
  Future iniRecorder()async{
    final status = await Permission.microphone.request();
    if(status!=PermissionStatus.granted){
      throw "Permission not granted";
    }else{
      print("permission granted");
    }
    await recorder.onProgress;
    // recorder.setSubscriptionDuration(const Duration(microseconds: 5000));
  }



  Future startRecording()async{
    await recorder.startRecorder(toFile: "${DateTime.now().millisecondsSinceEpoch}");

  }

  Future stopRecording()async{
    final filePath = await recorder.stopRecorder();
    final file = Uri.file(filePath!);
    print("hello this is the link to the audio $file");
  }


    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      body: StreamBuilder<RecordingDisposition>(
        stream: recorder.onProgress,
        builder: (context, snapshot) {
          final dur = snapshot.hasData?Duration.zero:snapshot.data?.duration;
          String twoDigit(int n)=>n.toString().padLeft(2, "0");
         // final towDigitMin = twoDigit(dur.inMinutes.remainder(60));
         // final twoDigiSec = twoDigit(dur.inSeconds.remainder(60));

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${dur?.inSeconds}"),
                ElevatedButton(onPressed: ()async {
                  if(recorder.isRecording){
                    await stopRecording();
                  }else{
                    await startRecording();
                  }

                  setState(() {

                  });
                }, child: Icon(recorder.isRecording?Icons.stop:Icons.mic)),
              ],
            ),
          );
        }
      ),
    );
  }
}
