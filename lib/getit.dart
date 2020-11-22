import 'package:presse_independante/provider/ArticleProvider.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<ArticleProvider>(ArticleProvider());
}