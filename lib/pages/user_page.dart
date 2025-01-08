import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:podvibes/objects/my_silver_appbar.dart';

class AuthorPage extends StatelessWidget {
  final Map<String, String> author;
  const AuthorPage({super.key,required this.author});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context,innerBoxIsScrolled)=>[
            MySilverAppbar(
              child: Container(
                padding:const EdgeInsets.all(10),
                decoration:BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(author['image']!),
                    fit: BoxFit.cover
                    )
                ),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    const Spacer(),
                    //Name
                    Text(
                      author['name']!,
                      style:const TextStyle(
                        fontWeight:FontWeight.bold,
                        fontSize:30,
                        color:Colors.amber
                        )
                      ),
                    const SizedBox(height:10),
                    //Social media
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.facebook,color:Colors.amber),
                        SizedBox(width:10),
                        Icon(FontAwesomeIcons.instagram,color:Colors.amber),
                        SizedBox(width:10),
                        Icon(FontAwesomeIcons.twitter,color:Colors.amber)
                      ],
                    )
                  ],
                ),
              ),
              )
          ], 
          body: DefaultTabController(
            length: 3,
            child: Container(
              padding:const EdgeInsets.all(10),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  //Follow Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                      style:ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber
                      ),
                      onPressed:(){},
                      child:Text(
                        'Follow',
                        style:TextStyle(color:Theme.of(context).colorScheme.surface)
                      ),
                    ),
                    const Text(
                      '4.8 star rating',
                      style:TextStyle(color:Colors.amber)
                      ),
                    const Icon(
                      Icons.star,
                      color:Colors.amber
                    ),
                  ],
                ),
                const SizedBox(height:20),
                //Description
                Card(
                  color:Theme.of(context).colorScheme.primary,
                  child: Container(
                    padding:const EdgeInsets.all(20),
                    child: Text(author['description']??'No description available')
                  ),
                ),
                const SizedBox(height:10),
                //Tab selection
                TabBar(
                  tabs: const [
                    Tab(text:'Recent'),
                    Tab(text:'Episodes'),
                    Tab(text:'Popular')
                  ],
                  labelColor:Colors.grey,
                  unselectedLabelColor: Theme.of(context).colorScheme.inversePrimary,
                  indicatorColor: Colors.amber,
                ),
            
                Expanded(
                  child: TabBarView(
                      children:[
                        //Tab 1 recent
                        ListView.builder(
                          itemCount:5,
                          itemBuilder:(context,index){
                            return Card(
                              margin: const EdgeInsets.symmetric(horizontal:10,vertical: 5 ),
                              color:Theme.of(context).colorScheme.primary,
                              child:ListTile(
                                leading:const Icon(Icons.play_circle_fill_outlined,color:Colors.amber),
                                title:Text('Episode ${index+1}'),
                                subtitle:Text("Duration: ${10+index} min")
                              ),
                            );
                          } ,
                        ),
                        //Tab 2
                        Text('Episodes'),
                        //Tab 3
                        Text('Popular')
                      ],
                    ),
                ),
                ]
              ),
            ),
          )
        ),
      ),
    );
  }
}