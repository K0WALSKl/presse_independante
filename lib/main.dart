import 'package:flutter/material.dart' hide Router;
import 'package:presse_independante/ui/views/articles/articles_view.dart';

import 'app/locator.dart';
import 'app/router.gr.dart';

void main() async {
  setupLocator();
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wesh',
      initialRoute: '/',
      onGenerateRoute: Router(),
    );
  }
}