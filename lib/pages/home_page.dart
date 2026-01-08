import 'package:flutter/material.dart';
import 'package:music_player_app/components/my_drawer.dart';
import 'package:music_player_app/model/playlist_provider.dart';
import 'package:music_player_app/model/song.dart';
import 'package:music_player_app/pages/song_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void gotoSong(int songIndex){
    //update the song index
    context.read<PlaylistProvider>().currentSongIndex = songIndex;
      //navigate to song page
    Navigator.push(context, MaterialPageRoute(builder: (context) =>SongPage() ,));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('P L A Y L I S T'), centerTitle: true),
      drawer: MyDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          final List<Song> playlist = value.playList;
          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              Song song = playlist[index];
              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                leading: Image.asset(song.albumArtImagePath),
                onTap: () {
                  gotoSong(index);
                },
              );
            },
          );
        },
      ),
    );
  }
}
