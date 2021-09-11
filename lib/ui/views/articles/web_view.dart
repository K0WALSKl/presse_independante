import 'dart:html' as html;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:presse_independante/app/router.gr.dart';
import 'package:presse_independante/datamodels/article.dart';

import 'articles_viewmodel.dart';

SafeArea articleWebScreen(double height, ArticlesViewModel model, double width,
    BuildContext context) {
  // PageController _pageViewController = PageController();

  return SafeArea(
      child: Column(
    children: <Widget>[
      topBar(height, model),
      Expanded(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: width / 3,
              childAspectRatio: 1.5 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          scrollDirection: Axis.vertical,
          key: PageStorageKey('storage-key'),
          itemCount: model.data!.length,
          reverse: false,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () async {
              // ExtendedNavigator(router: Router(), name: 'web-view-loader');
              kIsWeb
                  ? html.window.open(model.data![index].url, 'new tab')
                  : Navigator.pushNamed(context, '/web-view-loader',
                      arguments: WebViewLoaderRouteArgs(
                          url: model.data![index].url,
                          key: const Key('WebViewOpenNewTab')));
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.01, vertical: height * 0.02),
              height: height * 0.50,
              width: width * 0.15,
              child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Elements align left
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      articlePicture(height, width, model.data![index]),
                      articleTitle(width, model, index),
                      articleSourceNameAndTime(width, model, index),
                      articleDescription(width, model, index),
                      Spacer(),
                      articleAuthor(height, context, model, index, width)
                    ],
                  )),
            ),
          ),
        ),
      ),
    ],
  ));
}

AnimatedContainer topBar(double height, ArticlesViewModel model) {
  return AnimatedContainer(
    height: height * 0.08,
    duration: Duration(milliseconds: 200),
    child: AppBar(
      actions: <Widget>[
        Container(
          // padding: EdgeInsets.only(right: height * 0.02, left: height * 0.02),
          child: Icon(
            Icons.filter_list,
            color: Colors.black,
          ),
        )
      ],
      elevation: 60,
      backgroundColor: Colors.white,
      brightness: Brightness.dark,
      centerTitle: true,
      title: Text(
        'Presse Indépendante',
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Libre Bodoni',
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontSize: height * 0.04,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

String getReverseProxyLink(String imageUrl) {
  final Uri uri = Uri.parse(imageUrl);
  // TODO Remove the print
  print(uri.host.split('.')[0]);
  final String url = ('http://37.187.37.22/' +
      (uri.host.split('.')[0] == 'www'
          ? uri.host.split('.')[1]
          : uri.host.split('.')[0]) +
      uri.path);
  return url;
}

ClipRRect articlePicture(double height, double width, Article article) {
  String url;

  url = getReverseProxyLink(article.imageUrl);

  print(url);

  return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5), topRight: Radius.circular(5)),
      child: Image(
        image: article.imageUrl == null
            ? CachedNetworkImageProvider(article.articleSource.imageUrl)
            : CachedNetworkImageProvider(url),
        height: height * 0.40,
        width: double.infinity,
        alignment: Alignment.topCenter,
        fit: BoxFit.fill,
      ));
}

Padding articleTitle(double width, ArticlesViewModel model, int index) {
  return Padding(
    padding:
        EdgeInsets.fromLTRB(width * 0.0085, width * 0.0085, 0, width * 0.0045),
    child: Text(
      model.data![index].title,
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Row articleSourceNameAndTime(double width, ArticlesViewModel model, int index) {
  return Row(children: <Widget>[
    Flexible(
      child: Padding(
        padding: EdgeInsets.only(left: width * 0.0085),
        child: Text(
          model.data![index].articleSource.name,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    ),
    Text(
      ' il y a ' +
          model.getPublicationDateDifferenceFromNow(
              model.data![index].publicationDate),
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(fontSize: 18, color: Colors.grey),
    ),
  ]);
}

Padding articleDescription(double width, ArticlesViewModel model, int index) {
  return Padding(
    padding: EdgeInsets.all(width * 0.0085),
    child: Text(
      model.data![index].description,
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      maxLines: 8,
      style: TextStyle(
        fontSize: 18,
      ),
    ),
  );
}

SizedBox articleAuthor(double height, BuildContext context,
    ArticlesViewModel model, int index, double width) {
  String url;

  if (kIsWeb) {
    url = getReverseProxyLink(model.data![index].articleSource.imageUrl);
  } else {
    url = model.data![index].articleSource.imageUrl;
  }
  print(url);

  return SizedBox(
    height: height * 0.09,
    child: Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color.fromRGBO(214, 214, 214, 1),
          ),
        ),
      ),
      child: GestureDetector(
        onTap: () async {
          // ExtendedNavigator(router: Router(), name: 'web-view-loader');
          Navigator.pushNamed(context, '/web-view-loader',
              arguments: WebViewLoaderRouteArgs(
                  url: model.data![index].articleSource.url,
                  key: const Key('WebViewLoaderThree')));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: width * 0.0085),
              child: Image.network(
                url,
                height: height * 0.05,
                fit: BoxFit.contain,
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: width * 0.0085),
                child: Text(
                  model.data![index].author,
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
