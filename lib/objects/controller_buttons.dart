import 'package:flutter/material.dart';

class ControllerButtons extends StatefulWidget {
  final VoidCallback onTap;
  final Icon icon;
  final Color iconColor;
  final Color bgColor;
  final double size;

  const ControllerButtons({
    super.key,
    required this.onTap,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
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
          borderRadius:BorderRadius.circular(50),
          color:widget.bgColor
        ),
        child:widget.icon,
      ),
    ); 
  }
}