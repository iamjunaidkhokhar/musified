import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musified/widgets/pause.dart';

class SongScreen extends StatefulWidget {
  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen>
    with SingleTickerProviderStateMixin {
  AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String currentTime = "00:00";
  String completeTime = "00:00";
  double firstOffset = 5.0;
  double secondOffset = -5.0;
  AudioCache audioCache;
  Duration _duration = Duration();
  Duration _position = Duration();
  AnimationController _animationController;
  int status;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: new Duration(seconds: 5),
    );

    _audioPlayer.onAudioPositionChanged.listen((Duration duration) {
      setState(() {
        currentTime = duration.toString().split(".")[0];
      });
    });

    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        completeTime = duration.toString().split(".")[0];
      });
    });

    initPlayer();
  }

  void initPlayer() {
    audioCache = AudioCache(fixedPlayer: _audioPlayer);

    _audioPlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });

    _audioPlayer.positionHandler = (p) => setState(() {
          _position = p;
        });
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    _audioPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0XFF2e2e2e),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      SystemNavigator.pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0XFF2e2e2e),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            colors: [Color(0XFF1c1c1c), Color(0XFF383838)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0XFF1c1c1c),
                              offset: Offset(5.0, 5.0),
                              blurRadius: 10.0,
                            ),
                            BoxShadow(
                              color: Color(0XFF404040),
                              offset: Offset(-5.0, -5.0),
                              blurRadius: 10.0,
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(1.5),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                colors: [Color(0XFF303030), Color(0XFF1a1a1a)]),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: Colors.white38,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    "PLAYING NOW",
                    style: TextStyle(
                      color: Colors.white38,
                      letterSpacing: 0.25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () async {
                      String filePath = await FilePicker.getFilePath();
                      status = await _audioPlayer.play(filePath, isLocal: true);

                      if (status == 1) {
                        setState(() {
                          isPlaying = true;
                          _animationController.repeat();
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0XFF2e2e2e),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            colors: [Color(0XFF1c1c1c), Color(0XFF383838)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0XFF1c1c1c),
                              offset: Offset(5.0, 5.0),
                              blurRadius: 10.0,
                            ),
                            BoxShadow(
                              color: Color(0XFF404040),
                              offset: Offset(-5.0, -5.0),
                              blurRadius: 10.0,
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(1.5),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                colors: [Color(0XFF303030), Color(0XFF1a1a1a)]),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Icon(
                              Icons.menu,
                              size: 30,
                              color: Colors.white38,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0XFF212121),
                boxShadow: [
                  BoxShadow(
                    color: Color(0XFF1c1c1c),
                    offset: Offset(15.0, 15.0),
                    blurRadius: 22.0,
                  ),
                  BoxShadow(
                    color: Color(0XFF404040),
                    offset: Offset(-15.0, -15.0),
                    blurRadius: 22.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (BuildContext context, Widget _widget) {
                    return Transform.rotate(
                      angle: _animationController.value * 6.3,
                      child: _widget,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/chester.jpg")),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "YOUR MUSIC ",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white70,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  WidgetSpan(
                      child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Icon(
                      Icons.explicit,
                      color: Colors.white54,
                      size: 10,
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Close Your Eyes and Enjoy..!",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white54,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: <Widget>[
                  Text(
                    currentTime,
                    style: TextStyle(
                      color: Colors.white60,
                    ),
                  ),
                  Spacer(),
                  Text(
                    completeTime,
                    style: TextStyle(
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
            Slider(
              activeColor: Colors.orange,
              onChanged: (double value) {
                setState(() {
                  seekToSecond(value.toInt());
                  value = value;
                });
              },
              value: _position.inSeconds.toDouble(),
              max: _duration.inSeconds.toDouble(),
              min: 0.0,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: <Widget>[
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      _audioPlayer.stop();
                      setState(() {
                        currentTime = "00:00";
                        isPlaying = false;
                        isPlaying
                            ? _animationController.repeat()
                            : _animationController.stop();
                        seekToSecond(0);
                      });
                    },
                    child: pausePlay(Icons.stop),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        if (status == 1) {
                          if (isPlaying && status == 1) {
                            _audioPlayer.pause();

                            setState(() {
                              isPlaying = false;
                              _animationController.stop();
                            });
                          } else {
                            _audioPlayer.resume();

                            setState(() {
                              isPlaying = true;
                              _animationController.repeat();
                            });
                          }
                        } else {
                          print("Nothing");
                        }
                      },
                      child: isPlaying && status == 1
                          ? pausePlay(Icons.pause)
                          : pausePlay(Icons.play_arrow)),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
