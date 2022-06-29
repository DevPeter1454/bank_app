// ignore_for_file: avoid_unnecessary_containers
import 'package:bank_app/Views/body.dart';
// import 'package:bank_app/Views/history.dart';
// import 'package:bank_app/Views/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color colorA = const Color(0XFFEA251F);
  Color colorB = const Color(0XFF3F3D56);
  bool bodyVisible = false;
  loadPage() async {
    await Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          bodyVisible = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadPage();
  }

  final controller = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    // dynamic data = ModalRoute.of(context)!.settings.arguments;
    return Visibility(
        visible: bodyVisible,
        replacement:
            Center(child: SpinKitFadingCube(color: colorA, size: 50.0)),
          
          child: const Body(),
        );
  }
}
