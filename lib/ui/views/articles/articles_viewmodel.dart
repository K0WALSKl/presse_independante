import 'package:injectable/injectable.dart';
import 'package:presse_independante/app/locator.dart';
import 'package:presse_independante/datamodels/Article.dart';
import 'package:presse_independante/services/api.dart';
import 'package:stacked/stacked.dart';

@singleton
class ArticlesViewModel extends FutureViewModel<List<Article>> {
  ArticlesViewModel();

  @override
  Future<List<Article>> futureToRun() => locator<Api>().getLastArticles();
}