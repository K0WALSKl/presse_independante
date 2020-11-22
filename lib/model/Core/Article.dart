import 'dart:convert';

class Article {
  Article({
    this.url,
    this.title,
    this.description,
    this.content,
    this.publicationDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'url': url,
      'title': title,
      'description': description,
      'content': content,
      'publicationDate': publicationDate,
    };
  }

  static Article fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }

    return Article(
      url: map['url'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      content: map['content'] as String,
      publicationDate: map['publicationDate'] as DateTime,
    );
  }

  String toJson() => json.encode(toMap());

  static Article fromJson(String source) => fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Article(url: $url, title: $title, description: $description, content: $content, publicationDate $publicationDate)';
  }

  final String url;
  final String title;
  final String description;
  final String content;
  final DateTime publicationDate;
}