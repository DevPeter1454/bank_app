// ignore_for_file: unused_local_variable

import 'package:bank_app/Pages/onboard.dart';
import 'package:bank_app/Pages/signin.dart';
import 'package:bank_app/Pages/signup.dart';
import 'package:bank_app/Views/home.dart';
import 'package:bank_app/services/airtime.dart';
import 'package:bank_app/services/notify.dart';
import 'package:bank_app/services/request.dart';
import 'package:bank_app/services/transfer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:shared_preferences/shared_preferences.dart';
 main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
        
      ),
      themeMode: ThemeMode.dark,
      initialRoute: '/',
      routes: {
        '/': (context) => const OnBoard(),
        '/signup': (context) => const SignUp(),
        '/signin': (context) => const SignIn(),
        '/userpage': (context) => const Home(),
        '/transfers': (context) => const Transfer(),
        '/airtime': (context) => const Airtime(),
        '/notify': (context) => const Notify(),
        '/request': (context) => const Requests(),

      },
      debugShowCheckedModeBanner: false,
    );
  }
}
