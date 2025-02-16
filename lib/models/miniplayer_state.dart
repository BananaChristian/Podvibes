import 'package:flutter/material.dart';

class MiniplayerState with ChangeNotifier{
  bool isPlaying=false;
  String audioUrl='';
  String imageUrl='';
  String episodeName='';
  String authorName='';

  void setMiniPlayer({
    required bool playing,
    required String audio,
    required String image,
    required String episode,
    required String author,
  }){
    isPlaying=playing;
    audioUrl=audio;
    imageUrl=image;
    episodeName=episode;
    authorName=author;
    notifyListeners();
  }

  void togglePlayPause(){
    isPlaying=!isPlaying;
    notifyListeners();
  }
}