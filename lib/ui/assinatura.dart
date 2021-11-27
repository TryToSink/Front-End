// @dart=2.9
// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proj0511/ui/home.dart';
import 'package:proj0511/ui/pagamento.dart';

import 'cenariosclass.dart';

class LoadAssinatura extends StatefulWidget {
  LoadAssinatura({Key key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<LoadAssinatura> createState() => _LoadAssinaturaState();
}

class _LoadAssinaturaState extends State<LoadAssinatura> {
  bool value1 = false;
  bool value2 = false;
  bool value3 = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
//        brightness: Brightness.dark,
          primaryColor: Color(0xFF293241),
        ),
        home: Scaffold(
            backgroundColor: Color(0xFFDDDDDD),
            appBar: AppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              backgroundColor: Color(0xFF293241),
              toolbarHeight: 100,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back)),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 130, 0)),
                  Text('ASSINATURA')
                ],
              ),
            ),
            body: Container(
                width: size.width,
                height: size.height,
                color: Colors.white,
                child: LayoutBuilder(builder: (_, constraints) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight,
                            color: Color(0xFFDDDDDD),
                            child: Stack(children: [
                              Column(
                                children: [
                                  Container(
                                      width: constraints.maxWidth,
                                      height: constraints.maxHeight * .70,
                                      color: Color(0xFFDDDDDD),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: constraints.maxWidth * .25,
                                              height:
                                                  constraints.maxHeight * .60,
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                    //maximumSize: size,
                                                    fixedSize: size,
                                                    backgroundColor:
                                                        Colors.white,
                                                    elevation: 100,
                                                    shadowColor: Colors.black),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'STANDARD',
                                                      style: const TextStyle(
                                                          fontSize: 21,
                                                          color: Colors.black),
                                                      softWrap: true,
                                                    ),
                                                    Image(
                                                        image: NetworkImage(
                                                            'assets/standard.png'),
                                                        width: constraints
                                                                .maxWidth *
                                                            .10,
                                                        height: constraints
                                                                .maxHeight *
                                                            .30),
                                                    Text(
                                                      'Energia / 4 horas',
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.black),
                                                      softWrap: true,
                                                    ),
                                                    Text(
                                                      'R\$ 2,99',
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black),
                                                      softWrap: true,
                                                    ),
                                                    Checkbox(
                                                      value: this.value1,
                                                      onChanged: (value1) {
                                                        setState(() {
                                                          this.value1 = value1;
                                                        });
                                                      },
                                                      //Checkbox
                                                      activeColor: Colors.black,
                                                      checkColor: Colors.white,
                                                      tristate: false,
                                                    ),
                                                  ],
                                                ),
                                                //  child: Text(
                                                //    'Obter assinatura >',
                                                //    style: const TextStyle(
                                                //        fontSize: 30,
                                                //        color: Colors.black),
                                                //    softWrap: true,
                                                //  ),
                                                onPressed: () {},
                                              ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, 30, 0)),
                                            Container(
                                              width: constraints.maxWidth * .25,
                                              height:
                                                  constraints.maxHeight * .60,
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                    //maximumSize: size,
                                                    fixedSize: size,
                                                    backgroundColor:
                                                        Colors.white,
                                                    elevation: 100,
                                                    shadowColor:
                                                        Colors.yellow[700]),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'GOLD',
                                                      style: const TextStyle(
                                                          fontSize: 21,
                                                          color: Color(
                                                              0xFFF9A825)),
                                                      softWrap: true,
                                                    ),
                                                    Image(
                                                        image: NetworkImage(
                                                            'assets/gold.png'),
                                                        width: constraints
                                                                .maxWidth *
                                                            .15,
                                                        height: constraints
                                                                .maxHeight *
                                                            .30),
                                                    Text(
                                                      'Energia / 2 horas',
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          color: Color(
                                                              0xFFF9A825)),
                                                      softWrap: true,
                                                    ),
                                                    Text(
                                                      'R\$ 6,99',
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Color(
                                                              0xFFF9A825)),
                                                      softWrap: true,
                                                    ),
                                                    Checkbox(
                                                      value: this.value2,
                                                      onChanged: (value2) {
                                                        setState(() {
                                                          this.value2 = value2;
                                                        });
                                                      },
                                                      //Checkbox
                                                      activeColor:
                                                          Colors.yellow,
                                                      checkColor: Colors.white,
                                                      tristate: false,
                                                    ),
                                                  ],
                                                ),
                                                //  child: Text(
                                                //    'Obter assinatura >',
                                                //    style: const TextStyle(
                                                //        fontSize: 30,
                                                //        color: Colors.black),
                                                //    softWrap: true,
                                                //  ),
                                                onPressed: () {},
                                              ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, 30, 0)),
                                            Container(
                                              width: constraints.maxWidth * .25,
                                              height:
                                                  constraints.maxHeight * .60,
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                    //maximumSize: size,
                                                    fixedSize: size,
                                                    backgroundColor:
                                                        Colors.white,
                                                    elevation: 100,
                                                    shadowColor:
                                                        Colors.blue[800]),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'DIAMOND',
                                                      style: const TextStyle(
                                                        fontSize: 21,
                                                        color: Colors.blue,
                                                      ),
                                                      softWrap: true,
                                                    ),
                                                    Image(
                                                        image: NetworkImage(
                                                            'assets/diamond.png'),
                                                        width: constraints
                                                                .maxWidth *
                                                            .15,
                                                        height: constraints
                                                                .maxHeight *
                                                            .30),
                                                    Text(
                                                      'Energia ilimitada',
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.blue),
                                                      softWrap: true,
                                                    ),
                                                    Text(
                                                      'R\$ 9,99',
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.blue),
                                                      softWrap: true,
                                                    ),
                                                    Checkbox(
                                                      value: this.value3,
                                                      onChanged: (value3) {
                                                        setState(() {
                                                          this.value3 = value3;
                                                        });
                                                      },
                                                      //Checkbox
                                                      activeColor: Colors.blue,
                                                      checkColor: Colors.white,
                                                      tristate: false,
                                                    ),
                                                  ],
                                                ),
                                                //  child: Text(
                                                //    'Obter assinatura >',
                                                //    style: const TextStyle(
                                                //        fontSize: 30,
                                                //        color: Colors.black),
                                                //    softWrap: true,
                                                //  ),
                                                onPressed: () {},
                                              ),
                                            ),

                                            //  child: Text(
                                            //    'Obter assinatura >',
                                            //    style: const TextStyle(
                                            //        fontSize: 30,
                                            //        color: Colors.black),
                                            //    softWrap: true,
                                            //  ),
                                          ])),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  ),
                                  Container(
                                    width: constraints.maxWidth * .70,
                                    height: constraints.maxHeight * .10,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          //maximumSize: size,
                                          fixedSize: size,
                                          backgroundColor: Color(0xFF3D5AB0),
                                          elevation: 15,
                                          shadowColor: Colors.grey),
                                      child: Text(
                                        'ASSINAR',
                                        style: const TextStyle(
                                            fontSize: 30, color: Colors.white),
                                        softWrap: true,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoadPagamento()));
                                      },
                                    ),
                                  )
                                ],
                              )
                            ])),
                      ]);
                }))));
  }
}
