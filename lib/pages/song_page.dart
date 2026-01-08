import 'package:flutter/material.dart';
import 'package:music_player_app/components/neu_box.dart';
import 'package:music_player_app/model/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});


  //convert duration into min:sec
  String formatTime(Duration duration){
    String twoDigitSecond = duration.inSeconds.remainder(60).toString();
    String formattedTime = "${duration.inMinutes}:$twoDigitSecond";

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        //get playlist
        final playlist = value.playList;
        //get current song index
        final currentSong = playlist[value.currentIndex ?? 0];
        
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //arrow icon
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back_outlined),
                    ),
                    //song name
                    Text(
                      'P L A Y L I S T',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    //menu
                    Icon(Icons.menu),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                child: NeuBox(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(currentSong.albumArtImagePath),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              bottom: 15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentSong.songName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(currentSong.artistName),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.favorite, color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(formatTime(value.currentDuration)),
                  Icon(Icons.shuffle),
                  Icon(Icons.repeat),
                  Text(formatTime(value.totalDuration)),
                ],
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
                  ),
                  child: Slider(
                    min: 0,
                    max: value.totalDuration.inSeconds.toDouble(),
                    value: value.currentDuration.inSeconds.toDouble(),
                    activeColor: Colors.green,
                    onChanged: (value) {

                    },
                    onChangeEnd: (double double) {
                      // sliding has finished,go to that position in song duration
                      value.seekTheSong(Duration(seconds: double.toInt()));
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 15,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: value.playPreviousSong,
                        child: NeuBox(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Icon(Icons.skip_previous),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: value.pauseAndResume,
                        child: NeuBox(
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Icon(value.isPlaying ? Icons.pause : Icons.play_arrow),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: value.playNextSong,
                        child: NeuBox(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Icon(Icons.skip_next),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
