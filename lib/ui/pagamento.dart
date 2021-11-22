import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proj0511/ui/home.dart';

import 'cenariosclass.dart';

class LoadPagamento extends StatefulWidget {
  LoadPagamento({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<LoadPagamento> createState() => _LoadPagamentoState();
}

class _LoadPagamentoState extends State<LoadPagamento> {
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
                child: (Text('PAGAMENTO')),
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
                                              'Credit Card',
                                              style: const TextStyle(
                                                  fontSize: 30,
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
                                              'Samsung Pay',
                                              style: const TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.black),
                                              softWrap: true,
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
                                              'Credit Card',
                                              style: const TextStyle(
                                                  fontSize: 30,
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
                                              'Adicionar Cartão',
                                              style: const TextStyle(
                                                  fontSize: 30,
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
                                          'PAGAR',
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
                                                      HomePage()));
                                        },
                                      ),
                                    )
                                  ]))
                            ]))
                      ]);
                }))));
  }
}
