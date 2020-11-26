import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:presse_independante/model/core/NewsPaper.dart';

class ArticleFetcherApi {
  String source;
  // = NewsPaper(
  //     sourceName: "La relève et la peste",
  //     url: "https://lareleveetlapeste.fr/",
  //     fluxUrl: 'https://lareleveetlapeste.fr/feed',
  //     imageUrl: "https://api.tipeee.com/cache/20200608141825/media/200/200/zoom/1068263/202006085ede2c920dd3b.jpeg",
  //     donationUrl: ["https://fr.tipeee.com/la-releve-et-la-peste"]
  // );

  ArticleFetcherApi({this.source});

  Future<Either<Exception, String>> getLastArticles() async {
    try {
      final uri = source;
      final response = await http.get(uri);
      return Right(response.body);
    } catch (e) {
      return (Left(e));
    }
  }
}
