// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../services/api.dart';
import '../services/articles_service.dart';
import '../ui/views/articles/articles_viewmodel.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<Api>(() => Api());
  gh.lazySingleton<ArticlesService>(() => ArticlesService());

  // Eager singletons must be registered in the right order
  gh.singleton<ArticlesViewModel>(ArticlesViewModel());
  return get;
}
