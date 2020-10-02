import 'package:audioplayers/audioplayers.dart';
import 'package:cloudmusic/commen/bloc/event/player_event.dart';
import 'package:cloudmusic/commen/bloc/player_bloc.dart';
import 'package:cloudmusic/commen/net/http_request.dart';
import 'package:cloudmusic/discovery/bean/song_bean.dart';
import 'package:cloudmusic/player/play_list_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';

class PlayerAudioManager {
  BuildContext context;
  AudioPlayer _audioPlayer;

  factory PlayerAudioManager.getInstance() => _getInstance();
  static PlayerAudioManager _instance;

  PlayerAudioManager._internal() {
    _audioPlayer = AudioPlayer();


    _audioPlayer.onAudioPositionChanged.listen((Duration p) {
      //print('Current position: $p');

      _audioPlayer.getDuration().then((value){
        //print('max position: $value');

        if(_audioPlayer.state != AudioPlayerState.PAUSED && _audioPlayer.state != AudioPlayerState.STOPPED) {

          context.bloc<PlayerBloc>().add(PlayerProgressEvent(currentDuration: p,maxDuration: Duration(milliseconds: value)));
        }
      });

    });

    _audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s)  {
      print('Current player state: $s');
      if (s == AudioPlayerState.COMPLETED) {
        context.bloc<PlayerBloc>().add(PlayerCompletedEvent());
      }

    });
  }

  static PlayerAudioManager _getInstance() {
    if (_instance == null) {
      _instance = PlayerAudioManager._internal();
    }

    return _instance;
  }

  Future<void> start(SongBean songBean) async {

    var url = await _getRealUrl(songBean.id.toString());
    print("start:" + url);
    _audioPlayer.stop();
    _audioPlayer.play(url);
  }

  void pause() {
    _audioPlayer.pause();
  }

  void next() {
    _audioPlayer.stop();
    print("next");
    start(PlayListManager.getInstance().getNextSong(PlayMode.order));
  }

  void pre() {
    _audioPlayer.stop();
    print("pre");
    start(PlayListManager.getInstance().getPreviousSong(PlayMode.order));
  }

  void resume() {
    _audioPlayer.resume();
  }

  Future<String> _getRealUrl(String id) async {
    print(id);
    var result =
        await httpRequest.get(path: "/song/url", parameters: {"id": id});
    return result.data["data"][0]["url"];
  }

  Future<Duration> getCurrentPosition() async {

    int i = await _audioPlayer.getCurrentPosition();

    return Duration(milliseconds: i);
  }

  Future<Duration> getMaxDuration() async {

    int i = await _audioPlayer.getDuration();

    return Duration(milliseconds: i);
  }

  void seekTo(double seekTo) async {

    var maxDuration = await getMaxDuration();

    _audioPlayer.seek(Duration(milliseconds: (maxDuration.inMilliseconds * seekTo).toInt()));
  }
}
