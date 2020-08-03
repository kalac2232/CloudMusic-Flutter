class SongListItemBean{
  String name;
  int id;
  String author;
  String picUrl;

  SongListItemBean(this.name, this.id, this.author, this.picUrl);

  SongListItemBean.fromJson(Map<String, dynamic> json)
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