import 'package:cloudmusic/commen/bloc/event/player_event.dart';
import 'package:cloudmusic/discovery/bean/song_bean.dart';
import 'package:cloudmusic/player/play_list_manager.dart';

abstract class PlayerState {
  final SongBean songBean;
  final Duration currentDuration;
  final Duration maxDuration;

  PlayerState({this.songBean, this.currentDuration, this.maxDuration});
}

///
/// 未开始的状态
///
class PlayerInitialState extends PlayerState {
  final PlayerEvent event;

  PlayerInitialState({this.event})
      : super(
            songBean: PlayListManager.getInstance().getCurrentSong(),
            currentDuration: Duration(),
            maxDuration: (Duration(
                milliseconds:
                    PlayListManager.getInstance().getCurrentSong().duration)));
}

///
/// 正在播放的状态
///
class PlayerRunInProgressState extends PlayerState {
  PlayerRunInProgressState({currentDuration, maxDuration})
      : super(
            songBean: PlayListManager.getInstance().getCurrentSong(),
            currentDuration: currentDuration,
            maxDuration: maxDuration);
}

///
/// 播放后暂停的状态
///
class PlayerPauseState extends PlayerState {
  PlayerPauseState({currentDuration, maxDuration})
      : super(
            songBean: PlayListManager.getInstance().getCurrentSong(),
            currentDuration: currentDuration,
            maxDuration: maxDuration);
}

///
/// 播放完成的状态
///
class PlayerCompleteState extends PlayerState {
  PlayerCompleteState()
      : super(
            songBean: PlayListManager.getInstance().getCurrentSong(),
            currentDuration: Duration(
                milliseconds:
                    PlayListManager.getInstance().getCurrentSong().duration),
            maxDuration: (Duration(
                milliseconds:
                    PlayListManager.getInstance().getCurrentSong().duration)));
}
