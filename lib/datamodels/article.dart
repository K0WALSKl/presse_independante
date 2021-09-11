import 'package:json_annotation/json_annotation.dart';
import 'package:presse_independante/datamodels/article_source.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {
  Article({
    required this.url,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.publicationDate,
    required this.author,
    required this.articleSource,
  });
  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  String url;
  String imageUrl;
  String title;
  String description;
  DateTime publicationDate;
  String author;
  ArticleSource articleSource;
}
