import 'package:flutter_test/flutter_test.dart';
import 'package:presse_independante/datamodels/article.dart';
import 'package:presse_independante/datamodels/article_source.dart';

void main() async {
  ArticleSource _articleSourceModel;
  ArticleSource _articleSourceModelFromJson;
  Map<String, dynamic> _articleSourceModelToJson;

  Article _articleModel;
  Article _articleModelFromJson;
  Map<String, dynamic> _articleModelToJson;

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

  group('Article Model', () {
    test('Check individual values when created from function', () async {
      _articleSourceModel = ArticleSource(
        'Reporterre',
        'https://reporterre.net/',
        'https://reporterre.net/IMG/siteon0.png?1588262321',
      );

      _articleModel = Article(
          url: 'https://reporterre.net/ThisIsTheURL',
          imageUrl: 'https://reporterre.net/ThisIsTheArticleImage',
          title: 'Portraits, interviews : Primaire des écologistes',
          description: 'DescriptionTest',
          publicationDate: DateTime.parse('2021-09-11T09:08:49.000Z'),
          author: 'This is the author',
          articleSource: _articleSourceModel);

      expect(_articleModel.url, isNotNull);
      expect(_articleModel.url.runtimeType, equals(String));
      expect(_articleModel.url, 'https://reporterre.net/ThisIsTheURL');

      expect(_articleModel.imageUrl, isNotNull);
      expect(_articleModel.imageUrl.runtimeType, equals(String));
      expect(_articleModel.imageUrl,
          'https://reporterre.net/ThisIsTheArticleImage');

      expect(_articleModel.title, isNotNull);
      expect(_articleModel.title.runtimeType, equals(String));
      expect(_articleModel.title,
          'Portraits, interviews : Primaire des écologistes');

      expect(_articleModel.description, isNotNull);
      expect(_articleModel.description.runtimeType, equals(String));
      expect(_articleModel.description, 'DescriptionTest');

      expect(_articleModel.publicationDate, isNotNull);
      expect(_articleModel.publicationDate.runtimeType, equals(DateTime));
      expect(_articleModel.publicationDate,
          DateTime.parse('2021-09-11 09:08:49.000Z'));

      expect(_articleModel.author, isNotNull);
      expect(_articleModel.author.runtimeType, equals(String));
      expect(_articleModel.author, 'This is the author');

      expect(_articleModel.articleSource, isNotNull);
      expect(_articleModel.articleSource.runtimeType, equals(ArticleSource));

      expect(_articleModel.articleSource.name, isNotNull);
      expect(_articleModel.articleSource.name.runtimeType, equals(String));
      expect(_articleModel.articleSource.name, 'Reporterre');

      expect(_articleModel.articleSource.url, isNotNull);
      expect(_articleModel.articleSource.url.runtimeType, equals(String));
      expect(_articleModel.articleSource.url, 'https://reporterre.net/');

      expect(_articleModel.articleSource.imageUrl, isNotNull);
      expect(_articleModel.articleSource.imageUrl.runtimeType, equals(String));
      expect(_articleModel.articleSource.imageUrl,
          'https://reporterre.net/IMG/siteon0.png?1588262321');
    });

    test('Check individual values when created FROM JSON', () async {
      _articleSourceModel = ArticleSource(
        'Reporterre',
        'https://reporterre.net/',
        'https://reporterre.net/IMG/siteon0.png?1588262321',
      );

      _articleModelFromJson = Article.fromJson(<String, dynamic>{
        'url': 'https://reporterre.net/ThisIsTheURL',
        'imageUrl': 'https://reporterre.net/ThisIsTheArticleImage',
        'title': 'Portraits, interviews : Primaire des écologistes',
        'description': 'DescriptionTest',
        'publicationDate': '2021-09-11T09:08:49.000Z',
        'author': 'This is the author',
        'articleSource': <String, String>{
          'name': 'Reporterre',
          'imageUrl': 'https://reporterre.net/IMG/siteon0.png?1588262321',
          'url': 'https://reporterre.net/'
        }
      });

      expect(_articleModelFromJson.url, isNotNull);
      expect(_articleModelFromJson.url.runtimeType, equals(String));
      expect(_articleModelFromJson.url, 'https://reporterre.net/ThisIsTheURL');

      expect(_articleModelFromJson.imageUrl, isNotNull);
      expect(_articleModelFromJson.imageUrl.runtimeType, equals(String));
      expect(_articleModelFromJson.imageUrl,
          'https://reporterre.net/ThisIsTheArticleImage');

      expect(_articleModelFromJson.title, isNotNull);
      expect(_articleModelFromJson.title.runtimeType, equals(String));
      expect(_articleModelFromJson.title,
          'Portraits, interviews : Primaire des écologistes');

      expect(_articleModelFromJson.description, isNotNull);
      expect(_articleModelFromJson.description.runtimeType, equals(String));
      expect(_articleModelFromJson.description, 'DescriptionTest');

      expect(_articleModelFromJson.publicationDate, isNotNull);
      expect(
          _articleModelFromJson.publicationDate.runtimeType, equals(DateTime));
      expect(_articleModelFromJson.publicationDate,
          DateTime.parse('2021-09-11 09:08:49.000Z'));

      expect(_articleModelFromJson.author, isNotNull);
      expect(_articleModelFromJson.author.runtimeType, equals(String));
      expect(_articleModelFromJson.author, 'This is the author');

      expect(_articleModelFromJson.articleSource, isNotNull);
      expect(_articleModelFromJson.articleSource.runtimeType,
          equals(ArticleSource));

      expect(_articleModelFromJson.articleSource.name, isNotNull);
      expect(
          _articleModelFromJson.articleSource.name.runtimeType, equals(String));
      expect(_articleModelFromJson.articleSource.name, 'Reporterre');

      expect(_articleModelFromJson.articleSource.url, isNotNull);
      expect(
          _articleModelFromJson.articleSource.url.runtimeType, equals(String));
      expect(
          _articleModelFromJson.articleSource.url, 'https://reporterre.net/');

      expect(_articleModelFromJson.articleSource.imageUrl, isNotNull);
      expect(_articleModelFromJson.articleSource.imageUrl.runtimeType,
          equals(String));
      expect(_articleModelFromJson.articleSource.imageUrl,
          'https://reporterre.net/IMG/siteon0.png?1588262321');
    });

    test('Check individual values when created TO JSON', () async {
      _articleSourceModel = ArticleSource(
        'Reporterre',
        'https://reporterre.net/',
        'https://reporterre.net/IMG/siteon0.png?1588262321',
      );

      _articleModel = Article(
          url: 'https://reporterre.net/ThisIsTheURL',
          imageUrl: 'https://reporterre.net/ThisIsTheArticleImage',
          title: 'Portraits, interviews : Primaire des écologistes',
          description: 'DescriptionTest',
          publicationDate: DateTime.parse('2021-09-11T09:08:49.000Z'),
          author: 'This is the author',
          articleSource: _articleSourceModel);

      _articleModelToJson = _articleModel.toJson();
      final Object? _url = _articleModelToJson['url'];
      final Object? _imageUrl = _articleModelToJson['imageUrl'];
      final Object? _title = _articleModelToJson['title'];
      final Object? _description = _articleModelToJson['description'];
      final Object? _publicationDate = _articleModelToJson['publicationDate'];
      final Object? _author = _articleModelToJson['author'];
      final Object? _articleSource = _articleModelToJson['articleSource'];

      expect(_articleModelToJson['url'], isNotNull);
      expect(_url.runtimeType, equals(String));
      expect(_articleModelToJson['url'], 'https://reporterre.net/ThisIsTheURL');

      expect(_articleModelToJson['imageUrl'], isNotNull);
      expect(_imageUrl.runtimeType, equals(String));
      expect(_articleModelToJson['imageUrl'],
          'https://reporterre.net/ThisIsTheArticleImage');

      expect(_articleModelToJson['title'], isNotNull);
      expect(_title.runtimeType, equals(String));
      expect(_articleModelToJson['title'],
          'Portraits, interviews : Primaire des écologistes');

      expect(_articleModelToJson['description'], isNotNull);
      expect(_description.runtimeType, equals(String));
      expect(_articleModelToJson['description'], 'DescriptionTest');

      expect(_articleModelToJson['publicationDate'], isNotNull);
      expect(_publicationDate.runtimeType, equals(String));
      expect(
          _articleModelToJson['publicationDate'], '2021-09-11T09:08:49.000Z');

      expect(_articleModelToJson['author'], isNotNull);
      expect(_author.runtimeType, equals(String));
      expect(_articleModelToJson['author'], 'This is the author');

      expect(_articleModelToJson['articleSource'], isNotNull);
      expect(_articleSource.runtimeType, equals(ArticleSource));
      expect(_articleModelToJson['articleSource'].name, isNotNull);
      expect(_articleModelToJson['articleSource'].name.runtimeType,
          equals(String));
      expect(_articleModelToJson['articleSource'].name, 'Reporterre');
      expect(_articleModelToJson['articleSource'].url, isNotNull);
      expect(
          _articleModelToJson['articleSource'].url.runtimeType, equals(String));
      expect(
          _articleModelToJson['articleSource'].url, 'https://reporterre.net/');
      expect(_articleModelToJson['articleSource'].imageUrl, isNotNull);
      expect(_articleModelToJson['articleSource'].imageUrl.runtimeType,
          equals(String));
      expect(_articleModelToJson['articleSource'].imageUrl,
          'https://reporterre.net/IMG/siteon0.png?1588262321');
    });
  });
}
