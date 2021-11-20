import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:front_main/ui/load.dart';
import 'package:front_main/ui/perfil.dart';
import 'gameMode.dart';
import 'package:http/http.dart' as http;
import 'package:proj0511/ui/cenarios.dart';
import 'package:proj0511/ui/configuracao.dart';
import 'package:proj0511/ui/energia.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  late String url = 'http://3.144.90.4:3333/modoJogo/lista';
  var _lista = [];
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

            actionsIconTheme: IconThemeData(size: 30.0, color: Colors.white),
            title: Text('Batalha naval'),
            centerTitle: true,
            backgroundColor: Colors.blueGrey[900],

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
                                                                  color: Colors.black)),
                                                      color: Colors.blue[900],
                                                      textColor: Colors.white,
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    LoadPage(),
                                                          ),
                                                        );
                                                      },
                                                      child: Text(
                                                        "JOGUE AQUI",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                    FlatButton(
                                                      minWidth:
                                                          constraints.maxWidth *
                                                              .80 *
                                                              .30,
                                                      height: constraints
                                                              .maxHeight *
                                                          .87 *
                                                          .92 *
                                                          .70 *
                                                          .30,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              side: BorderSide(
                                                                  color: Colors
                                                                      .black)),
                                                      color: Colors.blue[900],
                                                      textColor: Colors.white,
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    GameMode(),
                                                          ),
                                                        );
                                                      },
                                                      child: Text(
                                                        "JOGUE AQUI",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                    FlatButton(
                                                      minWidth:
                                                          constraints.maxWidth *
                                                              .80 *
                                                              .30,
                                                      height: constraints
                                                              .maxHeight *
                                                          .87 *
                                                          .92 *
                                                          .70 *
                                                          .30,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              side: BorderSide(
                                                                  color: Colors
                                                                      .black)),
                                                      color: Colors.blue[900],
                                                      textColor: Colors.white,
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    GameMode(),
                                                          ),
                                                        );
                                                      },
                                                      child: Text(
                                                        "JOGUE AQUI",
                                                        style: TextStyle(
                                                          fontSize: 20,

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
                      height: constraints.maxHeight * .24,
                      color: Colors.blueGrey[400],
                      child: Stack(
                        children: <Widget>[
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                child: FlatButton(
                                  minWidth: constraints.maxWidth * .95,
                                  height: constraints.maxHeight * .18 * .50,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(color: Colors.black)),
                                  color: Colors.blue[900],
                                  textColor: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GameMode(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "NOVA PARTIDA",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              _buildRodapeicons()
                            ],
                          ),
                        ],
                      ),
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
