import 'dart:async';

import 'package:presse_independante/model/core/Article.dart';
import 'package:presse_independante/model/core/CatPhoto.dart';
import 'package:presse_independante/model/core/NewsPaper.dart';
import 'package:presse_independante/model/glitch/glitch.dart';
import 'package:presse_independante/model/helper/ArticleHelper.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ArticleProvider extends ChangeNotifier {
  final _helper = ArticleHelper();
  final _streamController = StreamController<Either<Glitch, List<NewsPaper>>>();
  Stream<Either<Glitch, List<NewsPaper>>> get articleStream {
    return _streamController.stream;
  }

  Future<void> getLastArticles() async {
    final articleHelperResult = await _helper.getLastArticles();
    print(articleHelperResult);
    _streamController.add(articleHelperResult);
  }

  void refreshGird() {
    getLastArticles();
  }
}
