import 'package:flutter/material.dart' hide Router;
import 'package:presse_independante/app/locator.dart';
import 'package:presse_independante/app/router.gr.dart';
import 'package:stacked/stacked.dart';

import 'articles_viewmodel.dart';

class ArticlesView extends StatelessWidget {
  // const ArticlesView({Key: key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ViewModelBuilder<ArticlesViewModel>.reactive(
      disposeViewModel: false, // TODO Qu'est ce que c'est ?
      initialiseSpecialViewModelsOnce: true,
      builder: (context, model, child) => Scaffold(
          body: model.isBusy
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.purple[200]),
                      ),
                      Text(
                        'Loading Posts',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                )
              : !model.hasError
                  ? SafeArea(
                      child: ListView.separated(
                          key: PageStorageKey('storage-key'),
                          padding: EdgeInsets.only(top: height * 0.001),
                          separatorBuilder: (context, index) => SizedBox(
                                height: height * 0.001,
                              ),
                          itemCount: model.data.length,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () async {
                                  // ExtendedNavigator(router: Router(), name: 'web-view-loader');
                                  Navigator.pushNamed(
                                      context, '/web-view-loader',
                                      arguments: WebViewLoaderArguments(
                                          url: model.data[index].url));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.01,
                                      vertical: height * 0.02),
                                  height: height * 0.97,
                                  child: Card(
                                      elevation: 3.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start, // Elements align left
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          articlePicture(height),
                                          articleTitle(width, model, index),
                                          articleSourceNameAndTime(width, model, index),
                                          articleDescription(width, model, index)
                                        ],
                                      )),
                                ),
                              )
                          ))
                  : SafeArea(
                      child: Container(
                        color: Colors.cyan,
                        alignment: Alignment.center,
                        child: Text(
                          model.error.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )),
      viewModelBuilder: () => locator<ArticlesViewModel>(),
    );
  }

  Flexible articleTitle(double width, ArticlesViewModel model, int index) {
    return Flexible(
                                          child: Padding(
                                            padding:
                                                EdgeInsets.all(width * 0.02),
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
                                          ),
                                        );
  }

  ClipRRect articlePicture(double height) {
    return ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5)),
                                            child: Image.network(
                                              'https://lenergeek.com/wp-content/uploads/2019/07/eolienne-haliade-general-electric.jpeg',
                                              height: height * 0.40,
                                              alignment: Alignment.topCenter,
                                              fit: BoxFit.fill,
                                            ));
  }

  Padding articleDescription(double width, ArticlesViewModel model, int index) {
    return Padding(
                                          padding:
                                              EdgeInsets.all(width * 0.02),
                                          child: Text(
                                            model.data[index].description,
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 9,
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        );
  }

  Row articleSourceNameAndTime(double width, ArticlesViewModel model, int index) {
    return Row(children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  width * 0.02),
                                              child: Text(
                                                model.data[index]
                                                    .articleSource.name,
                                                textAlign: TextAlign.left,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                maxLines: 3,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                          Text(
                                              'il y a ' +
                                                  model.getPublicationDateDifferenceFromNow(
                                                      model.data[index]
                                                          .publicationDate),
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                          ),
                                        ]);
  }
}
