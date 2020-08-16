class SongItemBean{
  String name;
  int id;
  String author;
  String picUrl;

  SongItemBean(this.name, this.id, this.author, this.picUrl);

  SongItemBean.fromCategoryJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        author = json['ar'][0]["name"],
        picUrl = json['al']["picUrl"];

  SongItemBean.fromNewSongJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        author = json['album']["artists"][0]["name"],
        picUrl = json['album']["blurPicUrl"];

  SongItemBean.fromRankJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        author = json['ar'][0]["name"],
        picUrl = json['al']["picUrl"];

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'id': id,
        'author': author,
        'picUrl': picUrl,
      };

  @override
  String toString() {
    return 'SongListItemBean{name: $name, id: $id, author: $author, picUrl: $picUrl}';
  }
}