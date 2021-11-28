import 'dart:convert';
import 'package:flutter/material.dart';
import 'assinatura.dart';
import 'cenariosclass.dart';
import 'idioma.dart';
import 'pagamento.dart';

class LoadConfig extends StatefulWidget {
  LoadConfig({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<LoadConfig> createState() => _LoadConfigState();
}

class _LoadConfigState extends State<LoadConfig> {
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
            backgroundColor: Color(0xFFDDDDDD),
            appBar: AppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              backgroundColor: Color(0xFF293241),
              toolbarHeight: 100,
              centerTitle: true,
              title: const Text('CONFIGURAÇÕES'),
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back)),
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
                            color: Colors.white,
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
                                              image: AssetImage(
                                                  'assets/assinatur.png'),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 30, 0),
                                            ),
                                            Text(
                                              'Assinatura',
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black),
                                              softWrap: true,
                                            ),
                                          ],
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
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                                              image: AssetImage(
                                                  'assets/pagamento.png'),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 30, 0),
                                            ),
                                            Text(
                                              'Pagamento',
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black),
                                              softWrap: true,
                                            ),
                                          ],
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoadPagamento()));
                                        },
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
                                              image: AssetImage(
                                                  'assets/historica.png'),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 30, 0),
                                            ),
                                            Text(
                                              'Histórico de Pagamento',
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black),
                                              softWrap: true,
                                            ),
                                          ],
                                        ),
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
                                              image: AssetImage(
                                                  'assets/aplicativo.png'),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 30, 0),
                                            ),
                                            Text(
                                              'Aplicativo',
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black),
                                              softWrap: true,
                                            ),
                                          ],
                                        ),
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
                                              image: AssetImage(
                                                  'assets/idioma.png'),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 30, 0),
                                            ),
                                            Text(
                                              'Idioma',
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black),
                                              softWrap: true,
                                            ),
                                          ],
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PageIdioma()));
                                        },
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
                                              image: AssetImage(
                                                  'assets/excluir.png'),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 30, 0),
                                            ),
                                            Text(
                                              'Excluir Conta',
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black),
                                              softWrap: true,
                                            ),
                                          ],
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ]))
                            ]))
                      ]);
                }))));
  }
}
