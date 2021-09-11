import 'package:flutter_test/flutter_test.dart';
// import 'package:presse_independante/datamodels/article.dart';
import 'package:presse_independante/datamodels/article_source.dart';

void main() async {
  ArticleSource _articleSourceModel;
  ArticleSource _articleSourceModelFromJson;
  Map<String, dynamic> _articleSourceModelToJson;

  // Article _articleModel;
  // Article _articleModelFromJson;
  // Map<String, dynamic> _articleModelToJson;

  group('ArticleSource Model', () {
    test('Check individual values when created from function', () async {
      _articleSourceModel = ArticleSource(
        'Reporterre',
        'https://reporterre.net/',
        'https://reporterre.net/IMG/siteon0.png?1588262321',
      );

      expect(_articleSourceModel.name, isNotNull);
      expect(_articleSourceModel.name.runtimeType, equals(String));
      expect(_articleSourceModel.name, 'Reporterre');

      expect(_articleSourceModel.url, isNotNull);
      expect(_articleSourceModel.url.runtimeType, equals(String));
      expect(_articleSourceModel.url, 'https://reporterre.net/');

      expect(_articleSourceModel.imageUrl, isNotNull);
      expect(_articleSourceModel.imageUrl.runtimeType, equals(String));
      expect(_articleSourceModel.imageUrl,
          'https://reporterre.net/IMG/siteon0.png?1588262321');
    });

    test('Check individual values when created FROM JSON', () async {
      _articleSourceModelFromJson = ArticleSource.fromJson(<String, String>{
        'name': 'Reporterre',
        'imageUrl': 'https://reporterre.net/IMG/siteon0.png?1588262321',
        'url': 'https://reporterre.net/'
      });

      expect(_articleSourceModelFromJson.name, isNotNull);
      expect(_articleSourceModelFromJson.name.runtimeType, equals(String));
      expect(_articleSourceModelFromJson.name, 'Reporterre');

      expect(_articleSourceModelFromJson.url, isNotNull);
      expect(_articleSourceModelFromJson.url.runtimeType, equals(String));
      expect(_articleSourceModelFromJson.url, 'https://reporterre.net/');

      expect(_articleSourceModelFromJson.imageUrl, isNotNull);
      expect(_articleSourceModelFromJson.imageUrl.runtimeType, equals(String));
      expect(_articleSourceModelFromJson.imageUrl,
          'https://reporterre.net/IMG/siteon0.png?1588262321');
    });

    test('Check individual values when created TO JSON', () async {
      _articleSourceModel = ArticleSource(
        'Reporterre',
        'https://reporterre.net/',
        'https://reporterre.net/IMG/siteon0.png?1588262321',
      );

      _articleSourceModelToJson = _articleSourceModel.toJson();

      expect(_articleSourceModelToJson['name'], isNotNull);
      expect(_articleSourceModelToJson['name'].runtimeType, equals(String));
      expect(_articleSourceModelToJson['name'], 'Reporterre');

      expect(_articleSourceModelToJson['url'], isNotNull);
      expect(_articleSourceModelToJson['url'].runtimeType, equals(String));
      expect(_articleSourceModelToJson['url'], 'https://reporterre.net/');

      expect(_articleSourceModelToJson['imageUrl'], isNotNull);
      expect(_articleSourceModelToJson['imageUrl'].runtimeType, equals(String));
      expect(_articleSourceModelToJson['imageUrl'],
          'https://reporterre.net/IMG/siteon0.png?1588262321');
    });
  });

  // group('Article Model', () {
  //   test('Check individual values when created from function', () async {});
  // });
}
