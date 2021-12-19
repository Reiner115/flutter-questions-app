part of 'questions_bloc.dart';

abstract class QuestionsState extends Equatable {
  const QuestionsState();
}


class QuestionsLoading extends QuestionsState{
  @override
  List<Object?> get props => [];
}
class QuestionsInitial extends QuestionsState {
  @override
  List<Object> get props => [];
}

class NewQuestions extends QuestionsState{

  Question question;
  int currentScore;
  int numberOfQuestions;
  NewQuestions(  this.question , this.currentScore , this.numberOfQuestions );

  @override
  List<Object?> get props => [ this.question , this.currentScore , this.numberOfQuestions ];

}

class QuestionErrorState extends QuestionsState{
  String errorMessage;
  QuestionErrorState( this.errorMessage );
  @override
  List<Object?> get props => [ this.errorMessage ];
}

class EndOfQuestionsState extends QuestionsState{

  EndOfQuestionsState( this.score , this.totlaMark );

  int score;
  int totlaMark;

  @override
  List<Object?> get props => [ this.score , this.totlaMark ];

}
