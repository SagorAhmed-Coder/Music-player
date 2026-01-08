import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_player_app/model/song.dart';

class PlaylistProvider extends ChangeNotifier {
  //all the song
  final List<Song> _playlist = [
    //song one
    Song(
      songName: 'Porsche Panam',
      artistName: 'Lota Mahesh',
      albumArtImagePath: 'assets/images/girls.jpg',
      audioPath: 'audio/club.mp3',
    ),
    //song two
    Song(
      songName: 'wined laggy',
      artistName: 'Mark Sugar',
      albumArtImagePath: 'assets/images/sager.jpg',
      audioPath: 'audio/same.mp3',
    ),
    //song three
    Song(
      songName: 'Porsche Panam',
      artistName: 'achene laggy',
      albumArtImagePath: 'assets/images/10595559.jpg',
      audioPath: 'audio/global.mp3',
    ),
  ];

  int? _currentSongIndex;

  //getters
  List<Song> get playList => _playlist;
  int? get currentIndex => _currentSongIndex;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  //setters
  set currentSongIndex(int? newIndex) {
    //update current song index
    if (_currentSongIndex != newIndex) {
      _currentSongIndex = newIndex;
      play();
      notifyListeners();
    }
  }

  //-------------------------------------
  //audio player
  final AudioPlayer _audioPlayer = AudioPlayer();
  //durations
  Duration _totalDuration = Duration.zero;
  Duration _currentDuration = Duration.zero;
  //constructor
  PlaylistProvider() {
    listenToDuration();
  }
  // initially not playing
  bool _isPlaying = false;
  //play the song
  void play() async {
    final String path = _playlist[currentIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  //pause current song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  //resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  //pause and resume
  void pauseAndResume() {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
  }

  //seek to specific position in the current song
  void seekTheSong(Duration newPositon) {
    _audioPlayer.seek(newPositon);
  }

  //play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        //go to the next song if its not the last song
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        //if its last song loop back to the first song
        currentSongIndex = 0;
      }
    }
  }

  //play previous song
  void playPreviousSong() {
    //if more 2 seconds have passed , restart the current song
    if (_currentDuration.inSeconds > 2) {
      seekTheSong(Duration.zero);
    }
    //if its within first 2 second of the song, go to previous song
    else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        // if its the first song , loop back to last song
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  //listen to duration
  void listenToDuration() {
    //listen to total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });
    //listen to current duration
    _audioPlayer.onPositionChanged.listen((newPositon) {
      _currentDuration = newPositon;
      notifyListeners();
    });
    //listen for song complete
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }
  //dispose audio player
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  //-------------------------------------
}
