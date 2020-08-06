class AlbumListItemBean{
  String name;
  int id;
  String author;
  String picUrl;

  AlbumListItemBean(this.name, this.id, this.author, this.picUrl);

  AlbumListItemBean.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        author = json['artists'][0]["name"],
        picUrl = json['blurPicUrl'];


  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'id': id,
        'author': author,
        'picUrl': picUrl,
      };
}