// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_list_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongListBean _$SongListBeanFromJson(Map<String, dynamic> json) {
  return SongListBean(
    json['name'] as String,
    json['id'] as int,
    json['coverImgUrl'] as String,
    json['coverImgId'] as int,
    json['description'] as String,
    (json['tags'] as List)?.map((e) => e as String)?.toList(),
    json['playCount'] as int,
    json['specialType'] as int,
    json['commentThreadId'] as String,
    json['newImported'] as bool,
    json['highQuality'] as bool,
    json['privacy'] as int,
  );
}

Map<String, dynamic> _$SongListBeanToJson(SongListBean instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'coverImgUrl': instance.coverImgUrl,
      'coverImgId': instance.coverImgId,
      'description': instance.description,
      'tags': instance.tags,
      'playCount': instance.playCount,
      'specialType': instance.specialType,
      'commentThreadId': instance.commentThreadId,
      'newImported': instance.newImported,
      'highQuality': instance.highQuality,
      'privacy': instance.privacy,
    };
