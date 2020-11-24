import 'dart:convert';

import 'package:presse_independante/model/core/NewsPaper.dart';

class Article {
  String url;
  String imageUrl;
  String title;
  DateTime publicationDate;
  String description;
  NewsPaper articleSource;

  Article({
    this.url,
    this.imageUrl,
    this.title,
    this.publicationDate,
    this.description,
    this.articleSource,
  });


  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'imageUrl': imageUrl,
      'title': title,
      'publicationDate': publicationDate,
      'description': description,
      'articleSource': articleSource,
    };
  }

  static Article fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Article(
      url: map['url'],
      imageUrl: map['imageUrl'],
      title: map['title'],
      publicationDate: map['publicationDate'],
      description: map['description'],
      articleSource: map['articleSource'],
    );
  }

  String toJson() => json.encode(toMap());

  static Article fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'url: $url, imageUrl: $imageUrl, title: $title, publicationDate: $publicationDate, description: $description, articleSource: $articleSource';
  }
}
