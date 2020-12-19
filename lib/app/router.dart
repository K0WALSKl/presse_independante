import 'package:auto_route/auto_route_annotations.dart';
import 'package:presse_independante/ui/views/articles/articles_view.dart';
import 'package:presse_independante/ui/views/webview/webview_view.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: ArticlesView, initial: true),
  MaterialRoute(page: WebViewLoader),
])
class $Router {}
