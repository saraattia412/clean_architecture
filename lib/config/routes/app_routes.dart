import 'package:clean_architecture/features/random/presentation/views/quoteScreen.dart';
import 'package:clean_architecture/features/splash/presentation/views/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case '/quote':
        return MaterialPageRoute(builder: (context) => const QuoteScreen());
      default:
        return null;
    }
  }
}