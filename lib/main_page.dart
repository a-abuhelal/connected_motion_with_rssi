import 'package:connected_motion_with_rssi/contents.dart';
import 'package:connected_motion_with_rssi/control_screen.dart';
import 'package:flutter/material.dart';
//import 'package:connected_motion_ui/main.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }

  // This widget is the root of your application.
}

class _MyAppState extends State<MyApp> {
  var currentScreen = 'main-page';

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = const PageContent();
    if (currentScreen == 'main-page') {
      screenWidget = const PageContent();
    }
    if (currentScreen == 'control-page') {
      screenWidget = const ControlScreen();
    }

    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kDarkColorScheme.onPrimaryContainer,
          foregroundColor: kDarkColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.primaryContainer,
              foregroundColor: kDarkColorScheme.onPrimaryContainer),
        ),
        //using themedata constructor unsures that the
        //text theme will only be applied to this specific text
        /*textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                color: kDarkColorScheme.onSecondaryContainer,
                fontSize: 18,
              ),
            ),*/
        iconTheme: const IconThemeData().copyWith(
          color: kDarkColorScheme.onSecondaryContainer,
        ),
      ),
      theme: ThemeData().copyWith(
        //we don't need this property anymore because new flutter
        //vesions come default with materialDart3
        //useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.primaryContainer,
          foregroundColor: kColorScheme.onPrimaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        //using themedata constructor unsures that the
        //text theme will only be applied to this specific text
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 18,
              ),
            ),
        iconTheme: const IconThemeData().copyWith(
          color: kColorScheme.onSecondaryContainer,
        ),
      ),
      //textScaleFactor: 1.2,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 180, 240, 83),
          toolbarHeight: 80,
          centerTitle: true,
          title: const Text(
            'Test App',
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 107, 107, 107),
                Color.fromARGB(150, 37, 101, 138),
              ],
            ),
          ),
          child: Center(
            child: screenWidget,
          ),
        ),
      ),
    );
  }
}
