// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ArticleSource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleSource _$ArticleSourceFromJson(Map<String, dynamic> json) {
  return ArticleSource(
    json['name'] as String,
    json['imageUrl'] as String,
    json['websiteUrl'] as String,
  );
}

Map<String, dynamic> _$ArticleSourceToJson(ArticleSource instance) =>
    <String, dynamic>{
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'websiteUrl': instance.websiteUrl,
    };
