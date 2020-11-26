import 'dart:convert';

import 'package:presse_independante/model/core/Article.dart';

class NewsPaper {
  String sourceName;
  String url;
  String imageUrl;
  List<String> donationUrl;
  List<Article> articles;

  NewsPaper({this.sourceName, this.url, this.imageUrl, this.donationUrl, this.articles});

  Map<String, dynamic> toMap() {
    return {
      'sourceName': sourceName,
      'url': url,
      'imageUrl': imageUrl,
      'donationUrl': donationUrl,
      'articles': articles,
    };
  }

  static NewsPaper fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    List<Article> arts = <Article>[];
    Article tmp;
    for (int i = 0; i < map['articles'].length; i++) {
      tmp = Article.fromMap(map['articles'][i]);
      tmp.articleSource = map['sourceName'];
      arts.add(tmp);
    }

    return NewsPaper(
      sourceName: map['sourceName'],
      url: map['url'],
      imageUrl: map['imageUrl'],
      donationUrl: map['donationUrl'],
      articles: arts,
    );
  }

  // static List<NewsPaper> newsPapersFromMap(Map<String, dynamic> map) {
  static List<NewsPaper> newsPapersFromMap(List<dynamic> map) {
    List<NewsPaper> npList = <NewsPaper>[];
    if (map == null) return null;

    for (int i = 0; i < map.length; i++) {
      npList.add(NewsPaper.fromMap(map[i]));
      print(npList[0]);
    }

    return npList;
  }

  String toJson(String source) => json.encode(toMap());

  static NewsPaper fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Source(sourceName: $sourceName, url: $url, imageUrl: $imageUrl, donationUrl: $donationUrl, articles: $articles)';
  }
}