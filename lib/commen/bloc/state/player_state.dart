import 'package:cloudmusic/commen/bloc/event/player_event.dart';

abstract class PlayerState{

}

///
/// 未开始的状态
///
class PlayerInitialState extends PlayerState{
  final PlayerEvent event;

  PlayerInitialState({this.event});


}

///
/// 正在播放的状态
///
class PlayerRunInProgressState extends PlayerState{

}

///
/// 播放后暂停的状态
///
class PlayerPauseState extends PlayerState{

}

///
/// 播放完成的状态
///
class PlayerCompleteState extends PlayerState{

}