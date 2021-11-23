import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proj0511/ui/home.dart';
import 'package:proj0511/ui/pagamento.dart';

import 'cenariosclass.dart';

class LoadAssinatura extends StatefulWidget {
  LoadAssinatura({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<LoadAssinatura> createState() => _LoadAssinaturaState();
}

class _LoadAssinaturaState extends State<LoadAssinatura> {
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
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
                child: (Text('ASSINATURA')),
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
                            color: Colors.white,
                            child: Stack(children: [
                              Container(
                                  width: constraints.maxWidth,
                                  height: constraints.maxHeight,
                                  color: Colors.white,
                                  child: Column(children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                                    ),
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
                                            Text(
                                              'Standard',
                                              style: const TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.black),
                                              softWrap: true,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 30, 0),
                                            ),
                                            Image(
                                              image: NetworkImage(
                                                  'assets/standard.png'),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 30, 0),
                                            ),
                                            Text(
                                              'RS 2,99',
                                              style: const TextStyle(
                                                  fontSize: 10,
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
                                            Text(
                                              'Gold',
                                              style: const TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.black),
                                              softWrap: true,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 30, 0),
                                            ),
                                            Image(
                                              image: NetworkImage(
                                                  'assets/gold.png'),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 30, 0),
                                            ),
                                            Text(
                                              'RS 6,99',
                                              style: const TextStyle(
                                                  fontSize: 10,
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
                                            Text(
                                              'Diamond',
                                              style: const TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.black),
                                              softWrap: true,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 30, 0),
                                            ),
                                            Image(
                                              image: NetworkImage(
                                                  'assets/diamond.png'),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 30, 0),
                                            ),
                                            Text(
                                              'RS 9,99',
                                              style: const TextStyle(
                                                  fontSize: 10,
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

                                    //  child: Text(
                                    //    'Obter assinatura >',
                                    //    style: const TextStyle(
                                    //        fontSize: 30,
                                    //        color: Colors.black),
                                    //    softWrap: true,
                                    //  ),
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
                                          'ASSINAR',
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
