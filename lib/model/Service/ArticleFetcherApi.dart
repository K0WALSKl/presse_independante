import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:presse_independante/model/core/NewsPaper.dart';

class ArticleFetcherApi {
  NewsPaper source;
  ArticleFetcherApi({this.source});

  Future<Either<Exception, String>> getLastArticles() async {
    try {
      final uri = http.get(source.fluxUrl);
      final response = await http.get(uri);
      return Right(response.body);
    } catch (e) {
      return (Left(e));
    }
  }
}
