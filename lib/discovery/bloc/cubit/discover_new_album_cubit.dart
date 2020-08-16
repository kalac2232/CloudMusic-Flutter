import 'package:cloudmusic/discovery/bean/album_list_item_bean.dart';
import 'package:cloudmusic/discovery/bean/banner_bean.dart';
import 'package:cloudmusic/discovery/bean/song_item_bean.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscoverNewAlbumCubit extends Cubit<List<AlbumListItemBean>> {
  DiscoverNewAlbumCubit() : super(List());

  void setList(List<AlbumListItemBean> l) => emit(l);

}