import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:podvibes/models/podcast_details.dart';

class PodcastSlider extends StatefulWidget {
  final List<Map<String,dynamic>> podcasts;

  const PodcastSlider({
    super.key,
    required this.podcasts
    });

  @override
  State<PodcastSlider> createState() => _PodcastSliderState();
}

class _PodcastSliderState extends State<PodcastSlider> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height:200,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        viewportFraction: 0.8,
        aspectRatio: 16/9
      ),
      items:widget.podcasts.map((podcast){
        return Builder(
          builder:(BuildContext context){
            return GestureDetector(
              onTap:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>PodcastDetails(podcast: podcast))
                );
              },
              child:ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft:Radius.circular(20),
                  topRight:Radius.circular(20),
                  bottomLeft:Radius.circular(20)
                ),
                child:Stack(
                  children:[
                    Image.network(
                      podcast['artworkUrl600']??"",
                      width:double.infinity,
                      height:double.infinity,
                      fit:BoxFit.cover
                    ),
                  ],
                )
              ),
            );
          }
        );
      }).toList()
    );
  }
}