import 'package:cloudmusic/discovery/bean/banner_bean.dart';
import 'package:cloudmusic/discovery/bean/song_item_bean.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscoverNewSongCubit extends Cubit<List<SongItemBean>> {
  DiscoverNewSongCubit() : super(List());

  void setList(List<SongItemBean> l) => emit(l);

}