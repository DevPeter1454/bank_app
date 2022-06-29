// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:bank_app/Model/model.dart';
import 'package:bank_app/services/clippath.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Color colorA = const Color(0XFFEA251F);
  Color colorB = const Color(0XFF3F3D56);
  GlobalKey<FormState> key = GlobalKey<FormState>();
  late List<User> customers = [];
  bool isVisible = true;
  late bool bodyVisible = true;
  late String aPass;
  retrieveData() async {
    SharedPreferences newCustomers = await SharedPreferences.getInstance();
    if (newCustomers.containsKey('customers_key')) {
      customers =
          User.decode(newCustomers.getString('customers_key') ?? '').toList();
    }
  }

  loadPage() async {
    Future.delayed(const Duration(seconds: 2), () {
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
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Visibility(
      visible: bodyVisible,
      replacement: SpinKitFadingCircle(color: colorA, size: 50.0),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
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
            Expanded(
              flex: 2,
              child: Container(
                // height: MediaQuery.of(context).size.height/1.5,
                // color: const Color(0XFFEFEFEF),
                child: Padding(
                  padding: const EdgeInsets.all(20),
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
                        child: Center(
                            child: ElevatedButton(
                          onPressed: () {
                            if (key.currentState!.validate()) {
                              // print('here');
                              if (customers.isNotEmpty) {
                                var res = customers
                                    .where((e) =>
                                        e.email == email.text &&
                                        e.password == aPass)
                                    .toList();
                                if (res.isNotEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Welcome ${res[0].fname}'),
                                          backgroundColor:
                                              const Color(0XFFEA251F),
                                          duration:
                                              const Duration(seconds: 2)));
                                  Navigator.pushReplacementNamed(
                                      context, '/userpage',
                                      arguments: res);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Incorrect details'),
                                          backgroundColor: Color(0XFFEA251F),
                                          duration: Duration(seconds: 2)));
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
                          child: const Text('SIGN IN'),
                        )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Divider(
                        color: colorB,
                        thickness: 1,
                      ),
                      Row(children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Don\'t  have an account yet?',
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
                                    context, '/signup');
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: colorA,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ])
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
