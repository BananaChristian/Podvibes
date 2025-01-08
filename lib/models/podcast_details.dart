import 'package:flutter/material.dart';
//import 'package:podvibes/models/mini_player.dart';
import 'package:podvibes/objects/my_silver_appbar.dart';
import 'package:podvibes/pages/episode_play.dart';
import 'package:podvibes/services/itunes_service.dart';

class PodcastDetails extends StatefulWidget {
  final Map<String, dynamic> podcast;

  const PodcastDetails({super.key, required this.podcast});

  @override
  State<PodcastDetails> createState() => _PodcastDetailsState();
}

class _PodcastDetailsState extends State<PodcastDetails> {
  final itunesService = ItunesService();
  List<dynamic> episodes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEpisodes();
  }

  void fetchEpisodes() async {
  try {
    final collectionId = widget.podcast['collectionId'];
    if (collectionId == null) throw Exception('Invalid podcast id');
    final fetchedEpisodes = await itunesService.fetchEpisodes(collectionId);
    setState(() {
      isLoading = false;
      episodes = fetchedEpisodes;
    });
  } catch (e) {
    setState(() {
      isLoading = false; // Allow empty state.
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        MySilverAppbar(
          child: Container(
            padding:const EdgeInsets.all(10),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.podcast['artworkUrl600']??''),
                  fit: BoxFit.cover),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  widget.podcast['collectionName'] ?? 'Unknown Podcast',
                  style:const TextStyle(fontWeight:FontWeight.bold,fontSize: 20,color:Colors.amber)
                ),
                Text(widget.podcast['artistName']??'Unknown artist',style:const TextStyle(color:Colors.amber))
              ],
            ),
          ),
        ),
      ],
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text('Episodes', style: TextStyle(color: Colors.amber)),
            //Search bar
            //List for episodes
            Expanded(child: _buildEpisodesSection())
          ],
        ),
      ),
    )));
  }

  Widget _buildEpisodesSection() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if(episodes.isEmpty){
      return const Center(child:Text('No episodes available'));
    }

    return ListView.builder(
      itemCount: episodes.length,
      itemBuilder: (context, index) {
        final episode=episodes[index];
        final int durationMillis=episode['trackTimeMillis']??0;
        final String formattedDuration=_formatDuration(durationMillis);
        return Card(
          color:Theme.of(context).colorScheme.primary,
          child:ListTile(
            title:Text(episode['trackName']??'Episode: ${index+1}'),
            subtitle:Text(formattedDuration,style:const TextStyle(color:Colors.amber)),
            trailing: IconButton(
              onPressed:(){
                /*
                Navigator.push(
                context,
                MaterialPageRoute(builder:(context)=>MiniPlayer(
                  audioUrl: episode['previewUrl']??'',
                  imageUrl: widget.podcast['artworkUrl600']??'', 
                  episodeTitle: episode['trackName']??'Unknown title', 
                  episodeAuthor: widget.podcast['artistName']??'Unknown artist', 
                  episodeDetails: episode['description']??'No description available'
                  ))
                );*/
              },
              icon:const Icon(Icons.play_arrow,color:Colors.amber,size:30)
            ),
            onTap:(){
              Navigator.push(
                context,
                MaterialPageRoute(builder:(context)=>EpisodePlayPage(
                  audioUrl: episode['previewUrl']??'',
                  imageUrl: widget.podcast['artworkUrl600']??'', 
                  episodeTitle: episode['trackName']??'Unknown title', 
                  episodeAuthor: widget.podcast['artistName']??'Unknown artist', 
                  episodeDetails: episode['description']??'No description available'
                  ))
                );
            }
          ),
        );
      },
    );
  }

  String _formatDuration(int millis){
    final duration=Duration(milliseconds: millis);
    final hours=duration.inHours;
    final minutes=duration.inMinutes.remainder(60);
    final seconds=duration.inSeconds.remainder(60);

    if (hours > 0) {
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  } else {
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
  }

}
