import 'package:cloudmusic/commen/bloc/event/player_event.dart';
import 'package:cloudmusic/commen/bloc/player_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';

class PlayerAudioManager{

  BuildContext context;

  factory PlayerAudioManager.getInstance() => _getInstance();
  static PlayerAudioManager _instance;

  PlayerAudioManager._internal(){

  }

  static PlayerAudioManager _getInstance() {
    if (_instance == null) {
      _instance = PlayerAudioManager._internal();
    }

    return _instance;
  }


  void start(){

  }

  void pause(){

  }

  void next(){
    new Future.delayed(Duration(milliseconds: 1000)).then((value) {
      context.bloc<PlayerBloc>().add(PlayerStartedEvent());

    });
  }

  void pre(){

  }

}