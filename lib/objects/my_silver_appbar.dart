import 'package:flutter/material.dart';

class MySilverAppbar extends StatelessWidget {
  final Widget child;

  const MySilverAppbar({
    super.key,
    required this.child,
    });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions:[
        ElevatedButton(
          onPressed:(){},
          style:ElevatedButton.styleFrom(backgroundColor: Colors.amber),
          child:Text('Follow',style:TextStyle(color:Theme.of(context).colorScheme.primary))
        ),
      ],
      expandedHeight: 300,
      collapsedHeight: 80,
      floating:false,
      pinned:true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      flexibleSpace: FlexibleSpaceBar(background: child,),
    );
  }
}