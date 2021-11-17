import 'package:flutter/material.dart';
import 'package:flutter_weather_exercise/domain/user/user_model.dart';
import 'package:flutter_weather_exercise/presentation/app_widget.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'injection.dart';

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory =
  await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(UserAdapter());

  configureInjection(Environment.prod);
  runApp(MyApp());
}
