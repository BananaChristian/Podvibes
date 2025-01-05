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
      actions:const [
        Icon(
          Icons.add,
          color:Colors.amber
          )
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