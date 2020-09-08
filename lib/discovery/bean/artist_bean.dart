class ArtistBean extends Object {
  String name;
  int id;

  ArtistBean.fromJson(Map<String, dynamic> json) :
      name = json['name'],id = json['id'];

  @override
  String toString() {
    return name;
  }
}