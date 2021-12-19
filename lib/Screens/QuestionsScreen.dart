import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questions_app/bloc/QuestionsBloc/questions_bloc.dart';
import 'package:questions_app/model/Question.dart';
import 'package:questions_app/util/Consts.dart';
import 'package:questions_app/widgets/DoneButton.dart';
import 'package:questions_app/widgets/EndOfGameWidget.dart';
import 'package:questions_app/widgets/LoadingWidget.dart';
import 'package:questions_app/widgets/QuestionWidget.dart';

class QuestionsScreen extends StatelessWidget {
  QuestionsScreen(
      this.numberOfQuestions, this.category, this.difficulty, this.type) {
    bloc = QuestionsBloc(numberOfQuestions, category, difficulty, type);
  }

  String difficulty;
  int numberOfQuestions;
  String type;
  int category;

  QuestionsBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          background(),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.9,
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.fromLTRB(8, 40, 8, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color.fromARGB(220, 8, 54, 118),
            ),
            child: SingleChildScrollView(
              child: Container(
                child: BlocConsumer<QuestionsBloc, QuestionsState>(
                  bloc: bloc,
                  listener: (_, __) {},
                  builder: (context, state) {
                    if (state is NewQuestions) {
                      return QuestionWidget(
                          state.question,
                          onPressingNextQuestionutton,
                          state.numberOfQuestions,
                          state.currentScore);
                    } else if (state is QuestionsInitial) {
                      bloc!.add(GetNextQuestionEvent(true, false));
                      return Container();
                    } else if (state is QuestionsLoading) {
                      return LoadingWidget();
                    } else if (state is QuestionErrorState) {
                      return ErrorWidget(state.errorMessage);
                    } else if (state is EndOfQuestionsState) {
                      return EndOfGameWidget(
                        "Score : ${state.score}/${state.totlaMark}",
                      );
                    } else {
                      return Text("nothing to show");
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget background() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Consts.QUESTION_SCREEN_BG_IMAGE),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void onPressingNextQuestionutton(bool lastQuestionAnswerResult) {
    bloc!.add(GetNextQuestionEvent(false, lastQuestionAnswerResult));
  }
}

class ErrorWidget extends StatefulWidget {
  ErrorWidget(this.message);
  String message;

  @override
  State<StatefulWidget> createState() => _ErrorWidgetState();
}

class _ErrorWidgetState extends State<ErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 400,
          margin: EdgeInsets.symmetric(horizontal: 8),
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 300,
                    width: 300,
                    child: Text(
                      widget.message,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
              DoneButton(
                  text: "OK",
                  onpressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          )),
        ),
      ],
    );
  }
}
