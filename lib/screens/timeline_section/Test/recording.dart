import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class RecordingScreen extends StatefulWidget {
  @override
  _RecordingScreenState createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  FlutterSoundPlayer _player = FlutterSoundPlayer();

  bool _isRecording = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _recorder.openRecorder();
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    super.dispose();
  }
  String filePath = 'test.mp3';
  String newd="";

  Future<void> _record() async {
    try {
      String path = await getTemporaryDirectory().then((d) => d.path);
      String getS = join(path+filePath);
      await _recorder.startRecorder(toFile: "audio.mp3");
      setState(() {
        _isRecording = true;
      });
      newd = getS;
    } catch (e) {
      print(e);
    }
  }

  Future<void> _stop() async {
    try {
      String? audioFilePath = await _recorder.stopRecorder();
      //await _recorder.closeRecorder();

      //String audioFilePath = _recorder.stopRecorder()?.path;
      print('Audio file path: $newd$audioFilePath');
    } catch (e) {
      print(e);
    }
  }

  Future<void> _play() async {
    try {
      await _player.startPlayer(fromURI: 'test.mp3');
      setState(() {
        _isPlaying = true;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _stopPlaying() async {
    try {
      await _player.stopPlayer();
      setState(() {
        _isPlaying = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Recording Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: _record,
              child: Text('Record'),
            ),
            TextButton(
              onPressed: _stop,
              child: Text('stop'),
            ),
          ],
        ),
      ),
    );
  }
}
