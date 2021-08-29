import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:presse_independante/datamodels/Article.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class Api {
  static const kEdnPoint = '127.0.0.1'; // Local
  // static const kEdnPoint = 'http://www.gwendhalclaudel.com'; // PROD
  static const kGetLastArticles = 'getNews/sortedByDate';

  static Uri uri = new Uri(
      scheme: "http", host: kEdnPoint, port: 3000, path: kGetLastArticles);

  Future<List<Article>> getLastArticles() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> chosenMedia = prefs.getStringList('chosenMedia') ??
        [
          'Les Jours',
          'Reporterre',
          'La Releve Et La Peste',
          'Eco-Bretons',
          'Fakir',
        ];

    List<Article> articles = List<Article>();
    Map<String, dynamic> body_json;

    print("Getting the articles");

    print(kIsWeb.toString());
    if (kIsWeb) {
      print('in browser');
      final BrowserClient client = BrowserClient();
      final Response response = await client.get(uri, headers: {
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      });
      print(response);
      body_json = json.decode(response.body);
    } else if (Platform.isIOS || Platform.isAndroid) {
      Client client = Client();
      final Response response = await client.get(uri);
      body_json = json.decode(response.body);
    }

    print(body_json);

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
