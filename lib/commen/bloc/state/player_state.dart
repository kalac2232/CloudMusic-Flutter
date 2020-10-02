import 'package:cloudmusic/commen/bloc/event/player_event.dart';
import 'package:cloudmusic/discovery/bean/song_bean.dart';
import 'package:cloudmusic/player/play_list_manager.dart';

abstract class PlayerState{
  final SongBean songBean;

  PlayerState({this.songBean});
}

///
/// 未开始的状态
///
class PlayerInitialState extends PlayerState{
  final PlayerEvent event;

  PlayerInitialState({this.event}) : super (songBean:PlayListManager.getInstance().getCurrentSong());


}

///
/// 正在播放的状态
///
class PlayerRunInProgressState extends PlayerState{

  final Duration currentDuration;
  final Duration maxDuration;

  PlayerRunInProgressState({this.currentDuration,this.maxDuration}) : super (songBean:PlayListManager.getInstance().getCurrentSong());
}

///
/// 播放后暂停的状态
///
class PlayerPauseState extends PlayerState{
  PlayerPauseState({currentDuration,maxDuration}) : super (songBean:PlayListManager.getInstance().getCurrentSong());
}

///
/// 播放完成的状态
///
class PlayerCompleteState extends PlayerState{
  PlayerCompleteState() : super (songBean:PlayListManager.getInstance().getCurrentSong());
}