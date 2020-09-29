import 'package:cloudmusic/commen/bloc/event/player_event.dart';

abstract class PlayerState{
  final Duration currentDuration;
  final Duration maxDuration;

  PlayerState({this.currentDuration, this.maxDuration});
}

///
/// 未开始的状态
///
class PlayerInitialState extends PlayerState{
  final PlayerEvent event;

  PlayerInitialState({this.event}) : super (currentDuration:Duration(), maxDuration:(Duration()));


}

///
/// 正在播放的状态
///
class PlayerRunInProgressState extends PlayerState{

  PlayerRunInProgressState({currentDuration,maxDuration}) : super (currentDuration:currentDuration, maxDuration:maxDuration);
}

///
/// 播放后暂停的状态
///
class PlayerPauseState extends PlayerState{
  PlayerPauseState({currentDuration,maxDuration}) : super (currentDuration:currentDuration, maxDuration:maxDuration);
}

///
/// 播放完成的状态
///
class PlayerCompleteState extends PlayerState{
  PlayerCompleteState() : super (currentDuration:Duration(), maxDuration:(Duration()));
}