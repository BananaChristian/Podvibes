import 'package:flutter/material.dart';
import 'package:podvibes/models/mini_player.dart';
import 'package:podvibes/models/miniplayer_state.dart';
import 'package:podvibes/pages/episode_play.dart';
import 'package:provider/provider.dart';

class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final miniPlayerState=Provider.of<MiniplayerState>(context);
    return Scaffold(
      body:Stack(
        children:[
          EpisodePlayPage(
            audioUrl: miniPlayerState.audioUrl, 
            imageUrl: miniPlayerState.imageUrl, 
            episodeTitle: miniPlayerState.episodeName, 
            episodeAuthor: miniPlayerState.authorName, 
            episodeDetails: miniPlayerState.episodeName
          ),

          if(miniPlayerState.isPlaying)
            MiniPlayer(
              imageUrl: miniPlayerState.imageUrl, 
              audioUrl: miniPlayerState.audioUrl, 
              authorName: miniPlayerState.authorName, 
              episodeName: miniPlayerState.episodeName
            ),
        ],
      ),
    );
  }
}