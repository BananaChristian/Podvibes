import 'package:flutter/material.dart';
import 'package:podvibes/audio/audio_player_provider.dart';
import 'package:podvibes/pages/episode_play.dart';
import 'package:provider/provider.dart';

class MiniPlayer extends StatelessWidget {
  final String audioUrl;
  final String episodeTitle;
  final String episodeAuthor;
  final String imageUrl;
  final String episodeDetails;

  const MiniPlayer({super.key, required this.audioUrl, required this.episodeTitle, required this.episodeAuthor, required this.imageUrl, required this.episodeDetails});

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayerProvider>(
      builder:(context,playerProvider,child){
        return Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap:(){
              Navigator.push(
                context,
                MaterialPageRoute(builder:(context)=>EpisodePlayPage(
                  audioUrl: audioUrl, 
                  imageUrl: imageUrl, 
                  episodeTitle: episodeTitle, 
                  episodeAuthor: episodeAuthor, 
                  episodeDetails: episodeDetails
                  )
                ),
              );
            },
            child:Container(
              color:Theme.of(context).colorScheme.primary,
              padding:const EdgeInsets.all(10),
              child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        CircleAvatar(
                          backgroundImage: NetworkImage(imageUrl),
                        ),
                        //Playback buttons
                        IconButton(
                          onPressed:() async {
                          },
                          icon:const Icon(Icons.skip_previous,color:Colors.amber),
                          color:Colors.amber
                        ),
                        //Play button
                        IconButton(
                          onPressed:(){
                            playerProvider.togglePlayPause(audioUrl);
                          },
                          icon:Icon(playerProvider.isPlaying?Icons.pause_circle_filled:Icons.play_circle_filled,color:Colors.amber,size:60),
                          color:Colors.amber
                        ),
                        //Play forward button
                        IconButton(
                          onPressed:() async{
                          },
                          icon:const Icon(Icons.skip_next,color:Colors.amber),
                          color:Colors.amber
                        ),
                      ],
                    ),
            ),
          
          ),
        );
      }
    );
  }
}