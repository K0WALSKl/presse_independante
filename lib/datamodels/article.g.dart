// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      url: json['url'] as String,
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      publicationDate: DateTime.parse(json['publicationDate'] as String),
      author: json['author'] as String,
      articleSource:
          ArticleSource.fromJson(json['articleSource'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'url': instance.url,
      'imageUrl': instance.imageUrl,
      'title': instance.title,
      'description': instance.description,
      'publicationDate': instance.publicationDate.toIso8601String(),
      'author': instance.author,
      'articleSource': instance.articleSource,
    };
