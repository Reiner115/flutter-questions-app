import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:questions_app/QuestionsAPIManager.dart';
import 'package:questions_app/Screens/HomeScreen.dart';
import 'package:questions_app/Screens/QuestionsScreen.dart';
import 'package:questions_app/bloc/QuestionsBloc/questions_bloc.dart';
import 'package:questions_app/widgets/TestScreen.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- bloc: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- bloc: ${bloc.runtimeType}, change: $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition -- bloc: ${bloc.runtimeType}, transition: $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- bloc: ${bloc.runtimeType}, error: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- bloc: ${bloc.runtimeType}');
  }
}

void main() {
  //Bloc.observer = SimpleBlocObserver();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor:  Color.fromARGB( 220, 8, 54, 118 ),
      ),
      home: Container(
        child: Center(
          child: HomeScreen(),
        ),
      ),
    ),
  );
  //blocMain();
}

void blocMain() async {
  print('----------BLOC----------');

  /// Create a `CounterBloc` instance.
 // final bloc = QuestionsBloc();

  /// Access the state of the `bloc` via `state`.
  //print(bloc.state);

//  bloc.add( GetNextQuestionEvent( false ) );

  /// Wait for next iteration of the event-loop
  /// to ensure event has been processed.
  await Future<void>.delayed(Duration(seconds: 5));

  /// Access the new `state`.
  //print(bloc.state);

  /// Close the `bloc` when it is no longer needed.
  //await bloc.close();
}
