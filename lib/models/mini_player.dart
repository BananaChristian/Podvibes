import 'package:audioplayers/audioplayers.dart' as audioplayers;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:podvibes/pages/episode_play.dart';

class MiniPlayer extends StatefulWidget {
  final String imageUrl;
  final String audioUrl;
  final String authorName;
  final String episodeName;

  const MiniPlayer(
      {super.key,
      required this.imageUrl,
      required this.audioUrl,
      required this.authorName,
      required this.episodeName});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  bool isPlaying = true;
  final audioplayers.AudioPlayer _audioPlayer = audioplayers.AudioPlayer();
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _setupAudioPlayer();
  }

  void _setupAudioPlayer() {
    _audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        _currentPosition = position;
      });
    });

    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        _totalDuration = duration;
      });
    });
  }

  void togglePlayPause() async {
    try {
      if (isPlaying) {
        await _audioPlayer.pause();
        setState(() {
          isPlaying = false;
        });
      } else {
        await _audioPlayer.play(UrlSource(widget.audioUrl));
        setState(() {
          isPlaying = true;
        });
      }
    } catch (e) {
      print('Error toggling playback: $e');
    }
  }

  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: GestureDetector(
          onTap:(){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:(context)=>EpisodePlayPage(
                  audioUrl: widget.audioUrl, 
                  imageUrl: widget.imageUrl, 
                  episodeTitle: widget.episodeName, 
                  episodeAuthor: widget.authorName, 
                  episodeDetails: ''))
            );
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              children: [
                //Controller buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Thumbnail
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child:Image.network(
                        widget.imageUrl,
                        height: 50,
                        width:50,
                        fit:BoxFit.cover
                      ),
                    ),
                    //Rewind button
                    IconButton(
                        icon: const Icon(Icons.fast_rewind, color: Colors.amber),
                        onPressed: () {}),
                    //Play button
                    IconButton(
                      icon: isPlaying
                          ? const Icon(Icons.play_circle_fill,
                              color: Colors.amber)
                          : const Icon(Icons.pause_circle_filled,
                              color: Colors.amber),
                      onPressed: () {},
                    )
                  ],
                ),
                const SizedBox(height:10),
                Expanded(
                  child:Column(
                    children: [
                      //Title
                      Text(widget.episodeName,style:TextStyle(color:Theme.of(context).colorScheme.inversePrimary,overflow:TextOverflow.ellipsis)),
                      //Slider
                      Slider(
                        value:_currentPosition.inSeconds.toDouble(),
                        max:_totalDuration.inSeconds.toDouble(),
                        activeColor: Colors.amber,
                        inactiveColor: Theme.of(context).colorScheme.surface,
                        onChanged:(value) async{
                          await _audioPlayer.seek(Duration(seconds:value.toInt()));
                        }
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
