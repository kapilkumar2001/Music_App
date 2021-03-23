import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flute_music_player/flute_music_player.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  List<Song> _songs;
  MusicFinder audioPlayer;

  @override
  void initState(){
    super.initState();
    initPlayer();
  }

  void initPlayer() async{
    audioPlayer = new MusicFinder();
    var songs = await MusicFinder.allSongs();
    //songs = new List.from(songs);
    setState(() {
      _songs = songs;
    });
  }

  Future _playLocal(String url) async{
    final result = await audioPlayer.play(url,isLocal: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Music'.text.make(),
      ),
      body: new ListView.builder(
          itemCount : _songs.length,
          itemBuilder:(context,int index)
          {
            return new ListTile(
              leading: new CircleAvatar(
                child: new Text(_songs[index].title[0]),
              ),
              title: new Text(_songs[index].title),
              onTap: ()=> _playLocal(_songs[index].uri),
            );
          },
      ),
    );
  }
}
