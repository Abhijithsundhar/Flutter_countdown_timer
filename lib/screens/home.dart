
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:fk_toggle/fk_toggle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:timer/main.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
int select=0;
int count=0;
int text=0;
  final int _duration = 30;
  final CountDownController _controller = CountDownController();
  int status=0;
var ass=  AssetsAudioPlayer.newPlayer();



  void playSound(int status) async {
     final assetsAudioPlayer = AssetsAudioPlayer();
    try {
      if(status==0) {
        // Load audio file
        AssetsAudioPlayer.newPlayer().open(
          Audio("assets/FM9B3TC-alarm.mp3"),
          autoStart: true,
          showNotification: true,

        );

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
    // audioCache = AudioCache();
    // audioPlayer = AudioPlayer();
  }
  @override
  Widget build(BuildContext context) {

    final OnSelected selected = ((index, instance) {
      count=index;
      setState(() {

      });
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

    });
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back,color: Colors.white,),
        title:  Text('Mindful Meal timer',style: TextStyle(color: Colors.grey[600]),),
        backgroundColor: Colors.black12,
      ),
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            AnimatedSmoothIndicator(
              activeIndex: select,
              count: 3,
              effect: WormEffect(dotColor: Colors.grey,activeDotColor: Colors.white),
            ),
            SizedBox(height: height*.03,),
            text == 0?
            Column(
              children: [
                Text('Time to eat mindfully',style: TextStyle(color: Colors.grey[600]),),
                Text("It's simple  : eat slowly for ten minutes,rest \n "
                    "for five,then finish your meal ",style: TextStyle(color: Colors.grey[600]),
                )],
            ):
            text == 1?
            Column(
              children: [
                Text('Nom nom :)',style: TextStyle(color: Colors.grey[600]),),
                Text(" you have 10 minutes to eat before the \n"
                    "pause focus on eating slowly ",style: TextStyle(color: Colors.grey[600]),
                )],
            ): Text ==2 ?
            Column(
              children: [
                Text('Break Time',style: TextStyle(color: Colors.grey[600]),),
                Text(" Take a five-minute break to check in on your level of fullness ",style: TextStyle(color: Colors.grey[600]),
                )],
            ):Column(
              children: [
                Text('Finish your meal',style: TextStyle(color: Colors.grey[600]),),
                Text(" you can eat untill you feel full ",style: TextStyle(color: Colors.grey[600]),
                )],
            ),
            Center(
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
                fillColor: Colors.green,

                // Filling Gradient for Countdown Widget.
                fillGradient: null,

                // Background Color for Countdown Widget.
                backgroundColor: Colors.grey,

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
                    setState(() {
                      text++;
                    });
                },

                // This Callback will execute when the Countdown Ends.
                onComplete: () {

                  print(status);
                  setState(() {
                    status=0;
                    select++;
                  });
                  debugPrint('Countdown ended');
                },

                onChange: (String timeStamp) {
                    debugPrint('Countdown Changed $timeStamp');

                },
                timeFormatterFunction: (defaultFormatterFunction, duration) {
                  if (duration.inSeconds == 0) {
                    // only format for '0'
                    return
                         "00:30";
                  } else {
                    // other durations by it's default format
                    return
                        Function.apply(defaultFormatterFunction, [duration]);

                  }
                },
              ),
            ),
            FkToggle(
              width: 30,
              height: 30,
              backgroundColor: Colors.green,
              selectedColor: Colors.white,
              disabledElementColor: Colors.green,
              enabledElementColor: Colors.white,
              cornerRadius: 20,
              onSelected:selected, labels: ["",""], ),
            Text(count==0?"Sound off":"sound on",style: TextStyle(color: Colors.white)),
            InkWell(
              onTap: () async {

                if(status==0){
                  // final player = AudioPlayer();
                  // await player.setAudioSource(AudioSource.uri(Uri.parse(
                  //     "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3")));// Create a player
                  //  // await player.setUrl(           // Load a URL
                  //  //    'assets/FM9B3TC-alarm.mp3');
                  // await player.play();
                  playSound(0);
                  _controller.start();

                  status++;

                  setState(() {

                  });
                }
                else if(status==1){
                  _controller.pause();
                  playSound(1);
                  // AssetsAudioPlayer.newPlayer().stop();
                  status++;
                  setState(() {

                  });
                }
                else{
                  _controller.resume();
                  playSound(2);
                  // player.resume();

                  setState(() {
                  });
                  status--;
                }
              },
              child: Container(
                width: 300,
                height: 60,
                decoration: BoxDecoration(
                    color:  Colors.green.shade100,
                    borderRadius: BorderRadius.circular(20)
                ),

                child: Center(
                  child: Text(status==0? "Start":status==1?"Pause":"Resume",

                    style:  TextStyle(color: Colors.purple,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
           status>0? Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color:  Colors.grey
                ),

                  borderRadius: BorderRadius.circular(20)
              ),

              child: Center(
                child: GestureDetector(
                  onTap: (){
                    _controller.start();
                  },
                  child:  Text("LET'S STOP I'M FULL NOW",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ):const SizedBox(),
          ],
        ),
      ),
    );
  }

  // Widget _button({required String title, VoidCallback? onPressed}) {
  //   return Expanded(
  //     child: ElevatedButton(
  //       style: ButtonStyle(
  //         backgroundColor: MaterialStateProperty.all(Colors.purple),
  //       ),
  //       onPressed: onPressed,
  //       child: Text(
  //         title,
  //         style: const TextStyle(color: Colors.white),
  //       ),
  //     ),
  //   );
  // }
}