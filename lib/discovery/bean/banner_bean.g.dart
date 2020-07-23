// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerBean _$BannerBeanFromJson(Map<String, dynamic> json) {
  return BannerBean(
    json['pic'] as String,
    json['targetId'] as int,
    json['targetType'] as int,
    json['titleColor'] as String,
    json['typeTitle'] as String,
    json['url'] as String,
    json['exclusive'] as bool,
    json['monitorImpressList'] as List,
    json['monitorClickList'] as List,
    json['encodeId'] as String,
    json['bannerId'] as String,
    json['scm'] as String,
    json['requestId'] as String,
    json['showAdTag'] as bool,
  );
}

Map<String, dynamic> _$BannerBeanToJson(BannerBean instance) =>
    <String, dynamic>{
      'pic': instance.pic,
      'targetId': instance.targetId,
      'targetType': instance.targetType,
      'titleColor': instance.titleColor,
      'typeTitle': instance.typeTitle,
      'url': instance.url,
      'exclusive': instance.exclusive,
      'monitorImpressList': instance.monitorImpressList,
      'monitorClickList': instance.monitorClickList,
      'encodeId': instance.encodeId,
      'bannerId': instance.bannerId,
      'scm': instance.scm,
      'requestId': instance.requestId,
      'showAdTag': instance.showAdTag,
    };
