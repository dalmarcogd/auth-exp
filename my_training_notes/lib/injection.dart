import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:my_training_notes/injection.config.dart';

final GetIt locator = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => await $initGetIt(locator);
