class SongListItemBean{
  String name;
  int id;
  String author;
  String picUrl;

  SongListItemBean(this.name, this.id, this.author, this.picUrl);

  SongListItemBean.fromCategoryJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        author = json['ar'][0]["name"],
        picUrl = json['al']["picUrl"];

  SongListItemBean.fromNewSongJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        author = json['album']["artists"][0]["name"],
        picUrl = json['album']["blurPicUrl"];

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