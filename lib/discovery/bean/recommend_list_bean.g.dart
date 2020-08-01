// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommend_list_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendListBean _$RecommendListBeanFromJson(Map<String, dynamic> json) {
  return RecommendListBean(
    json['id'] as int,
    json['type'] as int,
    json['name'] as String,
    json['copywriter'] as String,
    json['picUrl'] as String,
    json['canDislike'] as bool,
    json['trackNumberUpdateTime'] as int,
    json['playCount'] as int,
    json['trackCount'] as int,
    json['highQuality'] as bool,
    json['alg'] as String,
  );
}

Map<String, dynamic> _$RecommendListBeanToJson(RecommendListBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'copywriter': instance.copywriter,
      'picUrl': instance.picUrl,
      'canDislike': instance.canDislike,
      'trackNumberUpdateTime': instance.trackNumberUpdateTime,
      'playCount': instance.playCount,
      'trackCount': instance.trackCount,
      'highQuality': instance.highQuality,
      'alg': instance.alg,
    };
