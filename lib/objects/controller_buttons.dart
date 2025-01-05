import 'package:flutter/material.dart';

class ControllerButtons extends StatefulWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final double size;
  final double radius;

  const ControllerButtons({
    super.key,
    required this.onTap,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    this.radius=50,
    this.size=50
    });

  @override
  State<ControllerButtons> createState() => _ControllerButtonsState();
}

class _ControllerButtonsState extends State<ControllerButtons> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:widget.onTap,
      child:Container(
        padding:const EdgeInsets.all(20),
        decoration:BoxDecoration(
          borderRadius:BorderRadius.circular(widget.radius),
          color:widget.bgColor
        ),
        child:Icon(
          widget.icon,
          color:widget.iconColor,
          size:widget.size
          ),
      ),
    ); 
  }
}