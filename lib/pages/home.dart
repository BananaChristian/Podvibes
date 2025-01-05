import 'package:flutter/material.dart';
import 'package:podvibes/models/new_podcasts.dart';
import 'package:podvibes/objects/controller_buttons.dart';
import 'package:podvibes/pages/settings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedSection='Recent';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions:[
          Container(
            padding:const EdgeInsets.all(10),
            child: const Row(
              children:[
                Icon(
                Icons.search,
                color:Color.fromARGB(255, 221, 218, 218)
                ),       
              ],
            ),
          ),
        ],
      ),
      drawer:Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child:ListView(
          padding:const EdgeInsets.all(10),
          children:[
            DrawerHeader(
              decoration:BoxDecoration(
                borderRadius:const BorderRadius.only(
                  topLeft:Radius.circular(20),
                  topRight:Radius.circular(20)
                  ),
                color:Theme.of(context).colorScheme.inversePrimary
              ),
              child:Column(
                children:[
                  const CircleAvatar(),
                  const SizedBox(height:10),
                  Text(
                    'Welcome User',
                    style:TextStyle(color:Theme.of(context).colorScheme.primary)
                    ),
                ],
              ),
            ),
            //Home
            ListTile(
              leading:Icon(Icons.home,color:Theme.of(context).colorScheme.inversePrimary),
              title:Text(
                'Home',
                style:TextStyle(color:Theme.of(context).colorScheme.inversePrimary)
                ),
              onTap:(){}
            ),
            //Downloads
            ListTile(
              leading:Icon(Icons.download,color:Theme.of(context).colorScheme.inversePrimary),
              title:Text(
                'Downloads',
                style:TextStyle(color:Theme.of(context).colorScheme.inversePrimary)
                ),
              onTap:(){}
            ),
            //Settings
            ListTile(
              leading:Icon(Icons.settings,color:Theme.of(context).colorScheme.inversePrimary),
              title:Text(
                'Settings',
                style:TextStyle(color:Theme.of(context).colorScheme.inversePrimary)
                ),
              onTap:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder:(context)=>const SettingsPage())
                );
              }
            ),
            //Logout
            ListTile(
              leading:Icon(Icons.logout,color:Theme.of(context).colorScheme.inversePrimary),
              title:Text(
                'Logout',
                style:TextStyle(color:Theme.of(context).colorScheme.inversePrimary)
              ),
              onTap:(){}
              )
          ]
        )
      ),
      body:Container(
        color:Theme.of(context).colorScheme.surface,
        padding:const EdgeInsets.all(10),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                padding:const EdgeInsets.all(20),
                alignment: Alignment.center,
                decoration:BoxDecoration(
                  borderRadius:const BorderRadius.only(
                    bottomLeft:Radius.circular(50),
                  ),
                    image:DecorationImage(
                    image:const AssetImage('assets/bg_home.png'),
                    fit:BoxFit.cover,
                    colorFilter:ColorFilter.mode(
                      Colors.black.withOpacity(0.8),
                      BlendMode.dstATop
                    )
                    ),
                    ),
                child:Column(
                  children:[
                    const Text(
                      'New Podcasts',
                      textAlign:TextAlign.center,
                      style:TextStyle(
                        color:Colors.white,
                        fontSize:20
                        ),
                      ),
                    NewPodcast(
                      image:'assets/cat.png',
                      hoverText: 'Cats',
                       onTap: (){}
                      ),
                    const SizedBox(height:20),
                  ],
                ),
              ),
            ),
            //Main section
            const SizedBox(height:10),
            const SizedBox(height:10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                _buildSectionToggle('Recent'),
                const SizedBox(width:20),
                _buildSectionToggle('Topics'),
                const SizedBox(width:20),
                _buildSectionToggle('Authors'),
                const SizedBox(width:20),
                _buildSectionToggle('Episodes'), 
            ]),
            const SizedBox(height:20),
            //Section content
            Expanded(child:_buildSectionContent())
          ],
        ),
      ),
    );
  }
  //Widget to create toggeable section
  Widget _buildSectionToggle(String section){
    bool isSelected =selectedSection ==section;

    return GestureDetector(
      onTap:(){
        setState((){
          selectedSection=section;
        });
      },
      child:Text(
        section,
        style:TextStyle(
          color:isSelected?Colors.amber:Theme.of(context).colorScheme.inversePrimary,
          fontWeight:isSelected?FontWeight.bold:FontWeight.normal,
          fontSize: isSelected?18:16
        )
      ),
    );
  }
  //Widget for the section content
  Widget _buildSectionContent(){
    switch (selectedSection){
      case 'Recent':
        return _buildRecentSection();
      case 'Topics':
        return _buildTopicsList();
      case 'Authors':
        return _buildAuthorsSection();
      case 'Episodes':
        return _buildEpisodesSection();
      default:
        return const SizedBox.shrink();
    }
  }
  
  Widget _buildRecentSection(){
    final recentPodcasts=[
      {'title':'Tech today','description':'Latest in the world of technology','image':'assets/tech_today.png'},
      {'title':'History Hour','description':'Dive into the wonderful of history ','image':'assets/history_hour.png'}
    ];

    return ListView.builder(
      itemCount:recentPodcasts.length,
      itemBuilder: (context,index){
        final podcast=recentPodcasts[index];
        return Card(
          color:Colors.amber,
          child:ListTile(
            leading:Image.asset(podcast['image']!),
            title:Text(
              podcast['title']!,
              style:TextStyle(
                color:Theme.of(context).colorScheme.primary,
                fontWeight:FontWeight.bold
                )
              ),
            subtitle:Text(
              podcast['description']!,
              style:TextStyle(
                color:Theme.of(context).colorScheme.primary,
              ),
              ),
            onTap:(){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(podcast['title']!)));
            }
          )
        );
      },
    );
  }

  Widget _buildAuthorsSection(){
    final authors=[
      {'name': 'Alice Smith', 'image': 'assets/author1.png'},
      {'name': 'John Doe', 'image': 'assets/author2.png'},
      {'name': 'Jane Roe', 'image': 'assets/author3.png'},
      {'name': 'Chris Brown', 'image': 'assets/author4.png'},
      {'name': 'Emily White', 'image': 'assets/author5.png'},
      {'name': 'Michael Green', 'image': 'assets/author6.png'},
    ];

    return Padding(
      padding:const EdgeInsets.all(8.0),
      child:GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing:10,
          mainAxisSpacing: 10
          ),
        itemCount: authors.length,
        itemBuilder: (context,index){
          final author=authors[index];
          return GestureDetector(
            onTap:(){},
            child:Container(
              decoration:const BoxDecoration(
                borderRadius:BorderRadius.only(
                  topLeft:Radius.circular(20),
                  topRight:Radius.circular(20)
                ),
              ),
              child:Column(
                children:[
                  CircleAvatar(
                    backgroundImage: AssetImage(author['image']!),
                    radius: 40,
                  ),
                  const SizedBox(height:10),
                  Text(
                    author['name']!,
                    style:TextStyle(color:Theme.of(context).colorScheme.inversePrimary)
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  

  Widget _buildEpisodesSection(){
    final episodes=[
      {'title':'Episode 1 : Getting started','duration':'30 mins'},
      {'title':'Episode 2 : Advanced topics','duration':'45 mins'}
    ];

    return ListView.builder(
      itemCount:episodes.length,
      itemBuilder: (context,index){
        final episode=episodes[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading:ControllerButtons(
              icon:Icons.play_arrow,
              bgColor:Colors.amber,
              iconColor: Theme.of(context).colorScheme.primary,
              size:10,
              onTap:(){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(episode['title']!)));
              }
            ),
            title:Text(episode['title']!),
          ),
        );
      },
    );
  }

  Widget _buildTopicsList(){
    final topics=[
      'Lifestyle',
      'Science',
      'Technology',
      'Business',
      'History',
      'News',
      'Sports',
      'Entertainment',
      'Health and Fitness',
      'Education'
    ];

    return ListView.builder(
      itemCount: topics.length,
      itemBuilder: (context,index){
        return Padding(
          padding:const EdgeInsets.symmetric(vertical:5.0),
          child:Card(
            color:Colors.amber,
            child:ListTile(
              title:Text(
                topics[index],
                style:TextStyle(color:Theme.of(context).colorScheme.primary)
              ),
              onTap:(){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Selected topics: ${topics[index]}')));
              }
            ),
          )
        );
      },
    );
  }
}

