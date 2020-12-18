import 'dart:convert';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:presse_independante/datamodels/Article.dart';

@lazySingleton
class Api {
  static const kEdnPoint = 'http://10.42.0.1:3000';

  static const kGetLastArticles = 'getNews/sortedByDate';

  Client client = Client();

  Future<List<Article>> getLastArticles() async {
    List<Article> articles = List<Article>();
    final Response response = await client.get('$kEdnPoint/$kGetLastArticles');
    final Map<String, dynamic> body_json = json.decode(response.body);

    List<dynamic> articles_json = body_json['data'];
    articles_json.forEach((element) {
      articles.add(Article.fromJson(element));
    });
    return articles;
  }
}