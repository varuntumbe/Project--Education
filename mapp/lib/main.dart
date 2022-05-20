import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mapp/ui/views/startup_view.dart';
import 'package:provider/provider.dart';
import 'locator.dart';
import './ui/router.dart';
import 'ui/shared/text_styles.dart';

void main() async {
  setupLocator();
  //debugPaintSizeEnabled = true;

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mjApp',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        fontFamily: 'roboto',
        textTheme: appwideTextTheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.blueAccent),
          ), // Here Im having the error
        ),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 10.0,
          color: Colors.blueAccent,
          textTheme: appbarWideTextTheme,
        ),
      ),
      home: StartUpView(),
      initialRoute: 'startup',
      onGenerateRoute: RouterGen.generateRoute,
    );
  }
}
