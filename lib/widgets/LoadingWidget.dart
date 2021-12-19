
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:questions_app/util/Consts.dart';

class LoadingWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {

  final List<String> loading = [ "Loading" , "Loading." , "Loading.." , "Loading..." , "Loading...." , "Loading....." ];
  int counter = 0;
  final int milliseconds = 300;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(  Duration( milliseconds:  milliseconds ) , (timer) {
      if( this.mounted )
      setState(() {
        counter++;
        if( counter == loading.length ){
          counter = 0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset( Consts.LOADING_IMAGE , fit: BoxFit.cover, ),
        SizedBox( height: 10 ,),
        Text( loading[ counter ] , style: TextStyle( fontSize: 40 , fontWeight: FontWeight.bold , color: Colors.white ),)
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer!.cancel();
  }
}