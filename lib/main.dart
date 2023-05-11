import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:messenger/pages/home/home_page.dart';
import 'package:messenger/pages/login/login_page.dart';
import 'package:messenger/pages/registration/registration_page.dart';
import 'package:messenger/services/navigation_service.dart';
import 'package:messenger/services/db_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messenger',
      navigatorKey: NavigationService.instance.navigatorKey,
      theme: ThemeData(
        brightness: Brightness.dark,
        // primaryColor: const Color.fromRGBO(42, 117, 188, 1),
        // accentColor: const Color.fromRGBO(42, 117, 188, 1),
        // backgroundColor: const Color.fromRGBO(42, 117, 188, 1),
      ),
      initialRoute: "login",
      routes: {
        "home": (BuildContext _context) => const HomePage(),
        "login": (BuildContext _context) => const LoginPage(),
        "register": (BuildContext _context) => const RegistrationPage(),
      },
    );
  }
}
