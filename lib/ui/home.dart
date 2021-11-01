import 'package:flutter/material.dart';
import 'package:front_main/ui/load.dart';
import 'package:front_main/ui/perfil.dart';

import 'gameMode.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
//        brightness: Brightness.dark,
          primaryColor: Colors.blueGrey[400],
        ),
        home: Scaffold(
          appBar: AppBar(
            actionsIconTheme: IconThemeData(size: 30.0, color: Colors.white),
            title: Text('Batalha naval'),
            centerTitle: true,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                    height: 10,
                    width: 60,
                    color: Colors.lightBlue[800],
                    child: Center(
                      child: Text(
                        '17/20 +',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              ),
            ],
          ),
          body: Container(
            width: size.width,
            height: size.height,
            child: LayoutBuilder(builder: (_, constraints) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * .76,
                      color: Colors.green,
                      child: Stack(
                        children: [
                          Column(children: [
                            Container(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight * .87 * .20,
                              color: Colors.blueGrey,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 8, 0, 6),
                                child: Column(
                                  children: <Widget>[
                                    FlatButton(
                                      minWidth: constraints.maxWidth * .80,
                                      height: constraints.maxHeight *
                                          .87 *
                                          .20 *
                                          .80,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          side:
                                              BorderSide(color: Colors.black)),
                                      color: Colors.blue[900],
                                      textColor: Colors.white,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return Scaffold(
                                                appBar: AppBar(
                                                  automaticallyImplyLeading:
                                                      false,
                                                  title: Text(
                                                      "Segunda Rota (tela)"),
                                                ),
                                                body: Center(
                                                  child: RaisedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Retornar !'),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "ANUNCIE AQUI",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: constraints.maxWidth * .85,
                              height: constraints.maxHeight * .83 * .70,
                              color: Colors.black,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: GridView.builder(
                                      gridDelegate:
                                          new SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 1),
                                      itemCount: 2,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          // width: constraints.maxWidth * .80,
                                          // height:
                                          //     constraints.maxHeight * .85 * .50,
                                          color: Colors.yellow,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              FlatButton(
                                                minWidth: constraints.maxWidth *
                                                    .80 *
                                                    .70,
                                                height: constraints.maxHeight *
                                                    .87 *
                                                    .90,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    side: BorderSide(
                                                        color: Colors.black)),
                                                color: Colors.blue[900],
                                                textColor: Colors.white,
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
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
                                              Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
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
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
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
        _Icons1(),
        _Icons2(),
        _Icons3(),
      ],
    );
  }

  Widget _Icons1() {
    return Column(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.directions_boat_rounded),
          tooltip: 'Jogar',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoadPage(),
              ),
            );
          },
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Text(
            "Jogar",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _Icons2() {
    return Column(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.person),
          tooltip: 'Perfil',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PerfilPage(),
              ),
            );
          },
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
          child: Text(
            "Perfil",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _Icons3() {
    return Column(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.settings),
          tooltip: 'Configurações',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Scaffold(
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      title: Text("Segunda Rota (tela)"),
                    ),
                    body: Center(
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Retornar !'),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
          child: Text(
            "Configurações",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
