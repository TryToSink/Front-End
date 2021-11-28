// @dart=2.9
import 'dart:convert';
import 'package:flutter/material.dart';

import 'assinatura.dart';
import 'cenariosclass.dart';

class LoadEnergia extends StatefulWidget {
  LoadEnergia({Key key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<LoadEnergia> createState() => _LoadEnergiaState();
}

class _LoadEnergiaState extends State<LoadEnergia> {
  bool value = false;
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
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 150, 0)),
                  Text('ENERGIA')
                ],
              ),
            ),
            body: Container(
                width: size.width,
                height: size.height,
                color: Color(0xFFDDDDDD),
                child: LayoutBuilder(builder: (_, constraints) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight,
                            color: Color(0xFFDDDDDD),
                            child: Stack(children: [
                              Container(
                                  width: constraints.maxWidth,
                                  height: constraints.maxHeight,
                                  color: Color(0xFFDDDDDD),
                                  child: Column(children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                                    ),
                                    Container(
                                      width: constraints.maxWidth * .90,
                                      height: constraints.maxHeight * .10,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            //maximumSize: size,
                                            fixedSize: size,
                                            backgroundColor: Colors.white,
                                            elevation: 15,
                                            shadowColor: Colors.grey),
                                        child: Text(
                                          'Obter assinatura >',
                                          style: const TextStyle(
                                              fontSize: 30,
                                              color: Colors.black),
                                          softWrap: true,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoadAssinatura()));
                                        },
                                      ),
                                    ),
                                    Container(
                                        width: constraints.maxWidth * .80,
                                        height: constraints.maxHeight * .10,
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child:
                                              Text("Ou compre energia avulsa:"),
                                        )),
                                    Container(
                                      width: constraints.maxWidth * .80,
                                      height: constraints.maxHeight * .10,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            //maximumSize: size,
                                            fixedSize: size,
                                            backgroundColor: Colors.white,
                                            elevation: 15,
                                            shadowColor: Colors.grey),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(children: [
                                              Image.asset('assets/energy.png'),
                                              Text(
                                                'X 1   ',
                                                style: const TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.black),
                                                softWrap: true,
                                              )
                                            ]),
                                            Text(
                                              'R\$ 0,10',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                              softWrap: true,
                                            ),
                                            Checkbox(
                                              value: this.value,
                                              onChanged: (value) {
                                                setState(() {
                                                  this.value = value;
                                                });
                                              },
                                              //Checkbox
                                              activeColor: Colors.green,
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
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 20)),
                                    Container(
                                      width: constraints.maxWidth * .80,
                                      height: constraints.maxHeight * .10,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            //maximumSize: size,
                                            fixedSize: size,
                                            backgroundColor: Colors.white,
                                            elevation: 15,
                                            shadowColor: Colors.grey),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(children: [
                                              Image(
                                                image: NetworkImage(
                                                    'assets/energy.png'),
                                              ),
                                              Text(
                                                'X 5   ',
                                                style: const TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.black),
                                                softWrap: true,
                                              )
                                            ]),
                                            Text(
                                              'R\$ 0,40',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
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
                                              activeColor: Colors.green,
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
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 20)),
                                    Container(
                                      width: constraints.maxWidth * .80,
                                      height: constraints.maxHeight * .10,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            //maximumSize: size,
                                            fixedSize: size,
                                            backgroundColor: Colors.white,
                                            elevation: 15,
                                            shadowColor: Colors.grey),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(children: [
                                              Image(
                                                image: NetworkImage(
                                                    'assets/energy.png'),
                                              ),
                                              Text(
                                                'X 10 ',
                                                style: const TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.black),
                                                softWrap: true,
                                              )
                                            ]),
                                            Text(
                                              'R\$ 0,70',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
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
                                              activeColor: Colors.green,
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
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 50)),
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
                                          'COMPRAR',
                                          style: const TextStyle(
                                              fontSize: 30,
                                              color: Colors.white),
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
                                  ]))
                            ]))
                      ]);
                }))));
  }
}
