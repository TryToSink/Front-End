// @dart=2.9
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proj0511/ui/home.dart';

import 'cenariosclass.dart';

class LoadPagamento extends StatefulWidget {
  LoadPagamento({Key key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<LoadPagamento> createState() => _LoadPagamentoState();
}

class _LoadPagamentoState extends State<LoadPagamento> {
  bool value1 = false;
  bool value2 = false;
  bool value3 = false;
  bool value4 = false;
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
                Text('PAGAMENTO')
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
                                    width: constraints.maxWidth * .80,
                                    height: constraints.maxHeight * .12,
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
                                          Image(
                                            image:
                                                NetworkImage('assets/visa.png'),
                                            height: constraints.maxHeight * .40,
                                            width: constraints.maxWidth * .13,
                                          ),
                                          Text(
                                            'Credit Card',
                                            style: const TextStyle(
                                                fontSize: 30,
                                                color: Colors.black),
                                            softWrap: true,
                                          ),
                                          Checkbox(
                                            value: this.value1,
                                            onChanged: (value1) {
                                              setState(() {
                                                this.value1 = value1;
                                              });
                                            }, //Checkbox
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
                                          EdgeInsets.fromLTRB(0, 0, 0, 30)),
                                  Container(
                                    width: constraints.maxWidth * .80,
                                    height: constraints.maxHeight * .12,
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
                                          Image(
                                            image: NetworkImage(
                                                'assets/sums-pay.png'),
                                          ),
                                          Text(
                                            'Samsung Pay',
                                            style: const TextStyle(
                                                fontSize: 30,
                                                color: Colors.black),
                                            softWrap: true,
                                          ),
                                          Checkbox(
                                            value: this.value2,
                                            onChanged: (value2) {
                                              setState(() {
                                                this.value2 = value2;
                                              });
                                            }, //Checkbox
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
                                          EdgeInsets.fromLTRB(0, 0, 0, 30)),
                                  Container(
                                    width: constraints.maxWidth * .80,
                                    height: constraints.maxHeight * .12,
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
                                          Image(
                                            image:
                                                NetworkImage('assets/pix.jpg'),
                                          ),
                                          Text(
                                            'PIX',
                                            style: const TextStyle(
                                                fontSize: 30,
                                                color: Colors.black),
                                            softWrap: true,
                                          ),
                                          Checkbox(
                                            value: this.value3,
                                            onChanged: (value3) {
                                              setState(() {
                                                this.value3 = value3;
                                              });
                                            }, //Checkbox
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
                                          EdgeInsets.fromLTRB(0, 0, 0, 30)),
                                  Container(
                                    width: constraints.maxWidth * .80,
                                    height: constraints.maxHeight * .12,
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
                                        //crossAxisAlignment:
                                        //    CrossAxisAlignment.center,
                                        children: [
                                          Image(
                                            image:
                                                NetworkImage('assets/plus.png'),
                                          ),
                                          Text(
                                            'Adicionar Cartão',
                                            style: const TextStyle(
                                                fontSize: 30,
                                                color: Colors.black),
                                            softWrap: true,
                                          ),
                                          Checkbox(
                                            value: this.value4,
                                            onChanged: (value4) {
                                              setState(() {
                                                this.value4 = value4;
                                              });
                                            }, //Checkbox
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
                                          EdgeInsets.fromLTRB(0, 0, 0, 120)),
                                  Container(
                                    width: constraints.maxWidth * .70,
                                    height: constraints.maxHeight * .12,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          //maximumSize: size,
                                          fixedSize: size,
                                          backgroundColor: Color(0xFF3D5AB0),
                                          elevation: 15,
                                          shadowColor: Colors.grey),
                                      child: Text(
                                        'PAGAR',
                                        style: const TextStyle(
                                            fontSize: 30, color: Colors.white),
                                        softWrap: true,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage(idUser: '')));
                                      },
                                    ),
                                  )
                                ]))
                          ]))
                    ]);
              })),
        ));
  }
}
