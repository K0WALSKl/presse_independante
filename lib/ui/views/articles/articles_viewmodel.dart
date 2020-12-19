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

  String getPublicationDateDifferenceFromNow(DateTime date) {
    Duration difference = DateTime.now().difference(date);
    if (difference.inHours > 23)
      return difference.inDays.toString() + (difference.inDays > 1 ? ' jours' : ' jour');
    return difference.inHours.toString() + (difference.inHours > 1 ? ' heures' : ' heure');
  }
}