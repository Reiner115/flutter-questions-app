import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoneButton extends StatelessWidget{

  DoneButton( { required this.text , required this.onpressed } );
  String text;
  Function() onpressed;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 234, 145, 55),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      ),
      onPressed: this.onpressed ,
      child: Text(
        this.text  ,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

}