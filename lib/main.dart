import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:secure_storge_and_data/pages/home_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Secure Storage';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.blueAccent,
      unselectedWidgetColor: Colors.white12,
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(Colors.white),
      ), colorScheme: const ColorScheme.dark().copyWith(secondary: Colors.white38),
    ),
      home: const HomePage(),
    );
  }
