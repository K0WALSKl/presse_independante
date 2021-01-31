import 'dart:convert';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:presse_independante/datamodels/Article.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class Api {
  // static const kEdnPoint = 'http://10.42.0.1:3000';  // DEV
  static const kEdnPoint = 'http://51.68.70.188:3000'; // PROD

  static const kGetLastArticles = 'getNews/sortedByDate';

  Client client = Client();

  Future<List<Article>> getLastArticles() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> chosenMedia = prefs.getStringList('chosenMedia') ?? [
      'Les Jours',
      'Reporterre',
      'La Releve Et La Peste',
      'Eco-Bretons',
      'Fakir',
    ];

    List<Article> articles = List<Article>();

    print("Getting the articles");

    final Response response = await client.get('$kEdnPoint/$kGetLastArticles');
    final Map<String, dynamic> body_json = json.decode(response.body);

    List<dynamic> articles_json = body_json['data'];
    Article current;

    articles_json.forEach((element) {
      current = Article.fromJson(element);
      for (String media in chosenMedia)
        if (current.articleSource.name.contains(media))
          articles.add(Article.fromJson(element));
      // print(chosenMedia);
      // articles.add(Article.fromJson(element));
    });
    return articles;
  }
}