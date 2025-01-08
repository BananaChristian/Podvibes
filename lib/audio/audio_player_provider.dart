import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerProvider with ChangeNotifier{
  final AudioPlayer _audioPlayer=AudioPlayer();
  bool isPlaying=false;
  Duration currentPosition=Duration.zero;
  Duration totalDuration=Duration.zero;

  AudioPlayer get audioPlayer=>_audioPlayer;

  void play(String url) async{
    if(!isPlaying){
      await _audioPlayer.play(UrlSource(url));
      isPlaying=true;
      notifyListeners();
    }
  }

  void pause() async{
    if(isPlaying){
      await _audioPlayer.pause();
      isPlaying=false;
      notifyListeners();
    }
  }

  void togglePlayPause(String url){
    if(isPlaying){
      pause();
    }else{
      play(url);
    }
  }

  void seekTo(Duration position){
    currentPosition=position;
    notifyListeners();
  }

  void updateDuration(Duration duration){
    totalDuration=duration;
    notifyListeners();
  }

  
}