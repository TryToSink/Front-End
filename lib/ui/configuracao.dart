import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proj0511/ui/assinatura.dart';
import 'package:proj0511/ui/home.dart';
import 'package:proj0511/ui/pagamento.dart';
import 'cenariosclass.dart';

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
                child: (Text('CONFIGURAÇÕES')),
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
                                              image: NetworkImage(
                                                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
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
                                              image: NetworkImage(
                                                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
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
                                              image: NetworkImage(
                                                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
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
                                              image: NetworkImage(
                                                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
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
