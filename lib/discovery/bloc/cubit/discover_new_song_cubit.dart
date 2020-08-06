import 'package:cloudmusic/discovery/bean/banner_bean.dart';
import 'package:cloudmusic/discovery/bean/song_list_item_bean.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscoverNewSongCubit extends Cubit<List<SongListItemBean>> {
  DiscoverNewSongCubit() : super(List());

  void setList(List<SongListItemBean> l) => emit(l);

}