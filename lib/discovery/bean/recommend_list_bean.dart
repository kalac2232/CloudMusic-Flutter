import 'package:json_annotation/json_annotation.dart';

part 'recommend_list_bean.g.dart';


@JsonSerializable()
class RecommendListBean extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'copywriter')
  String copywriter;

  @JsonKey(name: 'picUrl')
  String picUrl;

  @JsonKey(name: 'canDislike')
  bool canDislike;

  @JsonKey(name: 'trackNumberUpdateTime')
  int trackNumberUpdateTime;

  @JsonKey(name: 'playCount')
  int playCount;

  @JsonKey(name: 'trackCount')
  int trackCount;

  @JsonKey(name: 'highQuality')
  bool highQuality;

  @JsonKey(name: 'alg')
  String alg;

  RecommendListBean(this.id,this.type,this.name,this.copywriter,this.picUrl,this.canDislike,this.trackNumberUpdateTime,this.playCount,this.trackCount,this.highQuality,this.alg,);

  factory RecommendListBean.fromJson(Map<String, dynamic> srcJson) => _$RecommendListBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecommendListBeanToJson(this);

  @override
  String toString() {
    return 'RecommendListBean{id: $id, type: $type, name: $name, copywriter: $copywriter, picUrl: $picUrl, canDislike: $canDislike, trackNumberUpdateTime: $trackNumberUpdateTime, playCount: $playCount, trackCount: $trackCount, highQuality: $highQuality, alg: $alg}';
  }
}