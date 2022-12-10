import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'bloc_observer.dart';
import 'injection_container.dart' as di;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}



