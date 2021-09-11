import 'package:auto_route/annotations.dart';
import 'package:presse_independante/ui/views/articles/articles_view.dart';
import 'package:presse_independante/ui/views/webview/webview_view.dart';

@MaterialAutoRouter(routes: <AutoRoute>[
  AutoRoute<void>(page: ArticlesView, initial: true),
  AutoRoute<void>(page: WebViewLoader),
])
class $Router {}
