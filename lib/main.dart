import 'package:flutter/material.dart';
import 'package:flutter_weather_exercise/presentation/app_widget.dart';
import 'package:injectable/injectable.dart';

import 'injection.dart';

void main()  async {
  WidgetsFlutterBinding.ensureInitialized(); // need explicit binding before new Firebase call
  configureInjection(Environment.prod);
  runApp(MyApp());
}
