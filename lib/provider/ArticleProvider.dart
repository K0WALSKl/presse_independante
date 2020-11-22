import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:presse_independante/model/Core/Article.dart';
import 'package:presse_independante/model/Helper/ArticleHelper.dart';
import 'package:presse_independante/model/glitch/Glitch.dart';

class ArticleProvider extends ChangeNotifier {
  final ArticleHelper _helper = ArticleHelper();
  final StreamController<Either<Glitch, Article>> _streamController = StreamController<Either<Glitch, Article>>();

  Stream<Either<Glitch, Article>> get articleStream {
    return _streamController.stream;
  }

  Future<void> getLastsXArticles(int nbArticles) async {
    for (int i = 0; i < nbArticles; i++) {
      final Either<Glitch, Article> articleHelperResult = await _helper.getArticles();
      _streamController.add(articleHelperResult);
    }
  }
}