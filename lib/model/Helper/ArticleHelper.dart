import 'dart:async';
import 'dart:convert';
import 'package:presse_independante/model/Service/ArticleAPI.dart';
import 'package:presse_independante/model/Core/Article.dart';
import 'package:presse_independante/model/glitch/NoInternetGlitch.dart';
import 'package:presse_independante/model/glitch/Glitch.dart';
import 'package:dartz/dartz.dart';

class ArticleHelper {
  final ArticleAPI api = ArticleAPI();

  Future<Either<Glitch, Article>> getArticles() async {
    final Either<Exception, String> apiResult = await api.getFeed();
    return apiResult.fold((Exception l) {
      return const Left<NoInternetGlitch, dynamic>(NoInternetGlitch()) as FutureOr<Either<Glitch, Article>>;
    }, (String r) { // Todo something is wrong here                    ^
      final Article article = Article.fromMap(jsonDecode(r)[0] as Map<String, dynamic>);
      return Right<Article, dynamic>(article) as FutureOr<Either<Glitch, Article>>;
    });
  }

}