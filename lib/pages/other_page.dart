import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:podvibes/models/podcast_details.dart';
import 'package:podvibes/services/itunes_service.dart';

class OthersSectionPage extends StatefulWidget {
  final String topic;
  const OthersSectionPage({
    super.key,
    required this.topic
    });

  @override
  State<OthersSectionPage> createState() => _OthersSectionPageState();
}

class _OthersSectionPageState extends State<OthersSectionPage> {
  bool isLoading=false;
  List<dynamic> podcasts=[];

  @override
  void initState(){
    super.initState();
    _fetchTopicalPodcasts();
  }

  void _fetchTopicalPodcasts()async{
    if(widget.topic.isEmpty) throw Exception('Sorry this topic is not available');
    try{
      final fetchPodcasts=await ItunesService().fetchPodcasts(widget.topic);
      setState((){
        podcasts=fetchPodcasts;
        isLoading=false;
      });
    }catch(e){
      setState((){
        isLoading=true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(),
      body:SafeArea(
        child: Container(
          padding:const EdgeInsets.all(10),
          child:Column(
            children:[
              //Category name
              Text(
                widget.topic,
                style:const TextStyle(
                  color:Colors.amber,
                  fontSize: 20,
                  fontWeight:FontWeight.bold
                ),
                ),
              const SizedBox(height:10),
              //Grid Cards for the category
              Expanded(child:_buildMainSection()),
            ],
          ),
        ),
      ),
    );
  }

  _buildMainSection(){
    if (isLoading){
      return const Center(child:CircularProgressIndicator());
    }

    if (podcasts.isEmpty){
      return const Center(child:Text('No podcasts available for this topic'));
    }

    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          ), 
        itemCount: podcasts.length,
        itemBuilder: (context,index){
          final podcast=podcasts[index];
          return GestureDetector(
            onTap:(){
              Navigator.push(
                context,
                MaterialPageRoute(builder:(context)=>PodcastDetails(podcast: podcast)),
              );
            },
            child: Card(
              color:Theme.of(context).colorScheme.primary,
              child:Stack(
                children:[
                  Positioned.fill(
                    child:Image.network(
                      podcast['artworkUrl600']??'',
                      fit:BoxFit.cover,
                      errorBuilder: (context,error,stackTrace)=>Container(
                        color:Colors.grey,
                        child:const Icon(FontAwesomeIcons.podcast,size:50,color:Colors.grey)
                      ),
                    ),
                  ),
                  //Text
                  Positioned(
                    bottom:0,
                    left:0,
                    right:0,
                    child:Container(
                      color:Colors.black.withOpacity(0.6),
                      child:Column(
                        children: [
                          Text(
                            podcast['collectionName']??'Unknown author',
                            style:const TextStyle(
                              color:Colors.white70,
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis
                            )
                            ),
                          Text(
                            podcast['artistName']??'Unknown artist',
                            style:const TextStyle(
                              color:Colors.white70,
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis
                            )
                            )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}