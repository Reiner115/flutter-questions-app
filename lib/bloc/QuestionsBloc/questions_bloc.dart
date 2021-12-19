import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:questions_app/QuestionsAPIManager.dart';
import 'package:questions_app/model/Question.dart';

part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  QuestionsBloc( this.numberOfQestions , this.category , this.difficulty , this.type ) : super( QuestionsInitial() );

  int numberOfQestions;
  int category;
  String difficulty;
  String type;

  static int score = 0;
  QuestionsAPIManager questionsAPIManager = QuestionsAPIManager();
  List<Question> questionsList = [];
  int questionCounter = 0;

  @override
  Stream<QuestionsState> mapEventToState(
    QuestionsEvent event,
  ) async* {

    if( event is GetNextQuestionEvent ){
      yield*  mapGetNextQuestionEventToState( event );
    }

  }

  Stream<QuestionsState> mapGetNextQuestionEventToState( GetNextQuestionEvent event ) async* {
    if( questionsList.isEmpty   ){
      yield QuestionsLoading();
      try {
        await getMoreQuestionsFromApi();
      }on SocketException catch ( ex ){
        yield QuestionErrorState( "could not connect to the internet , please check your internet connection and  try again " );
        return;
      }catch( e ){
        yield QuestionErrorState( "something went wrong , please try again" );
        return;
      }
    }

    if(  questionsList.length == questionCounter ){
      yield EndOfQuestionsState( score ,  questionCounter );
      return;
    }

    if( event.isFirstQuestion ){
    }else{
      if( event.isRightAnswer ){
        score++;
      }
    }

    yield NewQuestions( questionsList[ questionCounter++ ] , score  , questionCounter );
  }


  Future<void> getMoreQuestionsFromApi() async {
    List<Question> list = await questionsAPIManager.getQuestions( amount: this.numberOfQestions , category: this.category , difficulty: this.difficulty  , type: this.type  );
    questionsList.addAll( list );
  }


}
