import 'package:flutter/material.dart';
import 'package:podvibes/objects/controller_buttons.dart';
import 'package:podvibes/objects/my_silver_appbar.dart';

class PodcastPlayer extends StatefulWidget {
  const PodcastPlayer({super.key});

  @override
  State<PodcastPlayer> createState() => _PodcastPlayerState();
}

class _PodcastPlayerState extends State<PodcastPlayer> {
  final episodes=[
    {'name':'Episode 1','title':'Test title 1','size':'40mbs'},
    {'name':'Episode 2','title':'Test title 2','size':'40mbs'},
    {'name':'Episode 3','title':'Test title 3','size':'40mbs'},
  ];

  double currentPosition=0.0;
  double totalDuration=180.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:LayoutBuilder(
        builder:(context,constraints){
          return Stack(
          children: [
            //Main content
            NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled)=>[
                MySilverAppbar(
                  child: Container(
                    padding:const EdgeInsets.all(10),
                    decoration:const BoxDecoration(
                      image: DecorationImage(
                        image:AssetImage('assets/cat.png'),
                        fit: BoxFit.cover
                        )
                    ),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      const SizedBox(height:10),
                      Row(
                        mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                        children: [
                          //Rewind
                          IconButton(
                              onPressed: (){},
                              icon:const Icon(
                                Icons.fast_rewind,
                                color:Colors.amber
                                ),
                          ),
                          const SizedBox(width:10),
                          //Play button
                          ControllerButtons(
                            onTap: (){}, 
                            icon: Icons.play_arrow, 
                            bgColor: Colors.amber, 
                            iconColor: Theme.of(context).colorScheme.primary,
                            size:20
                          ),
                          const SizedBox(width:10),
                          //Forward 
                          IconButton(
                              onPressed: (){},
                              icon:const Icon(
                                Icons.fast_forward,
                                color:Colors.amber
                                ),
                          )
                        ],
                      )
                    ],
                    )
                  )
                ),
              ],
              body:Container(
                padding:const EdgeInsets.all(10),
                color:Theme.of(context).colorScheme.surface,
                child:Column(
                  children:[
                    //The progress bar
                    Slider(
                      value: currentPosition,
                      min:0.0,
                      max:totalDuration,
                      activeColor: Colors.amber,
                      inactiveColor: Theme.of(context).colorScheme.inversePrimary,
                      onChanged:(value){
                        setState((){
                          currentPosition=value;
                        });
                      }
                    ),
                    //Time display
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        Text(
                          _formatTime(currentPosition.toInt()),
                          style:const TextStyle(
                            color:Colors.amber
                          )
                        ),
                        Text(
                          _formatTime(totalDuration.toInt()),
                          style:const TextStyle(
                            color:Colors.amber
                          )
                        )
                      ],
                    ),
                    //Like,comment and dislike counters
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        //Like
                        IconButton(
                          onPressed: (){}, 
                          icon: Icon(
                            Icons.thumb_up,
                            color:Theme.of(context).colorScheme.inversePrimary
                            )
                        ),
                        const SizedBox(width:20),
                        //Comments
                        const Text('Comments'),
                        const SizedBox(width:20),
                        //Dislike
                        IconButton(
                          onPressed: (){}, 
                          icon: Icon(
                            Icons.thumb_down,
                            color:Theme.of(context).colorScheme.inversePrimary
                            )
                        ),
                      ]
                      ),
                    //Description of playing podcast
                    const SizedBox(height:20),
                    //Episode list from channel;
                    Text(
                      'Episodes(${episodes.length})',
                      style:TextStyle(
                        color:Theme.of(context).colorScheme.inversePrimary,
                        fontWeight:FontWeight.bold,
                        fontSize: 20,
                      )
                      ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: episodes.length,
                        itemBuilder: (context,index){
                          final episode=episodes[index];
                          return Card(
                            color:Theme.of(context).colorScheme.primary,
                            child:ListTile(
                              //Play button
                              leading:ControllerButtons(
                                onTap: (){}, 
                                icon: Icons.play_arrow, 
                                bgColor: Colors.amber, 
                                iconColor: Theme.of(context).colorScheme.primary,
                                radius:50,
                                size:10,
                                ),
                              //Title
                              title:Text(
                                episode['name']!,
                                style:TextStyle(
                                  color:Theme.of(context).colorScheme.inversePrimary
                                )
                                ),
                              //Size
                              subtitle: Text(
                                episode['size']!,
                                style:TextStyle(
                                  color:Theme.of(context).colorScheme.inversePrimary
                                )
                                ),
                              //trailing
                              trailing:IconButton(
                                onPressed: (){}, 
                                icon: Icon(
                                Icons.download,
                                color:Theme.of(context).colorScheme.inversePrimary
                                  )
                                ),
                            )
                          );
                        },
                      ),
                    )
                  ]
                ),
                )
              ),
              //Minimizable player bar
              DraggableScrollableSheet(
                initialChildSize: 0.1,
                minChildSize: 0.1,
                maxChildSize: 0.4,
                builder: (context, scrollController){
                  return Container(
                    decoration: BoxDecoration(
                      color:Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.vertical(top:Radius.circular(15)),
                    ),
                    child:Column(
                      children: [
                        //Player Handle
                        Container(
                          width:40,
                          height:5,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color:Colors.grey,
                            borderRadius: BorderRadius.circular(5)
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //The podcast playing
                            const CircleAvatar(
                              backgroundImage:AssetImage('assets/cat.png') ,
                            ),
                            IconButton(
                              onPressed:(){},
                              icon:const Icon(Icons.fast_rewind,color:Colors.amber),
                              ),
                            IconButton(
                              onPressed:(){},
                              icon:const Icon(Icons.play_arrow,color:Colors.amber)
                            ),
                            IconButton(
                              onPressed: (){},
                              icon:const Icon(
                                Icons.fast_forward,
                                color:Colors.amber
                                ),
                              )
                          ],
                          )
                      ],
                    ),
                  );
                }
              )
          ],
        );
        }
      ),
    );
  }
  String _formatTime(int seconds){
      final minutes=seconds~/60;
      final remainingSeconds=seconds%60;
      return '${minutes.toString().padLeft(2,'0')}:${remainingSeconds.toString().padLeft(2,'0')}';
  }
}