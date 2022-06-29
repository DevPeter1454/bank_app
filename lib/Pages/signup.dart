// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers, avoid_print, unused_import

import 'package:bank_app/Model/model.dart';
import 'package:bank_app/services/clippath.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:form_validator/form_validator.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  Color colorA = const Color(0XFFEA251F);
  Color colorB = const Color(0XFF3F3D56);
  GlobalKey<FormState> key = GlobalKey<FormState>();
  late String aPass;
  late List<User> customers = [];
  var balance = 20000;
  bool isVisible = true;
  late bool bodyVisible = false;
  checkData() async {
    SharedPreferences newCustomers = await SharedPreferences.getInstance();
    if (newCustomers.containsKey('customers_key')) {
      // customers = User.decode(newCustomers.getString('customers_key').map((e) => User.fromJson(json.decode(e))).toList())
      customers = User.decode(newCustomers.getString('customers_key') ?? '');
    }
  }

  loadPage() async {
    await Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        bodyVisible = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    checkData();
    loadPage();
  }

  @override
  void dispose() {

    fname.dispose();
    lname.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    super.dispose();

  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor:const Color(0XFFEFEFEF),
      // appBar: AppBar(),
      body: Visibility(
        visible: bodyVisible,
        replacement: Center(
            child: SpinKitFoldingCube(
          color: colorA,
          size: 50.0,
        )),
        child: SingleChildScrollView(
            child: Container(
          height: MediaQuery.of(context).size.height * 1.7,
          child: Column(
            children: [
              ClipPath(
                // borderRadius: BorderRadius.circular(20),
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
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    // height: MediaQuery.of(context).size.height/1.5,

                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Form(
                        key: key,
                        child: Column(children: [
                          const SizedBox(height: 70),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              // autocorrect: true,
                              controller: fname,
                              style: TextStyle(
                                color: colorB,
                              ),
                              decoration: InputDecoration(
                                label: Row(children: [
                                  Icon(Icons.person_add,
                                      color: colorA, size: 15),
                                  const Text(' First Name'),
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
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'This field is required'),
                                MinLengthValidator(3,
                                    errorText: 'Min length is 3'),
                                MaxLengthValidator(20,
                                    errorText: 'Max length is 20'),
                              ]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              // autocorrect: true,
                              style: TextStyle(
                                color: colorB,
                              ),
                              controller: lname,
                              decoration: InputDecoration(
                                label: Row(children: [
                                  Icon(Icons.person_outline_rounded,
                                      color: colorA, size: 15),
                                  const Text(' Last Name'),
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
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'This field is required'),
                                MinLengthValidator(3,
                                    errorText: 'Min length is 3'),
                                MaxLengthValidator(20,
                                    errorText: 'Max length is 20'),
                              ]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              // autocorrect: true,
                              style: TextStyle(
                                color: colorB,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]')),
                              ],
                              controller: phone,
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
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                                // autocorrect: true,
                                style: TextStyle(
                                  color: colorB,
                                ),
                                controller: email,
                                decoration: InputDecoration(
                                  label: Row(children: [
                                    Icon(Icons.mail_outline_rounded,
                                        color: colorA, size: 15),
                                    const Text(' Email Address'),
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
                                validator: MultiValidator([
                                  EmailValidator(
                                      errorText: 'enter a valid email address'),
                                  RequiredValidator(
                                      errorText: 'This field is required'),
                                ])),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              // autocorrect: true,
                              obscureText: isVisible,
                              onChanged: (val) {
                                setState(() {
                                  aPass = val;
                                });
                              },
                              style: TextStyle(
                                color: colorB,
                              ),
                              decoration: InputDecoration(
                                  label: Row(children: [
                                    Icon(Icons.password_outlined,
                                        color: colorA, size: 15),
                                    const Text(' Password'),
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
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isVisible = !isVisible;
                                        });
                                      },
                                      icon: isVisible
                                          ? const Icon(
                                              Icons.visibility_off,
                                              color: Color(0XFF3F3D56),
                                            )
                                          : const Icon(Icons.visibility,
                                              color: Color(0XFFEA251F)))),
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'password is required'),
                                MinLengthValidator(8,
                                    errorText:
                                        'password must be at least 8 digits long'),
                                PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                                    errorText:
                                        'passwords must have at least one special character')
                              ]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                                // autocorrect: true,
                                style: TextStyle(
                                  color: colorB,
                                ),
                                obscureText: true,
                                decoration: InputDecoration(
                                  label: Row(children: [
                                    Icon(Icons.password_outlined,
                                        color: colorA, size: 15),
                                    const Text(' Confirm Password'),
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
                                validator: (val) {
                                  return MatchValidator(
                                          errorText: 'passwords do not match')
                                      .validateMatch(val!, aPass);
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                                child: ElevatedButton(
                              onPressed: () {
                                print('object');
                                if (true) {
                                  // print('isnotempty');
                                  var val = customers
                                      .where((element) =>
                                          element.email == email.text)
                                      .toList();
                                  if (val.isNotEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Email already exists'),
                                            backgroundColor: Color(0XFFEA251F),
                                            duration: Duration(seconds: 2)));
                                  } else if (val.isEmpty) {
                                    print('isempty');
                                    if (key.currentState!.validate()) {
                                      print('valid');
                                      User user = User(
                                        fname: fname.text,
                                        lname: lname.text,
                                        phone: phone.text,
                                        email: email.text,
                                        password: aPass,
                                        balance: balance,
                                        accountNo:
                                            (Random().nextInt(1000000000) * 10)
                                                .toString(),
                                        cards:
                                            '5399${Random().nextInt(1000000000) * 1000}',
                                        transactions: [],
                                        requests: [],
                                      );
                                      customers.add(user);
                                      // print(user.cards);
                                      setData() async {
                                        SharedPreferences newCustomers =
                                            await SharedPreferences
                                                .getInstance();
                                        final encodedData =
                                            User.encode(customers);
                                        await newCustomers.setString(
                                            'customers_key', encodedData);
                                      }

                                      setData();
                                      Navigator.pushNamed(context, '/signin');
                                    }
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: colorA,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text('SIGN UP'),
                            )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Divider(
                            color: colorB,
                            thickness: 1,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Already have an account?',
                                    style: TextStyle(
                                      color: colorB,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacementNamed(
                                          context, '/signin');
                                    },
                                    child: Text(
                                      'Sign In',
                                      style: TextStyle(
                                        color: colorA,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 70),
                        ]),
                      ),
                    ),
                  )),
            ],
          ),
        )),
      ),
      floatingActionButton: Visibility(
        visible: bodyVisible,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0XFFE52F17),
          splashColor: const Color(0XFFF13B29),
          child: const Icon(Icons.chat_bubble_outline),
        ),
      ),
    );
  }
}
