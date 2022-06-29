// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class Cards extends StatefulWidget {
  const Cards({Key? key, required this.data}) : super(key: key);
  final dynamic data;


  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  Color colorA = const Color(0XFFEA251F);
  Color colorB = const Color(0XFF3F3D56);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 20),
                  // Container(height: 40, width: 40, color: Colors.white),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 40, width: 80,
                      child: Image.network('https://www.freepnglogos.com/uploads/mastercard-png/mastercard-logo-png-transparent-svg-vector-bie-supply-1.png', height: 40, width: 80,)),
                  ),
                  
                  // const SizedBox(height:20),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('${widget.data[0].cards}', style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w400, letterSpacing: 3,
                        color: Colors.white,

                      ))),
                  ),
                   Center(
                     child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('${widget.data[0].fname} ${widget.data[0].lname} ', style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w400, letterSpacing: 3,
                        color: Colors.white,

                      ),)),
                   ),
                  
                  
                ]
              )
              ),
            )
          ],
        ));
  }
}
