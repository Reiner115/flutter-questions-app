
import 'dart:convert';

import 'package:html_character_entities/html_character_entities.dart';
import 'package:http/http.dart' as http;
import 'package:questions_app/model/Question.dart';

class QuestionsAPIManager{


  // -1 means that no specific type has been chosen
  Future< List<Question> > getQuestions({ required int amount , int? category  , String? difficulty , String? type }) async {

    String host = "https://opentdb.com/api.php?";
    String urlParameters = "encode=base64";

    urlParameters += "&amount=$amount";

    if( category != null  && category != -1 ){
      urlParameters += "&category=$category";
    }

    if( difficulty != null && difficulty != "any" && difficulty != "" ){
      urlParameters += "&difficulty=$difficulty";
    }

    if( type != null  && type != "any" && type != "" ){
      urlParameters += "&bool=$type";
    }

    String completeUrl = host+urlParameters;

    print( completeUrl );

    var url = Uri.parse( completeUrl );
    var response = await http.get( url );
    if( response.statusCode == 200 ){

      final result   = jsonDecode( response.body );
      Iterable iterable = result["results"];
      List<Question> list  = List<Question>.from( iterable.map((e) => Question.fromJson( e ) ) );
      List<Question> decodedList = [];
      list.forEach(( question ) {
        decodedList.add( decodeQuestion(question) );
      });
      return decodedList;
    }else{
      throw Exception("could not get questions from the internet , please check your internet connection and try again");
    }
  }


  Question decodeQuestion( Question question ){
    List<String> answers = [];
    question.incorrectAnswers.forEach(( answer ) {
      answers.add(   decode( answer )    );
    });
    question.incorrectAnswers = answers;

    //
    question.correctAnswer = decode( question.correctAnswer ) ;
    question.question = decode(question.question);
    question.category = decode(question.category);
    question.difficulty = decode(question.difficulty);
    question.type = decode(question.type );

    return question;
  }

  String decode( String str ){
    return  utf8.decode ( base64.decode( str ) );
  }

}