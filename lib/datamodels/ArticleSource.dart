import 'package:json_annotation/json_annotation.dart';

part 'ArticleSource.g.dart';

@JsonSerializable()
class ArticleSource {
  ArticleSource(this.name, this.imageUrl, this.websiteUrl);
  factory ArticleSource.fromJson(Map<String, dynamic> json) => _$ArticleSourceFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleSourceToJson(this);

  String name;
  String imageUrl;
  String websiteUrl;
}