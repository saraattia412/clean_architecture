import 'package:clean_architecture/config/themes/app_themes.dart';
import 'package:clean_architecture/core/utils/app_strings.dart';
import 'package:clean_architecture/features/random/presentation/views/quoteScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/routes/app_routes.dart';
import 'package:clean_architecture/injection_container.dart' as di;

import 'features/random/presentation/cubit/cubit.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => di.sl<RandomQuoteCubit>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: appTheme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        home: const QuoteScreen(),
      ),
    );
  }
}
