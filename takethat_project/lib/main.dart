import 'package:flutter/material.dart';
import 'pages/welcome_page.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TakeThat! Social Media',
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.purple,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              selectedItemColor: Colors.purple,
              unselectedItemColor: Colors.grey,
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.purple,
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.grey,
              iconTheme: IconThemeData(color: Colors.white),
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.grey,
              selectedItemColor: Colors.purple,
              unselectedItemColor: Colors.white,
              type: BottomNavigationBarType.fixed,
            ),
          ),
          themeMode: currentMode,
          home: const WelcomePage(),
        );
      },
    );
  }
}
