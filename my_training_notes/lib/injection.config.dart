// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'app_module.dart' as _i8;
import 'services/authentication/authentication.dart' as _i7;
import 'services/authentication/iauthentication.dart' as _i6;
import 'services/users/iusers.dart' as _i4;
import 'services/users/users.dart' as _i5;
import 'utils/firebase.dart' as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  await gh.factoryAsync<_i3.FirebaseService>(() => appModule.fireService,
      preResolve: true);
  gh.factory<_i4.Users>(
      () => _i5.UsersImpl(firebaseService: get<_i3.FirebaseService>()));
  gh.factory<_i6.Authentication>(() =>
      _i7.AuthenticationImpl(get<_i3.FirebaseService>(), get<_i4.Users>()));
  return get;
}

class _$AppModule extends _i8.AppModule {}
