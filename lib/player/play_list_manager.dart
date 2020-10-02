
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloudmusic/commen/bloc/event/commen_event.dart';
import 'package:cloudmusic/commen/net/http_request.dart';
import 'package:cloudmusic/discovery/bean/recommend_list_bean.dart';
import 'package:cloudmusic/discovery/bean/song_bean.dart';
import 'package:cloudmusic/discovery/bloc/cubit/mini_player_bloc.dart';
import 'package:flutter/material.dart';


class PlayListManager {

  BuildContext _context;

  List<SongBean> list;
  List<SongBean> playedList;

  int currentIndex;

  factory PlayListManager.getInstance() => _getInstance();
  static PlayListManager _instance;

  static PlayListManager _getInstance() {
    if (_instance == null) {
      _instance = PlayListManager._internal();
    }

    return _instance;
  }

  PlayListManager._internal() {

    list = List();

  }

  void init(BuildContext context) {
    _context = context;
    getDefaultPlayList();
    currentIndex = 0;
  }


  SongBean getCurrentSong() {
    return list[currentIndex];
  }

  SongBean getNextSong(PlayMode mode) {
    currentIndex++;
    return list[currentIndex];
  }

  SongBean getPreviousSong(PlayMode mode) {
    currentIndex--;
    return list[currentIndex];
  }

  getDefaultPlayList() async {
    var playList = await httpRequest.get(path: "/top/playlist", parameters: {"limit": 1,"cat":"华语"});

    var data = playList.data["playlists"][0];
    RecommendListBean bean = RecommendListBean.fromJson(data);

    print("id:" + bean.id.toString());

    var playListDetail = await httpRequest.get(path: "/playlist/detail", parameters: {"id": bean.id});


    List<SongBean> templist = List();
    playListDetail.data["playlist"]["tracks"].map((result) {
      templist.add(SongBean.fromCategoryJson(result));
    }).toList();

    _context.bloc<MiniPlayerBloc>().add(MiniPlayerWidgetControlEvent.visible);
    list.clear();
    list.addAll(templist);

    print(list);
  }

}

enum PlayMode{
  loop,order,shuffle
}