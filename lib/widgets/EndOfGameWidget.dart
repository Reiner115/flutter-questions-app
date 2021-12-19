import 'package:flutter/material.dart';
import 'package:questions_app/util/Consts.dart';
import 'package:questions_app/widgets/DoneButton.dart';

class EndOfGameWidget extends StatefulWidget{

  EndOfGameWidget(  this.score );
  String score;

  @override
  State<StatefulWidget> createState() => _EndOfGameWidgetState();

}

class _EndOfGameWidgetState extends State<EndOfGameWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.score,
          style: TextStyle( fontSize: 40 , fontWeight: FontWeight.bold , color: Colors.white ),
        ),
        Image.asset( Consts.CONFUSED_MAN_IMAGE  , fit: BoxFit.cover ,),
        SizedBox( height: 10 ,),
        DoneButton(text: "Done", onpressed: (){
          Navigator.of(context).pop();
        } )


      ],
    );
  }

}