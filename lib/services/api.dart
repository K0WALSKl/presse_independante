import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:presse_independante/datamodels/article.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class Api {
  static const String kEdnPoint = '127.0.0.1'; // Local
  // static const kEdnPoint = 'http://www.gwendhalclaudel.com'; // PROD
  static const String kGetLastArticles = 'getNews/sortedByDate';

  static Uri uri =
      Uri(scheme: 'http', host: kEdnPoint, port: 3000, path: kGetLastArticles);

  Future<List<Article>> getLastArticles() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> chosenMedia = prefs.getStringList('chosenMedia') ??
        <String>[
          'Les Jours',
          'Reporterre',
          'La Releve Et La Peste',
          'Eco-Bretons',
          'Fakir',
          'Alter1fo',
        ];

    final List<Article> articles = <Article>[];
    List<dynamic> bodyJson;

    print('Getting the articles');

    print(kIsWeb.toString());
    if (kIsWeb) {
      final Map<String, String> headers = <String, String>{
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': '*'
      };
      final BrowserClient client = BrowserClient();
      final Response response = await client.get(uri, headers: headers);
      bodyJson = jsonDecode(response.body)['data'] as List<dynamic>;
    } else {
      final Client client = Client();
      final Response response = await client.get(uri);
      bodyJson = jsonDecode(response.body) as List<dynamic>;
    }

    final List<Map<String, dynamic>> articlesJson =
        bodyJson.cast<Map<String, dynamic>>();

    // final List<dynamic> articlesJson = bodyJson['data'] as List<dynamic>;
    Article current;

    for (final Map<String, dynamic> article in articlesJson) {
      current = Article.fromJson(article);
      for (final String media in chosenMedia)
        if (current.articleSource.name.contains(media))
          articles.add(Article.fromJson(article));
    }
    return articles;
  }
}
