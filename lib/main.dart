import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_first_project/splash_page.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox("box");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static Locale locale = const Locale('fa', 'IR');

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: MyApp.locale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      title: 'ABD SHOP',
      supportedLocales: const [
        Locale("fa", "IR"),
        Locale("en", "US"),
      ],
      theme: ThemeData(fontFamily: "Yekan", useMaterial3: true),
      home: const SplashPage(),
    );
  }
}


