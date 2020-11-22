class Article {
  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
  });

  Article.fromJson(Map<String, dynamic> map) {
    source = map['source']['name'] as String;
    author = map['author'] as String;
    title = map['title'] as String;
    description = map['description'] as String;
    url = map['url'] as String;
    urlToImage = map['urlToImage'] as String;
  }

  String source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
}