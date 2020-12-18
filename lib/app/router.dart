import 'package:auto_route/auto_route_annotations.dart';
import 'package:presse_independante/ui/views/articles/articles_view.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: ArticlesView, initial: true),
])
class $Router {}
