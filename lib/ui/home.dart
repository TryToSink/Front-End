import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proj0511/ui/cenarios.dart';
import 'package:proj0511/ui/configuracao.dart';
import 'package:proj0511/ui/energia.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  late String url = 'http://3.144.90.4:3333/modoJogo/lista';
//  late String urlSocket = 'http://3.144.90.4:3334/';
  var _lista = [];

//  final _channel =
//      WebSocketChannel.connect(Uri.parse('http://3.144.90.4:3334/'));

//  void _sendMessage() {
//    if (_lista.isNotEmpty) {
//      _channel.sink.add('oi');
//    }/
//  }
//
//  @override
//  void dispose() {
//    _channel.sink.close();
//    super.dispose();
//  }

//  var connection = WebSocket('http://3.144.90.4:3334/',['soap','xmpp']);
//  connection.onopen = function (){
//    connection.send('Ping');
//  }
//  connection.onerror = function (error){
//    console.log('WebSocket Error ' + error);
//  }
//  connection.onmessage = function (e){
//    console.log('Server: ' + e.data);
//  }

  void getTest() async {
    try {
      final response = await http.get(
        Uri.parse(url),
      );
      final jsonData = jsonDecode(response.body) as List;
      setState(() {
        _lista = jsonData;
      });
    } catch (error) {}
  }

//  void connectServer() async {
//    try {} catch (error) {}
//  }

  @override
  void initState() {
    super.initState();
    getTest();
  }

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
            backgroundColor: Colors.blueGrey[900],
            actionsIconTheme:
                const IconThemeData(size: 30.0, color: Colors.white),
            title: const Center(
              child: (Text('                MODO DE JOGO')),
            ),
            actions: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 10,
                    width: 60,
                    color: Colors.blueGrey[900],
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
                          child: Text(
                            '/20 +',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ))
            ],
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
                      height: constraints.maxHeight * .85,
                      color: Colors.grey[350],
                      child: Stack(
                        children: [
                          Column(children: [
                            Container(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight * .85,
                              color: Colors.grey[350],
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 1,
                                              childAspectRatio: 1.5),
                                      itemCount: _lista.length,
                                      itemBuilder: (context, index) {
                                        return SizedBox(
                                            width: constraints.maxWidth * .90,
                                            height: constraints.maxHeight *
                                                .85 *
                                                .30,
                                            child: SizedBox(
                                                width:
                                                    constraints.maxWidth * .30,
                                                height: constraints.maxHeight *
                                                    .85 *
                                                    .20,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        width: constraints
                                                                .maxWidth *
                                                            .40,
                                                        height: constraints
                                                                .maxHeight *
                                                            .85 *
                                                            .39,
                                                        decoration:
                                                            const BoxDecoration(
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10)),
                                                                color: Colors
                                                                    .white,
                                                                image:
                                                                    DecorationImage(
                                                                  image: NetworkImage(
                                                                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ))),
                                                    SizedBox(
                                                      width:
                                                          constraints.maxWidth *
                                                              .40,
                                                      height: constraints
                                                              .maxHeight *
                                                          .85 *
                                                          .39,
                                                      child: TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                elevation: 15,
                                                                shadowColor:
                                                                    Colors
                                                                        .grey),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Text(
                                                              _lista[index]
                                                                      ["nome"]
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black),
                                                              softWrap: true,
                                                            ),
                                                            const Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            5)),
                                                            Text(
                                                              "Aproximadamente " +
                                                                  _lista[index][
                                                                          "duracao"]
                                                                      .toString() +
                                                                  " min.",
                                                              style: const TextStyle(
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
                                                                  builder:
                                                                      (context) =>
                                                                          LoadCenario(
                                                                            idmodojogo:
                                                                                _lista[index]["idModoJogo"],
                                                                          )));
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                )));
                                      },
                                    ),
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
                      height: constraints.maxHeight * .15,
                      //color: Colors.lightBlue[600],
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[900],
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
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          iconSize: 50,
          icon: const Icon(Icons.play_arrow),
          tooltip: 'Jogar',
          onPressed: () {
            //  Navigator.push(
            //    context,
            //    MaterialPageRoute(
            //      builder: (context) => LoadPage(),
            //    ),
            //  );
          },
        ),
      ],
    );
  }

  Widget _icons2() {
    return Column(
      children: <Widget>[
        IconButton(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          iconSize: 50,
          icon: const Icon(Icons.person),
          tooltip: 'Perfil',
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _icons3() {
    return Column(
      children: <Widget>[
        IconButton(
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
