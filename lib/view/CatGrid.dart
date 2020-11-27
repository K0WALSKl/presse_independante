import 'dart:math';

import 'package:after_layout/after_layout.dart';
import 'package:presse_independante/model/core/NewsPaper.dart';
import 'package:presse_independante/model/glitch/NoInternetGlitch.dart';
import 'package:presse_independante/provider/ArticleProvider.dart';
import 'package:presse_independante/provider/CatProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../getIt.dart';

class NewsGrid extends StatefulWidget {
  @override
  _NewsGridState createState() => _NewsGridState();
}

class _NewsGridState extends State<NewsGrid> with AfterLayoutMixin {
  final provider = getIt<ArticleProvider>();
  List<Widget> articles = [];
  List<StaggeredTile> articleTiles = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[50],
        appBar: new AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                articleTiles.clear();
                articles.clear();
                provider.refreshGird();
              },
            )
          ],
          backgroundColor: Colors.white,
          centerTitle: true,
          title: new Text(
            'Cute kitten',
            style: GoogleFonts.pacifico(),
          ),
        ),
        body: new Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: articles.length == 0
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    staggeredTileBuilder: (index) => articleTiles[index],
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      return articles[index];
                    })));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    provider.getLastArticlesSorted();
    Color randomColor = Color.fromRGBO(Random().nextInt(255),
        Random().nextInt(255), Random().nextInt(255), 1);
    
    provider.articleStream.listen((snapshot) {
      snapshot.fold((l) {
        if (l is NoInternetGlitch) {
          articles.add(CatPhotoErrorTile(randomColor, "Unable to Connect"));
        }
      },
          (r) {
        for (int i = 0; i < r.length; i++) {
          articles.add(CatPhotoErrorTile(randomColor, r[i].title));
          int count = Random().nextInt(4);
          articleTiles.add(StaggeredTile.count(count, count));
        }
          // articles.add(CatPhotoTile(r)),
              });


      setState(() {});
    });
  }
}

class CatPhotoTile extends StatelessWidget {
  const CatPhotoTile(this.newsPapers);
  final List<NewsPaper> newsPapers;
  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Center(
          child: new Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(newsPapers[0].articles[0].title
            ),
          )),
    );
  }
}

class CatPhotoErrorTile extends StatelessWidget {
  const CatPhotoErrorTile(this.backgroundColor, this.errorMessage);
  final Color backgroundColor;
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return new Card(
      color: backgroundColor,
      child: new InkWell(
        onTap: () {},
        child: new Center(
          child: new Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(errorMessage),
          ),
        ),
      ),
    );
  }
}
