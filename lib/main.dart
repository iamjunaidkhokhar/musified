import 'package:flutter/material.dart';
import 'package:musified/Screens/Nowplaying.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Player',
      home: SongScreen(),
      routes: <String, WidgetBuilder>{
        // '/nowplaying': (BuildContext context)=> SongScreen(),
      },
    );
  }
}
