import 'package:cloudmusic/discovery/bean/song_item_bean.dart';

class DiscoverCategoryBean{
  String name;
  List<SongItemBean> list;

  DiscoverCategoryBean(this.name, this.list);

  @override
  String toString() {
    return 'DiscoverCategoryBean{name: $name, list: $list}';
  }
}