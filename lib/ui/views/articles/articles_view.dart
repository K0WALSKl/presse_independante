import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:presse_independante/app/locator.dart';
import 'package:presse_independante/app/router.gr.dart';
import 'package:presse_independante/datamodels/Article.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import 'articles_viewmodel.dart';

class ArticlesView extends StatefulWidget {
  // const ArticlesView({Key: key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ArticlesViewScreen();
}

class ArticlesViewScreen extends State<ArticlesView> {
  // TODO Check prefs...
  List<String> chosenMediaTitle = <String>[
    'Les Jours',
    'Reporterre',
    'La Releve Et La Peste',
    'Eco-Bretons',
    'Fakir',
  ];

  List<bool> chosenMediaIsChecked = [
    true,
    true,
    true,
    true,
    true,
  ];

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
                  ? articleScreen(height, model, width, context)
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

  SafeArea articleScreen(double height, ArticlesViewModel model, double width, BuildContext context) {
    return SafeArea(
        child: Column(
      children: <Widget>[
        topBar(height, model),
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

  Column loadingScreen(double height) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AnimatedContainer(
            height: _showAppbar ? height * 0.118 : 0.0,
            duration: Duration(milliseconds: 200),
            child: AppBar(
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
              actions: <Widget>[
                //add buttons here
              ],
            ),
          ),
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CircularProgressIndicator(
                    backgroundColor: Colors.cyanAccent,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
              ),
              // Padding(
              //   padding: EdgeInsets.all(height * 0.05),
              //   child: Text(
              //     'Chargement des articles',
              //     style: TextStyle(
              //       color: Colors.black,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // )

            ],
          ),
        ),
        ],
    );
  }

  AnimatedContainer topBar(double height, ArticlesViewModel model) {
    return AnimatedContainer(

      height: _showAppbar ? height * 0.08 : 0.0,
      duration: Duration(milliseconds: 200),
      child: AppBar(
        actions: <Widget>[
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(5.0)), //this right here
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  StatefulBuilder(
                                    builder: (context, _setState) => ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: chosenMediaTitle.length,
                                        itemBuilder: (context, index) {
                                          return CheckboxListTile(
                                              title: Text(chosenMediaTitle[index]),
                                              value: chosenMediaIsChecked[index],
                                              onChanged: (val) {
                                                _setState(
                                                    () {
                                                      chosenMediaIsChecked[index] = val;
                                                    }
                                                );
                                              }
                                          );
                                        }
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      RaisedButton(
                                          child: Text("Annuler"),
                                          onPressed: () async {
                                            Navigator.of(context, rootNavigator: true).pop('dialog');
                                          }
                                      ),
                                      RaisedButton(
                                        color: Colors.blueAccent,
                                          child: Text(
                                              "Sauvegarder",
                                            style: TextStyle(
                                              color: Colors.white
                                            ),
                                          ),
                                          onPressed: () async {
                                            final prefs = await SharedPreferences.getInstance();
                                            List<String> pickedMedia = List<String>();
                                            for (int i = 0; i < chosenMediaTitle.length; i++) {
                                              if (chosenMediaIsChecked[i])
                                                pickedMedia.add(chosenMediaTitle[i]);
                                            }
                                            prefs.setStringList('chosenMedia', pickedMedia);
                                            Navigator.of(context, rootNavigator: true).pop('dialog');
                                            model.initialise();
                                          })
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: Container(
              padding: EdgeInsets.only(right: height * 0.02, left: height * 0.02),
              child: Icon(
                Icons.filter_list,
                color: Colors.black,
              ),
            ),
          )
        ],
        elevation: 60,
        backgroundColor: Colors.white,
        brightness: Brightness.dark,
        centerTitle: true,
        title: GestureDetector(
          onTap: () async {
            if (_pageViewController.hasClients) {
              if (_pageViewController.page == 0) {
                return model.initialise();
              }
              await _pageViewController.animateToPage(0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            } else {
              return null;
            }
          },
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
      ),
    );
  }

  ClipRRect articlePicture(double height, double width, Article article) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5), topRight: Radius.circular(5)),
        child: Image(
          image: article.imageUrl == null ? CachedNetworkImageProvider(article.articleSource.imageUrl) : CachedNetworkImageProvider(article.imageUrl),
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

  Dialog showFilterDialog(BuildContext context) {
    return Dialog(

      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(5.0)), //this right here
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    itemCount: chosenMediaTitle.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                          value: chosenMediaIsChecked[index],
                          onChanged: null
                      );
                    }
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
//
// class FilterDialog extends StatelessWidget {
//   final Map<String, bool> chosenMedia;
//   BuildContext context
//
//   const FilterDialog({
//     Map<String, bool> chosenMedia, BuildContext context
//   }): this.chosenMedia = chosenMedia;
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//
//       shape: RoundedRectangleBorder(
//           borderRadius:
//           BorderRadius.circular(5.0)), //this right here
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             height: 200,
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ListView.builder(
//                     itemCount: chosenMedia.length,
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
