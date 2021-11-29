// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../rotas.dart';
import 'cenarios.dart';
import 'configuracao.dart';
import 'position_page.dart';
import 'energia.dart';
import 'profile_page.dart';
import 'socket_connect.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  String idUser;

  HomePage({Key? key, required this.idUser}) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState(idUser: idUser);
}

class _MyHomePageState extends State<HomePage> {
  String idUser;

  _MyHomePageState({Key? key, required this.idUser});

  late String url = url1 + '/modoJogo/lista';

//late String urlSocket = 'http://201.42.59.203:3334/';
  var _lista = [];

  void getTest() async {
    try {
      final response = await http.get(
        Uri.parse(url),
      );
      final jsonData = jsonDecode(response.body) as List;
      setState(() {
        _lista = jsonData;
        print(_lista.toString());
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    getTest();
    socketConnect().login(idUser);
    socketConnect().home();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
        color: const Color(0xFFDDDDDD),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: const Color(0xFFDDDDDD),
          primaryColor: const Color(0xFFDDDDDD),
        ),
        home: Scaffold(
          backgroundColor: const Color(0xFFDDDDDD),
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            backgroundColor: const Color(0xFF293241),
            toolbarHeight: 100,
            actionsIconTheme:
                const IconThemeData(size: 30.0, color: Color(0xFFDDDDDD)),
            centerTitle: true,
            title: const Text('MODO DE JOGO'),
            actions: <Widget>[
              Container(
                height: 30,
                width: 70,
                color: const Color(0xFF293241),
                child: Center(
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blueGrey[900],
                          elevation: 5,
                          shadowColor: Colors.grey),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoadEnergia(),
                            ));
                      },
                      child: const Text(
                        '20/20 +',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      )),
                ),
              )
            ],
          ),
          body: Container(
            width: size.width,
            height: size.height,
            color: const Color(0xFFDDDDDD),
            child: LayoutBuilder(builder: (_, constraints) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * .88,
                      color: const Color(0xFFDDDDDD),
                      child: Stack(
                        children: [
                          Column(children: [
                            Container(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight * .88,
                              color: const Color(0xFFDDDDDD),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                      //child: GridView.builder(
                                      // gridDelegate:
                                      //      const SliverGridDelegateWithFixedCrossAxisCount(
                                      //           crossAxisCount: 1,
                                      //          childAspectRatio: 1),
                                      //   itemCount: 1,
                                      //   itemBuilder: (context, index) {
                                      //     return
                                      child: Column(children: <Widget>[
                                    SizedBox(
                                        width: constraints.maxWidth * .95,
                                        height: constraints.maxHeight * .21,
                                        child: SizedBox(
                                            width: constraints.maxWidth * .90,
                                            height: constraints.maxHeight * .20,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: constraints.maxWidth *
                                                      .40,
                                                  height:
                                                      constraints.maxHeight *
                                                          .15,
                                                  decoration: const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      10)),
                                                      color: Colors.grey),
                                                  child: Image.asset(
                                                      'assets/computadores.png'),
                                                ),
                                                SizedBox(
                                                  width: constraints.maxWidth *
                                                      .45,
                                                  height:
                                                      constraints.maxHeight *
                                                          .18,
                                                  child: TextButton(
                                                    style: TextButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.white,
                                                        elevation: 15,
                                                        shadowColor:
                                                            Colors.grey),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: const [
                                                        Text(
                                                          'Jogar vs IA',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black),
                                                          softWrap: true,
                                                        ),
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5)),
                                                        Text(
                                                          "    Em manutenção",
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.red),
                                                          softWrap: true,
                                                        ),
                                                      ],
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  LoadCenario(
                                                                      idmodojogo:
                                                                          _lista[0]
                                                                              [
                                                                              'idModoJogo'],
                                                                      idUser:
                                                                          idUser)));
                                                    },
                                                  ),
                                                )
                                              ],
                                            ))),
                                    SizedBox(
                                        width: constraints.maxWidth * .95,
                                        height: constraints.maxHeight * .21,
                                        child: SizedBox(
                                            width: constraints.maxWidth * .90,
                                            height: constraints.maxHeight * .20,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                    width:
                                                        constraints
                                                                .maxWidth *
                                                            .40,
                                                    height:
                                                        constraints
                                                                .maxHeight *
                                                            .15,
                                                    decoration:
                                                        const BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10)),
                                                            color: Colors.grey,
                                                            image:
                                                                DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/Cópia de jostik.png'),
                                                              fit: BoxFit
                                                                  .contain,
                                                            ))),
                                                SizedBox(
                                                  width: constraints.maxWidth *
                                                      .45,
                                                  height:
                                                      constraints.maxHeight *
                                                          .18,
                                                  child: TextButton(
                                                    style: TextButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.white,
                                                        elevation: 15,
                                                        shadowColor:
                                                            Colors.grey),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: const [
                                                        Text(
                                                          'Jogar vs Amigo',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black),
                                                          softWrap: true,
                                                        ),
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5)),
                                                        Text(
                                                          "Aproximadamente 4 min.",
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color: Colors
                                                                  .orange),
                                                          softWrap: true,
                                                        ),
                                                      ],
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  LoadCenario(
                                                                      idmodojogo:
                                                                          _lista[1]
                                                                              [
                                                                              'idModoJogo'],
                                                                      idUser:
                                                                          idUser)));
                                                    },
                                                  ),
                                                )
                                              ],
                                            ))),
                                    SizedBox(
                                        width: constraints.maxWidth * .95,
                                        height: constraints.maxHeight * .21,
                                        child: SizedBox(
                                            width: constraints.maxWidth * .90,
                                            height: constraints.maxHeight * .20,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                    width:
                                                        constraints
                                                                .maxWidth *
                                                            .40,
                                                    height:
                                                        constraints
                                                                .maxHeight *
                                                            .15,
                                                    decoration:
                                                        const BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10)),
                                                            color: Colors.grey,
                                                            image:
                                                                DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/cubos.png'),
                                                              fit: BoxFit
                                                                  .contain,
                                                            ))),
                                                SizedBox(
                                                  width: constraints.maxWidth *
                                                      .45,
                                                  height:
                                                      constraints.maxHeight *
                                                          .18,
                                                  child: TextButton(
                                                    style: TextButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.white,
                                                        elevation: 15,
                                                        shadowColor:
                                                            Colors.grey),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: const [
                                                        Text(
                                                          'Jogar vs Aleátorio',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black),
                                                          softWrap: true,
                                                        ),
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5)),
                                                        Text(
                                                          "Aproximadamente 2 min.",
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color: Colors
                                                                  .orange),
                                                          softWrap: true,
                                                        ),
                                                      ],
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  LoadCenario(
                                                                      idmodojogo:
                                                                          _lista[2]
                                                                              [
                                                                              'idModoJogo'],
                                                                      idUser:
                                                                          idUser)));
                                                    },
                                                  ),
                                                )
                                              ],
                                            )))
                                  ])
                                      //},
                                      //),
                                      ),
                                ],
                              ),
                            ),
                          ])
                        ],
                      ),
                    ),
                    Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * .12,
                      //color: Colors.lightBlue[600],
                      decoration: BoxDecoration(
                          color: const Color(0xFF293241),
                          border: Border.all(color: Colors.black),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),

                      child: _buildRodapeicons(),
                    ),
                  ]);
            }),
          ),
        ));
  }

  Widget _buildRodapeicons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _icons1(),
        _icons2(),
        _icons3(),
      ],
    );
  }

  Widget _icons1() {
    return Column(
      children: <Widget>[
        IconButton(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          iconSize: 50,
          icon: const Icon(Icons.play_arrow),
          tooltip: 'Jogar',
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PositionBoat(idPartida: socketConnect.idPartida, idJogador: this.idUser)));
          },
        ),
      ],
    );
  }

  Widget _icons2() {
    return Column(
      children: <Widget>[
        IconButton(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          iconSize: 50,
          icon: const Icon(Icons.person),
          tooltip: 'Perfil',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilePage(
                          idUser: idUser,
                        )));
          },
        ),
      ],
    );
  }

  Widget _icons3() {
    return Column(
      children: <Widget>[
        IconButton(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            iconSize: 50,
            icon: const Icon(Icons.settings),
            tooltip: 'Configurações',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoadConfig()));
            }),
      ],
    );
  }
}
