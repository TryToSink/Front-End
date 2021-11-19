// @dart=2.9
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proj0511/ui/assinatura.dart';
import 'package:proj0511/ui/pagamento.dart';

import 'cenariosclass.dart';

class LoadEnergia extends StatefulWidget {
  LoadEnergia({Key key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<LoadEnergia> createState() => _LoadEnergiaState();
}

class _LoadEnergiaState extends State<LoadEnergia> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
//        brightness: Brightness.dark,
          primaryColor: Colors.blueGrey[900],
        ),
        home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              backgroundColor: Colors.blueGrey[900],
              actionsIconTheme:
                  const IconThemeData(size: 30.0, color: Colors.white),
              title: const Center(
                child: (Text('ENERGIA')),
              ),
            ),
            body: Container(
                width: size.width,
                height: size.height,
                color: Colors.grey[350],
                child: LayoutBuilder(builder: (_, constraints) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight,
                            color: Colors.grey[350],
                            child: Stack(children: [
                              Container(
                                  width: constraints.maxWidth,
                                  height: constraints.maxHeight,
                                  color: Colors.grey[350],
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
                                          children: [
                                            Image(
                                              image: NetworkImage(
                                                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                                            ),
                                            Text(
                                              'X 1   ',
                                              style: const TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.black),
                                              softWrap: true,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 30, 0),
                                            ),
                                            Text(
                                              'RS 0,10',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                              softWrap: true,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 30, 0),
                                            ),
                                            Icon(
                                              Icons.circle,
                                              color: Color(0xff3D5A80),
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
                                            EdgeInsets.fromLTRB(0, 0, 0, 10)),
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
                                          children: [
                                            Image(
                                              image: NetworkImage(
                                                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                                            ),
                                            Text(
                                              'X 5   ',
                                              style: const TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.black),
                                              softWrap: true,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 30, 0),
                                            ),
                                            Text(
                                              'RS 0,40',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                              softWrap: true,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 30, 0),
                                            ),
                                            Icon(
                                              Icons.circle,
                                              color: Color(0xff3D5A80),
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
                                            EdgeInsets.fromLTRB(0, 0, 0, 10)),
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
                                          children: [
                                            Image(
                                              image: NetworkImage(
                                                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                                            ),
                                            Text(
                                              'X 10 ',
                                              style: const TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.black),
                                              softWrap: true,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 30, 0),
                                            ),
                                            Text(
                                              'RS 0,70',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                              softWrap: true,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 30, 0),
                                            ),
                                            Icon(
                                              Icons.circle,
                                              color: Colors.blue,
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
