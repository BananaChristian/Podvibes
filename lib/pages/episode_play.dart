import 'package:audioplayers/audioplayers.dart' as audioplayers;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class EpisodePlayPage extends StatefulWidget {
  final String audioUrl;
  final String imageUrl;
  final String episodeTitle;
  final String episodeAuthor;
  final String episodeDetails;
  const EpisodePlayPage({
    super.key, 
    required this.audioUrl, 
    required this.imageUrl, 
    required this.episodeTitle, 
    required this.episodeAuthor, required this.episodeDetails
    });

  @override
  State<EpisodePlayPage> createState() => _EpisodePlayPageState();
}

class _EpisodePlayPageState extends State<EpisodePlayPage> {
  final audioplayers.AudioPlayer _audioPlayer = audioplayers.AudioPlayer();
  bool isPlaying=false;
  bool isPaused=false;
  bool isShown=true;
  Duration _currentPosition=Duration.zero;
  Duration _totalDuration=Duration.zero;

  @override
  void initState(){
    super.initState();
    _audioPlayer.setReleaseMode(ReleaseMode.stop);
    //Listening to position changes
    _audioPlayer.onPositionChanged.listen((Duration position){
      setState((){
        _currentPosition=position;
      });
    });
    //Listening to audio total duration
    _audioPlayer.onDurationChanged.listen((Duration duration){
      setState((){
        _totalDuration=duration;
      });
    });
  }
  @override
  void dispose(){
    _audioPlayer.dispose();
    super.dispose();
  }

  void togglePlayPause() async {
    try{
      if(isPlaying){
        await _audioPlayer.pause();
        setState((){
          isPlaying=false;
          isPaused=true;
        });
      }else{
        await _audioPlayer.play(UrlSource(widget.audioUrl));
        await _audioPlayer.resume();
        setState((){
          isPlaying=true;
          isPaused=false;
        });
      }
    }catch(e){
      debugPrint('Error during playback $e');
    }
  }

  void toggleDescription(){
    if(isShown){
      setState((){
        isShown=!isShown;
        print('Description Toggled: $isShown');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:SingleChildScrollView(
        child: Container(
          padding:const EdgeInsets.all(20),
          color:Theme.of(context).colorScheme.surface,
          child:Column(
            children:[
            //Image
            Container(
              height:250,
              width:double.infinity,
              decoration:BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl),
                  fit:BoxFit.cover
                  ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height:10),
            //Episode title and author
            Text(
              widget.episodeTitle,
              style:TextStyle(color:Theme.of(context).colorScheme.inversePrimary,fontSize: 20,fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height:5),
            Text(
              widget.episodeAuthor,
              style:TextStyle(color:Theme.of(context).colorScheme.inversePrimary,fontSize: 15),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height:20),
            //Player controls
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding:const EdgeInsets.all(20),
                color:Theme.of(context).colorScheme.primary,
                child:Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        //Playback buttons
                        IconButton(
                          onPressed:() async {
                            final newPosition=_currentPosition-const Duration(seconds:30);
                            if(newPosition>Duration.zero){
                              await _audioPlayer.seek(newPosition);
                            }else{
                              await _audioPlayer.seek(Duration.zero);
                            }
                          },
                          icon:const Icon(Icons.fast_rewind,color:Colors.amber),
                          color:Colors.amber
                        ),
                        //Play button
                        IconButton(
                          onPressed:(){
                            togglePlayPause();
                          },
                          icon:Icon(isPlaying?Icons.pause_circle_filled:Icons.play_circle_filled,color:Colors.amber,size:60),
                          color:Colors.amber
                        ),
                        //Play forward button
                        IconButton(
                          onPressed:() async{
                            final newPosition=_currentPosition+const Duration(seconds:30);
                            if(newPosition<_totalDuration){
                              await _audioPlayer.seek(newPosition);
                            }
                          },
                          icon:const Icon(Icons.fast_forward,color:Colors.amber),
                          color:Colors.amber
                        ),
                      ],
                    ),
                    Slider(
                      value:_currentPosition.inSeconds.toDouble(),
                      max:_totalDuration.inSeconds.toDouble(),
                      activeColor: Colors.amber,
                      inactiveColor: Theme.of(context).colorScheme.surface,
                      onChanged: (value) async{
                        //Seeking
                        await _audioPlayer.seek(Duration(seconds:value.toInt()));
                      },
                    ),
                    Text(
                      "${_formatDuration(_currentPosition)}/${_formatDuration(_totalDuration)}",
                      style:const TextStyle(color:Colors.amber,fontSize: 15)
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height:20),
            //Details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                const Text(
                  'Episode details',
                  style:TextStyle(color:Colors.amber,fontSize:12)
                  ),
                IconButton(
                  onPressed:toggleDescription,
                  icon:Icon(isShown?Icons.arrow_drop_down:Icons.arrow_drop_up,color:Colors.amber),
                  color:Colors.amber
                  )
                ]
              ),
              Visibility(
                visible: isShown,
                child: Padding(
                  padding:const EdgeInsets.all(8.0),
                  child: _descriptionSection()
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _descriptionSection(){
    return Card(
      color:Theme.of(context).colorScheme.primary,
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.episodeDetails,
          style:const TextStyle(fontSize:15,),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration){
    String twoDigits(int n)=>n.toString().padLeft(2,'0');
    final minutes=twoDigits(duration.inMinutes.remainder(60));
    final seconds=twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}