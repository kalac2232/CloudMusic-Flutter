import 'package:json_annotation/json_annotation.dart';

part 'song_list_bean.g.dart';

///单个歌单bean
@JsonSerializable()
class SongListBean extends Object {

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'id')
  int id;


  @JsonKey(name: 'coverImgUrl')
  String coverImgUrl;

  @JsonKey(name: 'coverImgId')
  int coverImgId;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'tags')
  List<String> tags;

  @JsonKey(name: 'playCount')
  int playCount;

  @JsonKey(name: 'specialType')
  int specialType;

  @JsonKey(name: 'commentThreadId')
  String commentThreadId;

  @JsonKey(name: 'newImported')
  bool newImported;

  @JsonKey(name: 'highQuality')
  bool highQuality;

  @JsonKey(name: 'privacy')
  int privacy;


  SongListBean(
      this.name,
      this.id,
      this.coverImgUrl,
      this.coverImgId,
      this.description,
      this.tags,
      this.playCount,
      this.specialType,
      this.commentThreadId,
      this.newImported,
      this.highQuality,
      this.privacy);

  factory SongListBean.fromJson(Map<String, dynamic> srcJson) => _$SongListBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SongListBeanToJson(this);

  @override
  String toString() {
    return 'SongListBean{name: $name, id: $id, coverImgUrl: $coverImgUrl, coverImgId: $coverImgId, description: $description, tags: $tags, playCount: $playCount, specialType: $specialType, commentThreadId: $commentThreadId, newImported: $newImported, highQuality: $highQuality, privacy: $privacy}';
  }
}
