import 'package:flutter/material.dart' hide Router;
import 'package:flutter/services.dart';
import 'package:presse_independante/ui/views/articles/articles_view.dart';

import 'app/locator.dart';
import 'app/router.gr.dart';

void main() async {
  setupLocator();
  runApp(Home());
}

class Home extends StatelessWidget {
  final _appRouter = Router();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Presse Indépendante',
        initialRoute: '/',
        key: const Key('RootMaterialApp'),
        home: MaterialApp.router(
            routeInformationParser: _appRouter.defaultRouteParser(),
            routerDelegate: _appRouter.delegate()));
  }
}
