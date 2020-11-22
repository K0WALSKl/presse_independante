import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class LaReleveEtLaPesteAPI {
  final String endpoint = 'https://lareleveetlapeste.fr/feed';

  Future<Either<Exception, String>> getFeed() async {
    try {
      final http.Response response = await http.get(endpoint);
      return Right<dynamic, String>(response.body) as Future<Either<Exception, String>>;
    } catch (e) {
      return Left<dynamic, Exception>(e) as Future<Either<Exception, String>>;
    }
  }

  // Future<AtomFeed> getFeed() =>
  //     http.read(endpoint).then((xmlString) => AtomFeed.parse(xmlString));
}