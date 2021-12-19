import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:questions_app/model/Question.dart';
import 'package:questions_app/util/Consts.dart';
import 'package:rive/rive.dart';

class QuestionWidget extends StatefulWidget {
  QuestionWidget(this.question, this.onNextQuestionPressed,
      this.currentQuestionsCount, this.currentScore);

  Function(bool isRightAnswer) onNextQuestionPressed;
  Question question;
  int currentQuestionsCount;
  int currentScore;

  @override
  State<StatefulWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  List<String> answers = [];
  bool didAnswerTheQuestion = false;
  bool didChooseTheRightAnswer = false;
  bool firstTimeForAnswer = true;


  bool firstTime = true;

  void reset() {
    answers = [];
    didAnswerTheQuestion = false;
    didChooseTheRightAnswer = false;
    firstTimeForAnswer = true;
    firstTime = true;
  }

  void init() {
    if (firstTime) {
      firstTime = false;
      answers = widget.question.incorrectAnswers;
      answers.add(widget.question.correctAnswer);
      answers.shuffle();
    }
  }

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    init();
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(16),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //IconButton( icon: Icon( Icons.cancel , color : Colors.red , size : 40 ), onPressed: (){ Navigator.of(context).pop(); },),
              Text(
                "Score : ${widget.currentScore}/${widget.currentQuestionsCount} ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
             // Container()
            ],
          )
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.question.question,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            listOfAnswers(),
            nextQuestionButton()
          ],
        ),
      ],
    );
  }



  Widget listOfAnswers() {
    return Container(
      height: 320,

      child: ListView.builder(
        shrinkWrap: true ,
          physics: NeverScrollableScrollPhysics() ,
          itemCount: answers.length,
          itemBuilder: (context, index) {
            if (answers[index] == widget.question.correctAnswer) {
              return answer(answers[index], true);
            } else {
              return answer(answers[index], false);
            }
          }),
    );
  }

  Widget answer(String ans, bool isCorrectAnswer) {
    return InkWell(
      onTap: () {
        if( firstTimeForAnswer )
        setState(() {
          if (isCorrectAnswer) {
            didChooseTheRightAnswer = true;
          }else{

          }
          didAnswerTheQuestion = true;
          runAudioSound(isCorrectAnswer);
          firstTimeForAnswer = false;
        });
      },
      child: Container(

        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          //border:  didAnswerTheQuestion ? ( Border.all(color: isCorrectAnswer ? (Colors.green) : (Colors.red) , width: 1 , style: BorderStyle.solid ) ) : ( Border.symmetric(vertical : BorderSide.none , horizontal: BorderSide.none) )  ,
          color: Color.fromARGB(255, 17, 21, 36),
          borderRadius: BorderRadius.circular( 8 )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Text(
              ans,
              style: TextStyle(color: Colors.white, fontSize: 20),
              overflow: TextOverflow.ellipsis,
            ),
            didAnswerTheQuestion
                ? (isCorrectAnswer
                    ? Icon(
                        Icons.done,
                        color: Colors.green,
                        size: 32,
                      )
                    : Icon(
                        Icons.cancel,
                        color: Colors.red,
                        size: 32,
                      ))
                : Container()
          ],
        ),
      ),
    );
  }

  void runAudioSound(bool didChooseTheRightAnswer) {
    String assetName = Consts.RIGHT_ANSWER_SOUND_EFFECT;
    if (didChooseTheRightAnswer) {
      assetName = Consts.RIGHT_ANSWER_SOUND_EFFECT;
    } else {
      assetName = Consts.WRONG_ANSWER_SOUND_EFFECT;
    }
    if( didAnswerTheQuestion )
    AssetsAudioPlayer.newPlayer().open(
      Audio(assetName),
      showNotification: false,
    );
  }

  Widget nextQuestionButton() {
    return Container(
      margin: EdgeInsets.all(8),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: didAnswerTheQuestion
                ? Color.fromARGB(255, 234, 145, 55)
                : Color.fromARGB(200, 234, 145, 55),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 64),
          ),
          onPressed: () {
            if (didAnswerTheQuestion) {
              widget.onNextQuestionPressed(didChooseTheRightAnswer);
              reset();
            }
          },
          child: Text("Next Question",
              style: TextStyle(color: didAnswerTheQuestion ? Colors.white : Colors.grey[300], fontSize: 20))),
    );
  }
}
