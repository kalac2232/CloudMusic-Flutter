import 'package:cloudmusic/discovery/bean/banner_bean.dart';
import 'package:cloudmusic/discovery/bean/discover_category_bean.dart';
import 'package:cloudmusic/discovery/bean/recommend_list_bean.dart';

class BannerEvent{
  final List<BannerBean> list;

  BannerEvent(this.list);
}

enum DiscoverNewCategoryEvent {
  newAlbum,
  newSong
}