// import 'package:bank_app/Model/model.dart';
// ignore_for_file: avoid_unnecessary_containers

import 'package:bank_app/Views/history.dart';
import 'package:bank_app/Views/homebody.dart';
import 'package:bank_app/Views/settings.dart';
import 'package:bank_app/services/cards.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final controller = AdvancedDrawerController();
  Color colorA = const Color(0XFFEA251F);
  Color colorB = const Color(0XFF3F3D56);
  bool balanceVisible = false;

  int activeIndex = 0;
  PageController pagercontroller = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    List pages = [
      HomeBody(data: data),
      History(
        data: data,
      ),
      Cards(data: data),
      const Settings()
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/notify', arguments: data);
              },
              icon: Icon(Icons.notifications_active_outlined,
                  color: colorA, size: 20)),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          content: Text(
                              'Are you sure you want to Logout ${data[0].fname}?'),
                          actions: [
                            OutlinedButton(
                                onPressed: () {
                                  Navigator.popUntil(context, ModalRoute.withName('/'));
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(colorA)),
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.white),
                                )),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(colorA)),
                              child: const Text(
                                'No',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ]);
                    });
              },
              icon: Icon(Icons.logout_outlined, color: colorA, size: 20)),
        ],
        elevation: 0.0,
      ),
      drawer: Drawer(
        // backgroundColor: colorB,
        child: SafeArea(
          child: Container(
            child: ListTileTheme(
              textColor: colorA,
              iconColor: colorB,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 128.0,
                    height: 128.0,
                    margin: const EdgeInsets.only(
                      top: 24.0,
                      bottom: 64.0,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                      shape: BoxShape.circle,
                    ),
                    child: const FlutterLogo(size: 50),
                  ),
                  ListTile(
                    onTap: () {
                      pagercontroller
                          .jumpToPage(pages.indexOf(HomeBody(data: data)));
                    },
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                  ),
                  ListTile(
                    onTap: () {
                      // Navigator.pop(context);
                    },
                    leading: const Icon(Icons.account_circle_rounded),
                    title: const Text('Profile'),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.favorite),
                    title: const Text('Favourites'),
                  ),
                  ListTile(
                    onTap: () {
                      pagercontroller.jumpToPage(pages.length - 1);
                    },
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                  ),
                  const Spacer(),
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 12,
                      color: colorB,
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 16.0,
                      ),
                      child: const Text(
                        'Terms of Service | Privacy Policy',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: PageView.builder(
        controller: pagercontroller,
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return pages[index];
        },
        onPageChanged: (index) {
          setState(() {
            activeIndex = index;
          });
        },
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: activeIndex,
        strokeColor: colorA,
        items: [
          CustomNavigationBarItem(
            icon: Icon(Icons.home, color: activeIndex == 0 ? colorA : colorB),
            title: Text('Home',
                style: TextStyle(
                    color: activeIndex == 0 ? colorA : colorB, fontSize: 12)),
          ),
          CustomNavigationBarItem(
            icon:
                Icon(Icons.history, color: activeIndex == 1 ? colorA : colorB),
            title: Text('History',
                style: TextStyle(
                    color: activeIndex == 1 ? colorA : colorB, fontSize: 12)),
          ),
          CustomNavigationBarItem(
            icon: Icon(Icons.credit_card,
                color: activeIndex == 2 ? colorA : colorB),
            title: Text('Card',
                style: TextStyle(
                    color: activeIndex == 2 ? colorA : colorB, fontSize: 12)),
          ),
          CustomNavigationBarItem(
            icon:
                Icon(Icons.settings, color: activeIndex == 3 ? colorA : colorB),
            title: Text('Settings',
                style: TextStyle(
                    color: activeIndex == 3 ? colorA : colorB, fontSize: 12)),
          ),
        ],
        onTap: (index) {
          setState(() {
            activeIndex = index;
            pagercontroller.jumpToPage(index);
          });
        },
      ),
    );
  }
}
