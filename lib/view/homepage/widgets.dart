import 'package:flutter/material.dart';

class AddTextField extends StatelessWidget {
  const AddTextField({
    Key? key,
    required this.hintText,
    required this.maxLines, required this.controller,
  }) : super(key: key);
  final String hintText;
  final int maxLines;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field is required';
        } else {
          return null;
        }
      },
      controller: controller ,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2),
            borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2),
            borderRadius: BorderRadius.circular(15)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.red,),
            borderRadius: BorderRadius.circular(15),),
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 2),
               borderRadius: BorderRadius.circular(15),
            ),
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}

class Data extends StatelessWidget {
  const Data({
    Key? key,
    required this.text,
    required this.size,
    required this.weight,
  }) : super(key: key);
  final String text;
  final double size;
  final FontWeight weight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }
}


class SideTitle extends StatelessWidget {
  const SideTitle({
    Key? key, required this.text, required this.size,
  }) : super(key: key);
  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontSize: size, fontWeight: FontWeight.bold));
  }
}
