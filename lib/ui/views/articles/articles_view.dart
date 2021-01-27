import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:presse_independante/app/locator.dart';
import 'package:presse_independante/app/router.gr.dart';
import 'package:presse_independante/datamodels/Article.dart';
import 'package:stacked/stacked.dart';

import 'articles_viewmodel.dart';

class ArticlesView extends StatefulWidget {
  // const ArticlesView({Key: key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ArticlesViewScreen();
}

class ArticlesViewScreen extends State<ArticlesView> {
  ScrollController _scrollViewController;
  PageController _pageViewController;

  bool _showAppbar = true;
  bool isScrollingDown = true;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    // _scrollViewController.dispose();
    _pageViewController.dispose();
    // _scrollViewController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.white,
    //   statusBarBrightness: Brightness.dark,
    //   statusBarIconBrightness: Brightness.dark,
    // ));

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ViewModelBuilder<ArticlesViewModel>.reactive(
      disposeViewModel: false, // TODO Qu'est ce que c'est ?
      initialiseSpecialViewModelsOnce: true,
      builder: (context, model, child) => Scaffold(
          body: model.isBusy
              ? loadingScreen(height)
              : !model.hasError
                  ? articleScreen(height, model, width)
                  : errorScreen(model)
      ),
      viewModelBuilder: () => locator<ArticlesViewModel>(),
    );
  }

  SafeArea errorScreen(ArticlesViewModel model) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/icon/error.png", height: MediaQuery.of(context).size.height * 0.2,),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            child: Text(
              "Impossible de récupérer les articles. Merci de réessayer plus tard.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.03,
                  color: Colors.black
              ),
            ),
          ),
        ],
      ),
    );
  }

  SafeArea articleScreen(double height, ArticlesViewModel model, double width) {
    return SafeArea(
        child: Column(
      children: <Widget>[
        topBar(height),
        Expanded(
          child: PageView.builder(
              scrollDirection: Axis.vertical,
              controller: _pageViewController,
              key: PageStorageKey('storage-key'),
              // padding: EdgeInsets.only(top: height * 0.001),
              // separatorBuilder: (context, index) => SizedBox(
              //       height: height * 0.001,
              //     ),
              itemCount: model.data.length,
              reverse: false,
              itemBuilder: (context, index) => GestureDetector(
                    onTap: () async {
                      // ExtendedNavigator(router: Router(), name: 'web-view-loader');
                      Navigator.pushNamed(context, '/web-view-loader',
                          arguments: WebViewLoaderArguments(
                              url: model.data[index].url));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.01, vertical: height * 0.02),
                      height: height * 0.97,
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
                              articlePicture(
                                  height, width, model.data[index]),
                              articleTitle(width, model, index),
                              articleSourceNameAndTime(width, model, index),
                              articleDescription(width, model, index),
                              Spacer(),
                              articleAuthor(
                                  height, context, model, index, width)
                            ],
                          )),
                    ),
                  )),
        ),
      ],
    ));
  }

  SizedBox articleAuthor(double height, BuildContext context,
      ArticlesViewModel model, int index, double width) {
    return SizedBox(
      height: height * 0.09,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey[350],
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () async {
            // ExtendedNavigator(router: Router(), name: 'web-view-loader');
            Navigator.pushNamed(context, '/web-view-loader',
                arguments: WebViewLoaderArguments(
                    url: model.data[index].articleSource.websiteUrl));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: width * 0.02),
                child: Image.network(
                  model.data[index].articleSource.imageUrl,
                  height: height * 0.05,
                  fit: BoxFit.contain,
                ),
              ),
              Flexible(
                child: Padding(
                    padding: EdgeInsets.only(left: width * 0.05),
                    child: Text(
                        model.data[index].author,
                      maxLines: 1,
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

  Center loadingScreen(double height) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.black),
          ),
          Padding(
            padding: EdgeInsets.all(height * 0.05),
            child: Text(
              'Chargement des articles',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  AnimatedContainer topBar(double height) {
    return AnimatedContainer(
      height: _showAppbar ? height * 0.08 : 0.0,
      duration: Duration(milliseconds: 200),
      child: AppBar(
        elevation: 60,
        backgroundColor: Colors.white,
        brightness: Brightness.dark,
        centerTitle: true,
        title: GestureDetector(
          onTap: () => _pageViewController.hasClients
              ? _pageViewController.animateToPage(0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut)
              : null,
          child: Text(
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
        actions: <Widget>[
          //add buttons here
        ],
      ),
    );
  }

  ClipRRect articlePicture(double height, double width, Article article) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5), topRight: Radius.circular(5)),
        child: Image(
          image: CachedNetworkImageProvider(article.imageUrl) ?? article.articleSource.imageUrl,
          height: height * 0.40,
          width: width * 0.96,
          alignment: Alignment.topCenter,
          fit: BoxFit.fill,
        ));
  }

  Padding articleTitle(double width, ArticlesViewModel model, int index) {
    return Padding(
      padding: EdgeInsets.all(width * 0.02),
      child: Text(
        model.data[index].title,
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

  Padding articleDescription(double width, ArticlesViewModel model, int index) {
    return Padding(
      padding: EdgeInsets.all(width * 0.02),
      child: Text(
        model.data[index].description,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        maxLines: 4,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Row articleSourceNameAndTime(
      double width, ArticlesViewModel model, int index) {
    return Row(children: <Widget>[
      Flexible(
        child: Padding(
          padding: EdgeInsets.all(width * 0.02),
          child: Text(
            model.data[index].articleSource.name,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ),
      Text(
        'il y a ' +
            model.getPublicationDateDifferenceFromNow(
                model.data[index].publicationDate),
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
    ]);
  }
}
