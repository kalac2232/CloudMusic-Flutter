import 'package:cloudmusic/discovery/bean/song_list_item_bean.dart';

class DiscoverCategoryBean{
  String name;
  List<SongListItemBean> list;

  DiscoverCategoryBean(this.name, this.list);

  @override
  String toString() {
    return 'DiscoverCategoryBean{name: $name, list: $list}';
  }
}