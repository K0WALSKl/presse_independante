// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/foundation.dart' as _i5;
import 'package:flutter/material.dart' as _i2;

import '../ui/views/articles/articles_view.dart' as _i3;
import '../ui/views/webview/webview_view.dart' as _i4;

class Router extends _i1.RootStackRouter {
  Router([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    ArticlesViewRoute.name: (routeData) => _i1.MaterialPageX<void>(
        routeData: routeData,
        builder: (_) {
          return _i3.ArticlesView();
        }),
    WebViewLoaderRoute.name: (routeData) => _i1.MaterialPageX<void>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<WebViewLoaderRouteArgs>();
          return _i4.WebViewLoader(key: args.key, url: args.url);
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(ArticlesViewRoute.name, path: '/'),
        _i1.RouteConfig(WebViewLoaderRoute.name, path: '/web-view-loader')
      ];
}

class ArticlesViewRoute extends _i1.PageRouteInfo<void> {
  const ArticlesViewRoute() : super(name, path: '/');

  static const String name = 'ArticlesViewRoute';
}

class WebViewLoaderRoute extends _i1.PageRouteInfo<WebViewLoaderRouteArgs> {
  WebViewLoaderRoute({required _i5.Key? key, required String? url})
      : super(name,
            path: '/web-view-loader',
            args: WebViewLoaderRouteArgs(key: key, url: url));

  static const String name = 'WebViewLoaderRoute';
}

class WebViewLoaderRouteArgs {
  const WebViewLoaderRouteArgs({required this.key, required this.url});

  final _i5.Key? key;

  final String? url;
}
