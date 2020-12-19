// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/views/articles/articles_view.dart';
import '../ui/views/webview/webview_view.dart';

class Routes {
  static const String articlesView = '/';
  static const String webViewLoader = '/web-view-loader';
  static const all = <String>{
    articlesView,
    webViewLoader,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.articlesView, page: ArticlesView),
    RouteDef(Routes.webViewLoader, page: WebViewLoader),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    ArticlesView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ArticlesView(),
        settings: data,
      );
    },
    WebViewLoader: (data) {
      final args = data.getArgs<WebViewLoaderArguments>(
        orElse: () => WebViewLoaderArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => WebViewLoader(
          key: args.key,
          url: args.url,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// WebViewLoader arguments holder class
class WebViewLoaderArguments {
  final Key key;
  final String url;
  WebViewLoaderArguments({this.key, this.url});
}
