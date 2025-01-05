import 'package:flutter/material.dart';
import 'package:podvibes/objects/controller_buttons.dart';

class NewPodcast extends StatefulWidget {
  final String image;
  final String?hoverText;
  final VoidCallback onTap;

  const NewPodcast({
    super.key,
    required this.image,
    this.hoverText,
    required this.onTap,
    });

  @override
  State<NewPodcast> createState() => _NewPodcastState();
}

class _NewPodcastState extends State<NewPodcast> {
  bool _isHovered=false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:widget.onTap,
      child: MouseRegion(
        onEnter:(_)=>setState(()=>_isHovered=true),
        onExit:(_)=>setState(()=>_isHovered=false),
        child: ClipRRect(
          borderRadius:const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topLeft:Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: SizedBox(
            width:277,
            height:182,
            child: Stack(
              children: [
                Container(
                decoration:BoxDecoration(
                  image:DecorationImage(
                    image:AssetImage(widget.image),
                    fit:BoxFit.cover
                    ),
                )
              ),
              if(_isHovered && widget.hoverText!=null)
                Container(
                  color:Colors.black.withOpacity(0.5),
                  alignment: Alignment.center,
                  child:Column(
                    children:[
                      Padding(
                        padding: const EdgeInsets.only(top:55.0),
                        child: ControllerButtons(
                          onTap:(){},
                          icon:Icons.play_arrow,
                          bgColor:Theme.of(context).colorScheme.inversePrimary,
                          iconColor:Theme.of(context).colorScheme.primary,
                          size:25
                        ),
                      )
                    ],
                  ),
                )
              ]
            ),
          ),
        ),
      )
      );
  }
}