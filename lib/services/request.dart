// ignore_for_file: sized_box_for_whitespace

import 'package:bank_app/Model/model.dart';
import 'package:bank_app/services/clippath.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
class Requests extends StatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  Color colorA = const Color(0XFFEA251F);
  Color colorB = const Color(0XFF3F3D56);
  bool beneficiaryVisible = false;
  List<User> customers = [];
  bool bodyVisible = false;
  bool requestValid = false;
  String userDropdown = 'Select';
  String customerChosen = 'Select';
  List namesCustomers = [
    'Select',
  ];
  String receiver = '';
  TextEditingController amount = TextEditingController();
  TextEditingController password = TextEditingController();
  late dynamic data;
  retrieveData() async {
    SharedPreferences newCustomers = await SharedPreferences.getInstance();
    if (newCustomers.containsKey('customers_key')) {
      customers =
          User.decode(newCustomers.getString('customers_key') ?? '').toList();
    }
    loadNames() {
      for (int i = 0; i < customers.length; i++) {
        if (customers[i].accountNo == data[0].accountNo) {
          continue;
        } else {
          namesCustomers.add(customers[i].accountNo);
          // beneficiary.add('${customers[i].fname} ${customers[i].lname}');
        }
      }
    }

    loadNames();
  }

  loadPage() async {
    await Future.delayed(const Duration(seconds: 3), () {
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
    retrieveData();
    loadPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorA,
          title: const Text('Request'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Visibility(
          visible: bodyVisible,
          replacement: SpinKitFadingCube(color: colorA, size: 50.0),
          child: SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height * 4,
                child: ListView(children: [
                  ClipPath(
                      clipper: ClipPathClass(),
                      child: Container(
                        // color: colorA,
                        height: 200,
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
                        ),
                      )),
                  const SizedBox(height: 30),
                  Container(
                    height: MediaQuery.of(context).size.height * 4,
                    width: MediaQuery.of(context).size.width * 1.5,
                    child: Card(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        Row(
                          children: [
                            const SizedBox(width: 10),
                            Text('From:',
                                style: TextStyle(
                                    color: colorB,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200)),
                            const SizedBox(width: 10),
                            DropdownButton(
                                value: userDropdown,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: [
                                  const DropdownMenuItem(
                                      value: 'Select', child: Text('Select')),
                                  DropdownMenuItem(
                                      value: '${data[0].accountNo}',
                                      child: Text(
                                          '${data[0].accountNo}')),
                                ],
                                onChanged: (String? value) {
                                  setState(() {
                                    userDropdown = value!;
                                  });
                                }),
                          ],
                        ),
                        Row(children: [
                          const SizedBox(width: 3),
                          Text('Recipient: ',
                              style: TextStyle(
                                  color: colorB,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w200)),
                          // const SizedBox(width: 10),
                          DropdownButton(
                              value: customerChosen,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: namesCustomers.map((name) {
                                return DropdownMenuItem(
                                    value: name.toString(), child: Text(name));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  customerChosen = value.toString();
                                  for (var i = 0; i < customers.length; i++) {
                                    if (customers[i].accountNo == value) {
                                     receiver  =
                                          '${customers[i].fname} ${customers[i].lname}';
                                    }
                                  }

                                  beneficiaryVisible = true;
                                });
                              })
                        ]),
                        const SizedBox(height: 10),
                        Visibility(
                          visible: beneficiaryVisible,
                          replacement: SpinKitWave(color: colorA, size: 10.0),
                          child: Text('Recipient: $receiver',
                              style: TextStyle(
                                  color: colorB,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w200)),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                                // autocorrect: true,
                                style: TextStyle(
                                  color: colorB,
                                ),
                                controller: amount,
                                decoration: InputDecoration(
                                  label: Row(children: [
                                    Icon(Icons.attach_money_outlined,
                                        color: colorA, size: 15),
                                    const Text(' Amount'),
                                  ]),
                                  labelStyle: const TextStyle(
                                    color: Color(0XFFED4D23),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: colorA),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: colorB),
                                  ),
                                  filled: true,
                                ))),
                        Center(
                            child: IconButton(
                          onPressed: () {
                            if (amount.text != "") {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: TextField(
                                        controller: password,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          hintText: 'Enter your password',
                                          filled: true,
                                          labelStyle: const TextStyle(
                                            color: Color(0XFFED4D23),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: colorA),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: colorB),
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            if (data[0].password ==
                                                password.text) {
                                              Navigator.pop(
                                                context,
                                              );
                                              transfer();
                                              password.text = '';
                                              amount.text = '';
                                              receiver = '';
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: const Text(
                                                    'Incorrect password'),
                                                duration:
                                                    const Duration(seconds: 4),
                                                backgroundColor: colorA,
                                              ));
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: colorA),
                                          child: const Text('Confirm'),
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                context,
                                              );
                                            },
                                            child: const Text('Cancel')),
                                      ],
                                    );
                                  });
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text('Enter an amount'),
                                backgroundColor: colorA,
                              ));
                            }
                          },
                          icon: Icon(Icons.remove_circle_outline,
                              color: colorA, size: 30),
                        )),
                      ]),
                    )),
                  )
                ])),
          ),
        ));
  }

  transfer() {
    getSender() {
      for (var i = 0; i < customers.length; i++) {
        if (customers[i].accountNo == data[0].accountNo) {
          if (true) {
            getReceiver() {
              for (var i = 0; i < customers.length; i++) {
                if (customers[i].accountNo == customerChosen) {
                  setState(() {
                    // customers[i].balance += int.parse(amount.text);
                    customers[i].requests.add(Request(
                          type: 'RRequest',
                          amount: int.parse(amount.text),
                          date: DateFormat.yMd().add_jm().format(DateTime.parse(DateTime.now().toString())),
                          sender: '${data[0].fname} ${data[0].lname}',
                        ));
                  });
                }
              }
            }

            setState(() {
              data[0].requests.add(Request(
                    type: 'SRequest',
                    amount: int.parse(amount.text),
                    date: DateFormat.yMd().add_jm().format(DateTime.parse(DateTime.now().toString())),
                    receiver: receiver,
                  ));
              customers[i].requests = data[0].requests;
              getReceiver();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('Request Successful'),
                backgroundColor: colorA,
              ));
            });
          } 
        }
      }
    }

    getSender();
    // getReceiver();
    setData() async {
      SharedPreferences newCustomers = await SharedPreferences.getInstance();
      final encodedData = User.encode(customers);
      await newCustomers.setString('customers_key', encodedData);
    }

    setData();
    setState(() {
      userDropdown = 'Select';
      customerChosen = 'Select';
    });
    userDropdown = 'Select';
    customerChosen = 'Select';
  }
}
