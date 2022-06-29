import 'package:bank_app/Model/model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key, required this.data})
      : super(
          key: key,
        );
  final dynamic data;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  Color colorA = const Color(0XFFEA251F);
  Color colorB = const Color(0XFF3F3D56);
  bool balanceVisible = false;
  List<User> customers = [];
  retrieveData() async {
    SharedPreferences newCustomers = await SharedPreferences.getInstance();
    if (newCustomers.containsKey('customers_key')) {
      customers =
          User.decode(newCustomers.getString('customers_key') ?? '').toList();
    }
  }

  @override
  void initState() {
    super.initState();
    retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    // dynamic data = ModalRoute.of(context)!.settings.arguments;
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          const SizedBox(height: 20),
          // Text(data[0].fname),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('Welcome, ${widget.data[0].fname}',
                style: TextStyle(
                    color: colorB, fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0XFFEC4420),
                      Color(0XFFED4D23),
                      Color(0XFFEA251F),
                      // const Color(0XFF3F3D56),
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 20, 0, 0),
                    child: Text('SAVINGS ACCOUNT',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w200)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 10, 0, 0),
                    child: Text('${widget.data[0].accountNo}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                            letterSpacing: 2)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Visibility(
                        visible: balanceVisible,
                        replacement: const Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 30, 0, 0),
                          child: Text('******',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w200,
                              )),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 30, 0, 0),
                          child: Text('\$ ${widget.data[0].balance}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w200,
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 30, 0, 0),
                        child: IconButton(
                            iconSize: 20,
                            onPressed: () {
                              setState(() {
                                balanceVisible = !balanceVisible;
                              });
                            },
                            icon: Icon(
                              Icons.remove_red_eye_outlined,
                              color: colorB,
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/transfers',
                        arguments: widget.data);
                  },
                  child: SizedBox(
                      height: 80,
                      width: 150,
                      child: Card(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 5, 0, 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.attach_money, color: colorA, size: 30),
                            // SizedBox(height: 5,),
                            Text(
                              'Transfer',
                              style: TextStyle(color: colorA, fontSize: 15),
                            )
                          ],
                        ),
                      ))),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/airtime', arguments: widget.data);
                    // pagercontroller.
                  },
                  child: SizedBox(
                      height: 80,
                      width: 150,
                      child: Card(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 5, 0, 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.mobile_friendly_outlined,
                                color: colorA, size: 30),
                            // SizedBox(height: 5,),
                            Text(
                              'Airtime Recharge',
                              style: TextStyle(color: colorA, fontSize: 15),
                            )
                          ],
                        ),
                      ))),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    height: 80,
                    width: 150,
                    child: Card(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 5, 0, 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.payments_outlined,
                              color: colorA, size: 30),
                          // SizedBox(height: 5,),
                          Text(
                            'Bills Payment',
                            style: TextStyle(color: colorA, fontSize: 15),
                          )
                        ],
                      ),
                    ))),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/request',
                        arguments: widget.data);
                  },
                  child: SizedBox(
                      height: 80,
                      width: 150,
                      child: Card(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 5, 0, 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.money_rounded, color: colorA, size: 30),
                            // SizedBox(height: 5,),
                            Text(
                              'Request',
                              style: TextStyle(color: colorA, fontSize: 15),
                            )
                          ],
                        ),
                      ))),
                )
              ],
            ),
          ),
        ]));
  }
}
