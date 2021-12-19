part of 'questions_bloc.dart';

abstract class QuestionsEvent extends Equatable {
  const QuestionsEvent();
}

class GetNextQuestionEvent extends QuestionsEvent{

  bool isFirstQuestion;
  bool isRightAnswer;

  GetNextQuestionEvent( this.isFirstQuestion , this.isRightAnswer );

  @override
  List<Object?> get props => [ this.isFirstQuestion , this.isRightAnswer ];

}

class EndOfQuestions extends QuestionsEvent {
  @override
  List<Object?> get props => [];

}
