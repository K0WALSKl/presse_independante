// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../services/api.dart' as _i3;
import '../services/articles_service.dart' as _i4;
import '../ui/views/articles/articles_viewmodel.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.Api>(() => _i3.Api());
  gh.lazySingleton<_i4.ArticlesService>(() => _i4.ArticlesService());
  gh.singleton<_i5.ArticlesViewModel>(_i5.ArticlesViewModel());
  return get;
}
