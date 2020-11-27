import 'dart:convert';
import 'package:presse_independante/model/Service/ArticleFetcherApi.dart';
import 'package:presse_independante/model/core/Article.dart';
import 'package:presse_independante/model/core/NewsPaper.dart';
import 'package:presse_independante/model/glitch/NoInternetGlitch.dart';
import 'package:presse_independante/model/glitch/glitch.dart';
import 'package:dartz/dartz.dart';

class ArticleHelper {
  final api = ArticleFetcherApi(source: "http://10.42.0.1:3000/getNews");

  Future<Either<Glitch, List<NewsPaper>>> getLastArticles() async {
    final apiResult = await api.getLastArticles();
    print("res = " + apiResult.toString());
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      List<NewsPaper> newspapers = <NewsPaper>[];
      var newspapersMap = json.decode(r);
      newspapers = NewsPaper.newsPapersFromMap(newspapersMap['data']);
      print("Ok");
      return Right(newspapers);
    });
  }

  Future<Either<Glitch, List<Article>>> getLastArticlesSortedByDate() async {
    api.source = "http://10.42.0.1:3000/getNews/sortedByDate";
    final apiResult = await api.getLastArticles();
    print("res = " + apiResult.toString());
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      List<Article> articles = <Article>[];
      var articlesMap = json.decode(r);
      articles = Article.articleListFromMap(articlesMap['data']);
      print("Ok");
      return Right(articles);
    });
  }

}
