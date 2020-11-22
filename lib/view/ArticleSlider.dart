import 'dart:math';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:presse_independante/getit.dart';
import 'package:presse_independante/model/glitch/NoInternetGlitch.dart';
import 'package:presse_independante/provider/ArticleProvider.dart';

class ArticleSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ArticleSlider();
}

class _ArticleSlider extends State<ArticleSlider> with AfterLayoutMixin {
  final provider = getIt<ArticleProvider>();
  List<Widget> articles = <Widget>[];

  @override
  void afterFirstLayout(BuildContext context) {
    provider.getLastsXArticles(2);

    provider.articleStream.listen((snapshot) {
      snapshot.fold((l) {
        if (l is NoInternetGlitch) {
          final Color randomColor = Color.fromRGBO(
              Random().nextInt(255),
              Random().nextInt(255),
              Random().nextInt(255),
              1
          );
          articles.add(ArticleError(randomColor, 'Unable to Connect'));
        }
      },
              (r) => {
        articles.add(CatPhotoTile(r.url)),
          });
      int count = Random().nextInt(4);
      catPhotoTiles.add(StaggeredTile.count(count, count));

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class Article extends StatelessWidget {
  const Article(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(4.0),
          child: Text(title)
        ),
      ),
    );
  }
}

class ArticleError extends StatelessWidget {
  const ArticleError(this.backgroundColor, this.errorMessage);
  final Color backgroundColor;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: InkWell(
        onTap: () {},
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(errorMessage),
          ),
        ),
      ),
    );
  }
}
