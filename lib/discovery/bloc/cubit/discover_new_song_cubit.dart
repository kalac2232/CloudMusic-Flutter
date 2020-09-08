import 'package:cloudmusic/discovery/bean/banner_bean.dart';
import 'package:cloudmusic/discovery/bean/song_bean.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscoverNewSongCubit extends Cubit<List<SongBean>> {
  DiscoverNewSongCubit() : super(List());

  void setList(List<SongBean> l) => emit(l);

}