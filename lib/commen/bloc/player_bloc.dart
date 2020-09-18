import 'package:cloudmusic/commen/bloc/event/player_event.dart';
import 'package:cloudmusic/commen/bloc/state/player_state.dart';
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

    }
  }

  Stream<PlayerState> _mapPlayerStartedToState(PlayerStartedEvent event) async* {
    yield PlayerRunInProgressState();
  }

  Stream<PlayerState> _mapPlayerPausedToState(PlayerPausedEvent event) async* {
    yield PlayerPauseState();
  }

  Stream<PlayerState> _mapPlayerResumedToState(PlayerResumedEvent event) async* {
    yield PlayerRunInProgressState();
  }

  Stream<PlayerState> _mapPlayerProgressToState(PlayerProgressEvent event) async* {
    yield PlayerRunInProgressState();
  }

  Stream<PlayerState> _mapPlayerCompletedToState(PlayerCompletedEvent event) async* {
    yield PlayerCompleteState();
  }

  Stream<PlayerState> _mapPlayerNextToState(PlayerNextEvent event) async* {
    print("bloc 收到");
    yield PlayerInitialState(event: event);
  }

  Stream<PlayerState> _mapPlayerPreviousToState(PlayerPreviousEvent event) async* {
    yield PlayerInitialState(event: event);

  }
}