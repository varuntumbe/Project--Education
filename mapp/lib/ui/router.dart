import 'package:flutter/material.dart';
import 'package:mapp/ui/views/questionspage_view.dart';
import 'package:mapp/ui/views/signup_view.dart';
import 'package:mapp/ui/views/startup_view.dart';
import 'views/home_view.dart';
import 'views/login_view.dart';

class RouterGen {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case 'signup':
        return MaterialPageRoute(builder: (_) => SignUpView());
      case 'startup':
        return MaterialPageRoute(builder: (_) => StartUpView());
      case 'questionspage':
        return MaterialPageRoute(
          builder: (_) => QuestionspageView(
            extractedText: settings.arguments,
          ),
        );
      case 'error':
        return MaterialPageRoute(
            builder: (_) => Scaffold(body: Center(child: Text('error'))));
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
