import 'package:injectable/injectable.dart';
import 'package:presse_independante/app/locator.dart';
import 'package:presse_independante/datamodels/article.dart';

// import 'api.dart';
import 'api_manager.dart';

@lazySingleton
class ArticlesService {
  final ApiManager _api = locator<ApiManager>();

  late List<Article> _articles; // = List<Article>();*
  List<Article> get articles => _articles;

  bool get hasArticles => _articles != null && _articles.isNotEmpty;

  Future<List<Article>> getArticles() async {
    _articles = await _api.getLastArticles();
    return _articles;
  }
}
