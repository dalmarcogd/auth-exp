import 'package:flutter/material.dart';
import 'package:my_training_notes/app.dart';
import 'package:my_training_notes/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();
  runApp(const MyApp());
}
