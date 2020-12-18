import 'package:flutter/material.dart';
import 'package:presse_independante/app/locator.dart';
import 'package:stacked/stacked.dart';

import 'articles_viewmodel.dart';

class ArticlesView extends StatelessWidget {
  // const ArticlesView({Key: key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                ? ListView.separated(
                key: PageStorageKey('storage-key'),
                padding: const EdgeInsets.only(top: 55),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
                itemCount: model.data.length,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: Colors.purple[100],
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 20),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              model.data[index].title,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              model.data[index].description,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Icon(
                          Icons.star,
                          color: Colors.purple[200],
                        ),
                      )
                    ],
                  ),
                ))
                : Container(
              color: Colors.cyan,
              alignment: Alignment.center,
              child: Text(
                model.error.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            )
        )
        , viewModelBuilder: () => locator<ArticlesViewModel>(),
    );
  }
}
