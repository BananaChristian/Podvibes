import 'package:flutter/material.dart';

class MySilverAppbar extends StatelessWidget {
  final Widget child;
  final VoidCallback onFollow;
  final bool isFollowing;

  const MySilverAppbar({
    super.key,
    required this.child, required this.onFollow, required this.isFollowing,
    });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions:[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed:onFollow,
            style:ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            child:Text(isFollowing?'Unfollow':'Follow',style:TextStyle(color:Theme.of(context).colorScheme.primary))
          ),
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