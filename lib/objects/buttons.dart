import 'package:flutter/material.dart';

class MyButtons extends StatefulWidget {
  final Color color;
  final String text;
  final Color textColor;
  final VoidCallback onTap;

  const MyButtons({
    super.key,
    required this.color,
    required this.text,
    required this.textColor,
    required this.onTap
    });

  @override
  State<MyButtons> createState() => _MyButtonsState();
}

class _MyButtonsState extends State<MyButtons> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:widget.onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child:Container(
          alignment: Alignment.center,
          padding:const EdgeInsets.all(10),
          width:double.infinity,
          color:widget.color,
          child:Text(
            widget.text,
            style:TextStyle(
              color:widget.textColor,
            ),
          ),
        ),
        ),
    );
  }
}