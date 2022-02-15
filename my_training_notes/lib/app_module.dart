import 'package:injectable/injectable.dart';
import 'package:my_training_notes/utils/firebase.dart';

@module
abstract class AppModule {
  @preResolve
  Future<FirebaseService> get fireService => FirebaseService.init();
}
