import 'package:flutter/material.dart';
import 'package:podvibes/objects/fields.dart';

class SearchBoard extends StatefulWidget {
  const SearchBoard({super.key});

  @override
  State<SearchBoard> createState() => _SearchBoardState();
}

class _SearchBoardState extends State<SearchBoard> {
  final TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color:Theme.of(context).colorScheme.primary,
          padding:const EdgeInsets.all(10),
          child:Column(
            children:[
              //Search bar
              Fields(
                color: Theme.of(context).colorScheme.inversePrimary, 
                hintText: 'Search anything', 
                obscureText: false, 
                controller: searchController, 
                icon: Icon(
                  Icons.search,
                  color:Theme.of(context).colorScheme.inversePrimary, 
                  )
                )
              //Results
            ]
          ),
        ),
      ),
    );
  }
}