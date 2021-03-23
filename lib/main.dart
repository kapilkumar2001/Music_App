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
      debugShowCheckedModeBanner: false,
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
  bool playing=false;
  String last;
  bool isLoading= true;

  @override
  void initState(){
    super.initState();
    initPlayer();
  }

  void initPlayer() async{
    audioPlayer = new MusicFinder();
    var songs = await MusicFinder.allSongs();
    setState(() {
      _songs = songs;
    });
    last = _songs[0].uri;
    isLoading = false;
  }

  Future _playLocal(String url) async{
    last = url;
    final result = await audioPlayer.play(url,isLocal: true);
    playing = true;
    setState(() {});
  }
  Future pause() async {
    final result = await audioPlayer.pause();
    playing=false;
    setState(() {});
  }
  Future stop() async {
    final result = await audioPlayer.stop();
    playing=false;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Music'.text.make(),
      ),
      body: isLoading? Center(child : CircularProgressIndicator()):new ListView.builder(
          itemCount : _songs.length,
          itemBuilder:(context, index)
          {
            return new ListTile(
              leading: new CircleAvatar(
                child: new Text(_songs[index].title[0]),
              ),
              title: new Text(_songs[index].title),
              onTap: ()=> {stop(), _playLocal(_songs[index].uri), playing= true},
            );
          },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:()=> playing? {pause(), Icon(Icons.play_arrow)}: {_playLocal(last),Icon(Icons.pause)},
        splashColor: Colors.redAccent,
        backgroundColor: Colors.blue,
        child: (playing)?Icon(Icons.pause):Icon(Icons.play_arrow),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 'Made with ❤️ by Kapil'.text.color(Colors.purple).make(),
              ]
        ),
      ),
    );
  }
}


