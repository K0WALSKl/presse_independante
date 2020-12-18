// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/views/articles/articles_view.dart';

class Routes {
  static const String articlesView = '/';
  static const all = <String>{
    articlesView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.articlesView, page: ArticlesView),
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
  };
}
