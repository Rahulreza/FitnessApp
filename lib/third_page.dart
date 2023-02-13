import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:day35/home_page.dart';
import 'package:day35/model_class_page.dart';
import 'package:day35/wigets/spinkit_page.dart';

import 'package:flutter/material.dart';

class ThirdPage extends StatefulWidget {
  ThirdPage({Key? key, this.exercise, this.second}) : super(key: key);

  final Exercise? exercise;
  int? second;

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();
  bool isPlaying = false;
  bool isComplete = false;
  int startSound = 0;
  late Timer timer;
  String musicPath = "assets/music.mp3";

  playAudio() async {
    // await audioCache.load(musicPath);
    // await audioPlayer.play(AssetSource(musicPath));
  }

  @override
  void initState() {
    // TODO: implement initState
    // playAudio();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      var x = widget.second !-1;

      print("${x}");

      if (timer.tick == widget.second) {
        timer.cancel();
        setState(() {
          //isPlaying = true;
          playAudio();
          showToast("WorkOut Succesfull");
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
        });
      }
      setState(() {
        startSound = timer.tick;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Center(child: Text("Count Down:$startSound",style: TextStyle(fontSize: 18),)),

            CachedNetworkImage(
              width: double.infinity,
              imageUrl: "${widget.exercise!.gif}",
              fit: BoxFit.cover,
              placeholder: (context, url) => spinkit,
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),

          ],
        ),
      ),
    );
  }
}

alartDialog(){
  return AlertDialog(
    title: Text('Congratulations!'),           // To display the title it is optional
    content: Text('Workout Sucessfull'),   // Message which will be pop up on the screen
// Action widget which will provide the user to acknowledge the choice
    actions: [

      TextButton(

        onPressed: () {},
        child: Text('Ok'),
      ),
    ],
  );
}