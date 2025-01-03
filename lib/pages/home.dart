import 'package:flutter/material.dart';
import 'package:podvibes/models/new_podcasts.dart';

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
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
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
        backgroundColor: Colors.black,
        child:ListView(
          padding:const EdgeInsets.all(10),
          children:[
            const DrawerHeader(
              decoration:BoxDecoration(
                borderRadius:BorderRadius.only(
                  topLeft:Radius.circular(20),
                  topRight:Radius.circular(20)
                  ),
                color:Colors.white
              ),
              child:Column(
                children:[
                  CircleAvatar(),
                  SizedBox(height:10),
                  Text(
                    'Welcome User',
                    style:TextStyle(color:Color.fromARGB(255, 0, 0, 0))
                    ),
                ],
              ),
            ),
            //Home
            ListTile(
              leading:const Icon(Icons.home,color:Colors.white),
              title:const Text(
                'Home',
                style:TextStyle(color:Colors.white)
                ),
              onTap:(){}
            ),
            //Downloads
            ListTile(
              leading:const Icon(Icons.download,color:Colors.white),
              title:const Text(
                'Downloads',
                style:TextStyle(color:Colors.white)
                ),
              onTap:(){}
            ),
            //Settings
            ListTile(
              leading:const Icon(Icons.settings,color:Colors.white),
              title:const Text(
                'Settings',
                style:TextStyle(color:Colors.white)
                ),
              onTap:(){}
            ),
            //Logout
            ListTile(
              leading:const Icon(Icons.logout,color:Colors.white),
              title:const Text(
                'Logout',
                style:TextStyle(color:Colors.white)
              ),
              onTap:(){}
              )
          ]
        )
      ),
      body:Container(
        color:const Color.fromARGB(255, 0, 0, 0),
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
          color:isSelected?Colors.amber:Colors.white,
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
    return Text('Recent');
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
                    style:const TextStyle(color:Colors.white)
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
    return Text('Episodes');
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
            color:Colors.black,
            child:ListTile(
              title:Text(
                topics[index],
                style:const TextStyle(color:Colors.white)
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

