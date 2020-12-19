import 'package:json_annotation/json_annotation.dart';

import 'package:presse_independante/datamodels/ArticleSource.dart';

part 'Article.g.dart';

@JsonSerializable()
class Article {
  Article({
    this.url,
    this.imageUrl,
    this.title,
    this.description,
    this.publicationDate,
    this.author,
    this.articleSource,
  });
  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  String url;
  String imageUrl;
  String title;
  String description;
  DateTime publicationDate;
  String author;
  ArticleSource articleSource;
}

