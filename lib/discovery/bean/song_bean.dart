import 'artist_bean.dart';

class SongBean{
  String name;
  int id;
  List<ArtistBean> artists;
  String picUrl;
  String company;
  String type;
  //歌曲长度
  int duration;

  bool isSQ;
  //是否是独家
  bool isSole;
  //别名
  String alias;

  int mvId;


  SongBean(this.name, this.id, this.artists, this.picUrl);

  SongBean.fromCategoryJson(Map<String, dynamic> json){
    name = json['name'];
    id = json['id'];
    artists = List();
    for(int i = 0; i < json['ar'].length;i++) {
      artists.add(ArtistBean.fromJson(json['ar'][i]));
    }
    picUrl = json['al']["picUrl"];
    duration = json['dt'];
  }


  SongBean.fromNewSongJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    artists = List();
    for(int i = 0; i < json['album']["artists"].length;i++) {
      artists.add(ArtistBean.fromJson(json['album']["artists"][i]));
    }
    picUrl = json['album']["blurPicUrl"];
  }


  SongBean.fromRankJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    artists = List();
    for(int i = 0; i < json['ar'].length;i++) {
      artists.add(ArtistBean.fromJson(json['ar'][i]));
    }
    picUrl = json['al']["picUrl"];
  }

  SongBean.fromDailyRecommendJson(Map<String, dynamic> json){
    name = json['album']['name'];
    id = json['album']['id'];
    picUrl = json['album']["blurPicUrl"];
    type = json['album']["type"];
    artists = List();
    for(int i = 0; i < json['album']['artists'].length;i++) {
      artists.add(ArtistBean.fromJson(json['album']['artists'][i]));
    }
    isSQ = json['privilege']['maxbr'] >= 999000;
    isSole = json['privilege']['flag'] == 64;
    mvId = json['mvid'];
  }

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'id': id,
        'artists': artists.toString(),
        'picUrl': picUrl,
      };

  @override
  String toString() {
    return 'SongListItemBean{name: $name, id: $id, author:${artists.toString()}, picUrl: $picUrl}';
  }


  String getArtistsStr(){

    return artists.join('/');
  }
}