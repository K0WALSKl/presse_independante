import 'dart:convert';

class Article {
  String url;
  String imageUrl;
  String title;
  String description;
  DateTime publicationDate;
  String author;
  String articleSource;

  Article({
    this.url,
    this.imageUrl,
    this.title,
    this.description,
    this.publicationDate,
    this.author,
    this.articleSource,
  });

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
      'publicationDate': publicationDate,
      'author': author,
      'articleSource': articleSource,
    };
  }

  static Article fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Article(
      url: map['url'], // item.link
      imageUrl: map['imageUrl'], //
      title: map['title'],
      description: map['description'],
      publicationDate: DateTime.parse(map['publicationDate']), // TODO Corriger la façon dont LRELP envoie la date
      author: map['author'],
      articleSource: map['articleSource'],
    );
  }

  String toJson() => json.encode(toMap());

  static List<Article> articleListFromMap(List<dynamic> map) {
    List<Article> arts = <Article>[];

    for (int i = 0; i < map.length; i++) {
      arts.add(Article.fromMap(map[i]));
    }

    return arts;
  }

  static Article fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'url: $url, imageUrl: $imageUrl, title: $title, publicationDate: $publicationDate, description: $description, articleSource: $articleSource, author: $author';
  }

}
