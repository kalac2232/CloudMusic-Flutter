import 'package:cloudmusic/discovery/bean/album_list_item_bean.dart';
import 'package:cloudmusic/discovery/bean/discover_rank_bean.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscoverRankCubit extends Cubit<List<DiscoverRankBean>> {
  DiscoverRankCubit() : super(List());

  void setList(List<DiscoverRankBean> l) => emit(l);

}