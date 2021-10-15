// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleSource _$ArticleSourceFromJson(Map<String, dynamic> json) =>
    ArticleSource(
      json['name'] as String,
      json['url'] as String,
      json['imageUrl'] as String,
    );

Map<String, dynamic> _$ArticleSourceToJson(ArticleSource instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'imageUrl': instance.imageUrl,
    };
