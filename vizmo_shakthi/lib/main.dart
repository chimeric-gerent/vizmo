import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:vizmo_shakthi/constants/constants.dart';
import 'package:vizmo_shakthi/providers/employee_list_provider.dart';
import 'package:vizmo_shakthi/providers/screen_change.dart';
import 'package:vizmo_shakthi/screens/home_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

void main() {
  // Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PageChange()),
        ChangeNotifierProvider(create: (_) => EmployeesProvider()),
      ], // ← create/init your state model
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vizmo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.baseColor,
        body: AnimatedSplashScreen(
          backgroundColor: Constants.baseColor,
          splash: const Text(
            "Vizmo",
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          nextScreen: const HomePage(),
          splashTransition: SplashTransition.slideTransition,
          pageTransitionType: PageTransitionType.topToBottom,
        ),
      ),
    );
  }
}
