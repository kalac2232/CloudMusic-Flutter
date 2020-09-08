import 'package:cloudmusic/discovery/bean/song_bean.dart';

class DiscoverCategoryBean{
  String name;
  List<SongBean> list;

  DiscoverCategoryBean(this.name, this.list);

  @override
  String toString() {
    return 'DiscoverCategoryBean{name: $name, list: $list}';
  }
}