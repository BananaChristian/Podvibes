import 'package:flutter/material.dart';

class Fields extends StatefulWidget {
  final Color color;
  final String hintText;
  final bool obscureText;
  final Icon icon;
  final TextEditingController controller;

  const Fields({
    super.key,
    required this.color,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    required this.icon,
    });

  @override
  State<Fields> createState() => _FieldsState();
}

class _FieldsState extends State<Fields> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller:widget.controller,
        obscureText: widget.obscureText,
        cursorColor: widget.color,
        decoration:InputDecoration(
          hintText: widget.hintText,
          hintStyle:TextStyle(color:widget.color),
          prefixIcon: widget.icon,
          border:OutlineInputBorder(
            borderRadius:const BorderRadius.only(
              bottomLeft:Radius.circular(10),
              topLeft:Radius.circular(10),
              topRight: Radius.circular(10)
            ),
            borderSide:BorderSide(color:widget.color)
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius:const BorderRadius.only(
              bottomLeft:Radius.circular(10),
              topLeft:Radius.circular(10),
              topRight: Radius.circular(10)
            ),
            borderSide: BorderSide(color:widget.color)
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius:const BorderRadius.only(
              bottomLeft:Radius.circular(10),
              topLeft:Radius.circular(10),
              topRight: Radius.circular(10)
            ),
            borderSide:BorderSide(color:widget.color),
          )
          )
      );
  }
}