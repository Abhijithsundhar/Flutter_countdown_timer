import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final int _duration = 30;
  final CountDownController _controller = CountDownController();
  int status=0;
var ass=  AssetsAudioPlayer.newPlayer();

  late AudioCache audioCache=AudioCache();
  late AudioPlayer audioPlayer;

  void playSound(int status) async {
    final assetsAudioPlayer = AssetsAudioPlayer();
    try {
      if(status==0) {
        // Load audio file

      }
      else if(status==1){
        AssetsAudioPlayer.newPlayer().open(
          Audio("assets/FM9B3TC-alarm.mp3"),
          autoStart: false,
          showNotification: true,
        );
      }else{
        AssetsAudioPlayer.newPlayer().open(
          Audio("assets/FM9B3TC-alarm.mp3"),
          autoStart: true,
          showNotification: true,
        );
      }
      // No need to check the result, since it returns void
    } catch (e) {
      debugPrint("Error playing sound: $e");
    }
  }
  @override
  void initState() {
    super.initState();
    audioCache = AudioCache();
    audioPlayer = AudioPlayer();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title??""),
      ),
      body: Center(
        child: CircularCountDownTimer(
          // Countdown duration in Seconds.
          duration: _duration,

          // Countdown initial elapsed Duration in Seconds.
          initialDuration: 0,

          // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
          controller: _controller,

          // Width of the Countdown Widget.
          width: MediaQuery.of(context).size.width / 2,

          // Height of the Countdown Widget.
          height: MediaQuery.of(context).size.height / 2,

          // Ring Color for Countdown Widget.
          ringColor: Colors.grey[300]!,

          // Ring Gradient for Countdown Widget.
          ringGradient: null,

          // Filling Color for Countdown Widget.
          fillColor: Colors.purpleAccent[100]!,

          // Filling Gradient for Countdown Widget.
          fillGradient: null,

          // Background Color for Countdown Widget.
          backgroundColor: Colors.purple[500],

          // Background Gradient for Countdown Widget.
          backgroundGradient: null,

          // Border Thickness of the Countdown Ring.
          strokeWidth: 20.0,

          // Begin and end contours with a flat edge and no extension.
          strokeCap: StrokeCap.round,

          // Text Style for Countdown Text.
          textStyle: const TextStyle(
            fontSize: 33.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),

          // Format for the Countdown Text.
          textFormat: CountdownTextFormat.MM_SS,

          // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
          isReverse: true,

          // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
          isReverseAnimation: false,

          // Handles visibility of the Countdown Text.
          isTimerTextShown: true,

          // Handles the timer start.
          autoStart: false,

          // This Callback will execute when the Countdown Starts.
          onStart: () {
              debugPrint('Countdown Started');
          },

          // This Callback will execute when the Countdown Ends.
          onComplete: () {
            debugPrint('Countdown Started');
          },

          // This Callback will execute when the Countdown Changes.
          onChange: (String timeStamp) {
              debugPrint('Countdown Changed $timeStamp');

          },

          /*
            * Function to format the text.
            * Allows you to format the current duration to any String.
            * It also provides the default function in case you want to format specific moments
              as in reverse when reaching '0' show 'GO', and for the rest of the instances follow
              the default behavior.
          */
          timeFormatterFunction: (defaultFormatterFunction, duration) {
            if (duration.inSeconds == 0) {
              // only format for '0'
              return "Start";
            } else {
              // other durations by it's default format
              return Function.apply(defaultFormatterFunction, [duration]);
            }
          },
        ),
      ),
      floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 40,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.purple),
              ),
              onPressed: () {
                if(status==0){
                  _controller.start();
                  AssetsAudioPlayer.newPlayer().open(
                    Audio("assets/FM9B3TC-alarm.mp3"),
                    autoStart: true,
                    showNotification: true,
                  );

                  status++;
                  setState(() {

                  });
                }
                else if(status==1){
                  _controller.pause();
                  AssetsAudioPlayer.newPlayer().open(
                    Audio("assets/FM9B3TC-alarm.mp3"),
                    autoStart: false,
                    showNotification: true,
                  );
                  // AssetsAudioPlayer.newPlayer().stop();
                  status++;
                  setState(() {

                  });
                }
                else{
                  _controller.resume();
                  AssetsAudioPlayer.newPlayer().open(
                    Audio("assets/FM9B3TC-alarm.mp3"),
                    autoStart: true,
                    showNotification: true,
                  );

                  setState(() {

                  });
                  status--;
                }



              },
              child: Text(
                status==0? "Start":status==1?"pause":"resume",
                style: const TextStyle(color: Colors.white),
              ),
            )
          ]

      ),
    );
  }

  Widget _button({required String title, VoidCallback? onPressed}) {
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.purple),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}