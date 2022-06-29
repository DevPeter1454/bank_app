// import 'package:bank_app/Model/customers.dart';
import 'package:bank_app/Model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_validator/form_validator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Airtime extends StatefulWidget {
  const Airtime({Key? key}) : super(key: key);

  @override
  State<Airtime> createState() => _AirtimeState();
}

class _AirtimeState extends State<Airtime> {
  Color colorA = const Color(0XFFEA251F);
  Color colorB = const Color(0XFF3F3D56);
  String chosenOperator = '';
  List images = [
    'https://pngroyale.com/wp-content/uploads/2021/08/pngroyale.com-MTN-Logo-300x300.png',
    'https://upload.wikimedia.org/wikipedia/commons/8/86/Glo_button.png?20160217191127',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Airtel_Africa_logo.svg/640px-Airtel_Africa_logo.svg.png',
    'https://pngroyale.com/wp-content/uploads/2021/08/pngroyale.com-9mobile-Logo-768x1334.png'
  ];
  List operators = [
    'MTN',
    'GLO',
    'AIRTEL',
    '9MOBILE',
  ];
  TextEditingController phoneNo = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> key = GlobalKey<FormState>();
  List<User> customers = [];
  bool isLoading = false;
  late dynamic data;
  retrieveData() async {
    SharedPreferences newCustomers = await SharedPreferences.getInstance();
    if (newCustomers.containsKey('customers_key')) {
      customers =
          User.decode(newCustomers.getString('customers_key') ?? '').toList();
    }
  }

  loadPage() async {
    await Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          isLoading = true;
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
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorA,
          title: const Text('Airtime Recharge'),
          centerTitle: true,
        ),
        body: Visibility(
          visible: isLoading,
          replacement: SpinKitFadingCube(color: colorA, size: 50.0),
          child: ListView(shrinkWrap: true, children: [
            const SizedBox(height: 20),
            // ignore: sized_box_for_whitespace
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width / 2,
              child: GridView.builder(
                  itemCount: images.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.8),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          chosenOperator = '${operators[index]}';
                        });
                      },
                      child: SizedBox(
                          height: 100,
                          width: 70,
                          child: Card(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              '${images[index]}',
                              height: 70,
                            ),
                          ))),
                    );
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                chosenOperator,
                style: TextStyle(
                    color: colorA, fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            Center(
                child: Form(
                    key: key,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          // autocorrect: true,
                          style: TextStyle(
                            color: colorB,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                          controller: phoneNo,
                          decoration: InputDecoration(
                            label: Row(children: [
                              Icon(Icons.contact_phone_outlined,
                                  color: colorA, size: 15),
                              const Text(' Phone Number'),
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
                          ),
                          validator: ValidationBuilder()
                              .phone('This field is required')
                              .minLength(10)
                              .maxLength(13)
                              .build(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          // autocorrect: true,
                          style: TextStyle(
                            color: colorB,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                          controller: amount,
                          decoration: InputDecoration(
                            label: Row(children: [
                              Icon(Icons.contact_phone_outlined,
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
                          ),
                        ),
                      ),
                    ]))),
            Center(
                child: DefaultTextStyle(
              style: const TextStyle(color: Colors.white, fontSize: 15),
              child: ElevatedButton(
                onPressed: () {
                  if(key.currentState!.validate()){
                          if (amount.text != '' && chosenOperator != "") {
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
                                  borderSide: BorderSide(color: colorA),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: colorB),
                                ),
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                 
                                    if (data[0].password == password.text) {
                                     Navigator.pop(
                                      context,
                                    );
                                    getAirtime();
                                    password.text = '';
                                    amount.text = '';
                                    phoneNo.text = '';
                                   
                                  }else {
                                   ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: const Text('Incorrect password'),
                                      duration: const Duration(seconds: 4),
                                      backgroundColor: colorA,
                                    ));
                                  }
                                },
                                style:
                                    ElevatedButton.styleFrom(primary: colorA),
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
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text('Enter an amount and operator'),
                      backgroundColor: colorA,
                    ));
                  }
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: colorA,
                ),
                child: const Text('Confirm'),
              ),
            ))
          ]),
        ));
  }

  getAirtime() {
      for (var i = 0; i < customers.length; i++) {
        if (customers[i].accountNo == data[0].accountNo) {
          if (data[0].balance > int.parse(amount.text)) {
            setState(() {
              data[0].balance -= int.parse(amount.text);
              customers[i].balance = data[0].balance;
              data[0].transactions.add(Transaction(
                  type: 'Airtime',
                  amount: int.parse(amount.text),
                  date: DateFormat.yMd().add_jm().format(DateTime.parse(DateTime.now().toString()))));
              customers[i].transactions = data[0].transactions;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    'Successful $chosenOperator Airtime recharge of ${amount.text} for ${phoneNo.text}'),
                backgroundColor: colorA,
              ));
              setData() async {
                SharedPreferences newCustomers =
                    await SharedPreferences.getInstance();
                final encodedData = User.encode(customers);
                await newCustomers.setString('customers_key', encodedData);
              }

              setData();
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('Insufficient Balance'),
              backgroundColor: colorA,
            ));
          }
        }
      }
    }
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: const Text('Invalid Phone Number'),
    //     backgroundColor: colorA,
    //   ));
    // }
}
