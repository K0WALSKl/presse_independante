import 'package:injectable/injectable.dart';
import 'package:presse_independante/app/locator.dart';
import 'package:presse_independante/datamodels/Article.dart';

import 'api.dart';

@lazySingleton
class ArticlesService {
  final _api = locator<Api>();

  List<Article> _articles; // = List<Article>();*
  List<Article> get articles => _articles;

  bool get hasArticles => _articles != null && _articles.isNotEmpty;

  Future<List<Article>> getArticles() async {
    _articles = await _api.getLastArticles();
    return _articles;
  }
}