import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:presse_independante/services/api_for_mobile.dart';
import 'package:presse_independante/services/api_for_web.dart';
import 'package:presse_independante/services/api_manager.dart';

import 'app/locator.dart';
import 'app/router.gr.dart';

Future<void> main() async {
  setupLocator();
  if (kIsWeb)
    locator.registerFactory<ApiManager>(() => ApiForWeb());
  else
    locator.registerFactory<ApiManager>(() => ApiForMobile());
  runApp(Home(key: const Key('HomePage')));
}

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final Router _appRouter = Router();

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
