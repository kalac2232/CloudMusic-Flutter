import 'package:cloudmusic/commen/bloc/event/player_event.dart';
import 'package:cloudmusic/commen/bloc/state/player_state.dart';
import 'package:cloudmusic/player/play_list_manager.dart';
import 'package:cloudmusic/player/player_audio_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {

  final PlayerAudioManager _playerAudioManager;

  PlayerBloc({@required PlayerAudioManager manager})
      : assert(manager != null),
        _playerAudioManager = manager,
        super(PlayerInitialState(event: null));

  @override
  Stream<PlayerState> mapEventToState(PlayerEvent event) async*  {

    if (event is PlayerStartedEvent) {
      //处理开始播放事件
      yield* _mapPlayerStartedToState(event);

    } else if (event is PlayerPausedEvent) {
      //处理暂停播放事件
      yield* _mapPlayerPausedToState(event);

    } else if (event is PlayerResumedEvent) {
      //处理恢复播放事件
      yield* _mapPlayerResumedToState(event);

    } else if (event is PlayerProgressEvent) {
      //处理进度回调事件
      yield* _mapPlayerProgressToState(event);

    } else if (event is PlayerCompletedEvent) {
      //处理完成播放事件
      yield* _mapPlayerCompletedToState(event);

    } else if (event is PlayerPreviousEvent) {

      yield* _mapPlayerPreviousToState(event);

    } else if (event is PlayerNextEvent) {

      yield* _mapPlayerNextToState(event);

    } else if (event is PlayerSeekEvent) {

      yield* _mapPlayerSeekToState(event);
    }


  }
  ///
  /// 处理开始播放事件
  ///
  Stream<PlayerState> _mapPlayerStartedToState(PlayerStartedEvent event) async* {
    yield PlayerRunInProgressState(currentDuration: Duration(seconds: 0),maxDuration: Duration(seconds: 0));
    _playerAudioManager.start(PlayListManager.getInstance().getCurrentSong());
  }

  ///
  /// 处理暂停播放事件
  ///
  Stream<PlayerState> _mapPlayerPausedToState(PlayerPausedEvent event) async* {
    _playerAudioManager.pause();

    Duration currentPosition = await _playerAudioManager.getCurrentPosition();
    Duration maxDuration = await _playerAudioManager.getMaxDuration();

    yield PlayerPauseState(currentDuration: currentPosition,maxDuration: maxDuration);
  }

  ///
  /// 处理恢复播放事件
  ///
  Stream<PlayerState> _mapPlayerResumedToState(PlayerResumedEvent event) async* {
    _playerAudioManager.resume();

    Duration currentPosition = await _playerAudioManager.getCurrentPosition();
    Duration maxDuration = await _playerAudioManager.getMaxDuration();

    yield PlayerRunInProgressState(currentDuration: currentPosition,maxDuration: maxDuration);
  }

  ///
  /// 处理进度回调事件
  ///
  Stream<PlayerState> _mapPlayerProgressToState(PlayerProgressEvent event) async* {
    yield PlayerRunInProgressState(currentDuration: event.currentDuration,maxDuration: event.maxDuration);
  }

  Stream<PlayerState> _mapPlayerCompletedToState(PlayerCompletedEvent event) async* {
    yield PlayerCompleteState();
  }

  Stream<PlayerState> _mapPlayerNextToState(PlayerNextEvent event) async* {

    _playerAudioManager.next();
    yield PlayerInitialState(event: event);
  }

  Stream<PlayerState> _mapPlayerPreviousToState(PlayerPreviousEvent event) async* {
    _playerAudioManager.pre();
    yield PlayerInitialState(event: event);
  }

  ///
  /// 处理seek后的状态变化
  ///
  Stream<PlayerState> _mapPlayerSeekToState(PlayerSeekEvent event) async* {
    _playerAudioManager.seekTo(event.seekTo);
    //Duration currentPosition = await _playerAudioManager.getCurrentPosition();
    Duration maxDuration = await _playerAudioManager.getMaxDuration();

    if (state is PlayerPauseState) {
      yield PlayerPauseState(currentDuration: Duration(milliseconds: (maxDuration.inMilliseconds * event.seekTo).toInt()),maxDuration: maxDuration);
    } else {
      yield PlayerRunInProgressState(currentDuration: Duration(milliseconds: (maxDuration.inMilliseconds * event.seekTo).toInt()),maxDuration: maxDuration);
    }


  }
}