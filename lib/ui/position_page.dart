// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proj0511/barco_posicao.dart';
import 'package:proj0511/create_partida_api.dart';
import 'package:proj0511/posicao.dart';
import 'package:proj0511/ui/battle_page.dart';
import 'package:http/http.dart' as http;

import 'package:proj0511/ui/barcos_dto.dart';
import '../timer.dart';

class PositionBoat extends StatefulWidget {
  const PositionBoat({Key? key}) : super(key: key);

  @override
  _PositionBoatState createState() => _PositionBoatState();
}

class _PositionBoatState extends State<PositionBoat> {
  // Declarações de variaveis
  final linhasColunas = 10;
  List _lista = [];
  List _mCampo = [];
  List _aCampo = [];
  List<int> barcosUsados = [];
  bool usado = false;
  bool _rotation = false;
  List<BarcosDTO> pBuild = [];
  List<BarcoPosicao> barcosPosicoes = [];
  Color buttonColor = Colors.blueAccent;
  final degress = 90.0;
  String defaultImage = "assets/water.png";
  int aux = 0;
  Random random = new Random();
  int maxAlt = 6;
  double gridSize = 0.0;
  double gridSize1 = 0.0;

  Future<List> carregarCenario() async {
    http.Response response;
    String url =
        'http://3.144.90.4:3333/cenario/find?idCenario=7a7ee764-bf9b-4fbc-916c-020568e8e032';
    response = await http.get(Uri.parse(url));
    print("response ${response.body}");
    return json.decode("[" + response.body + "]");
  }

  Widget getFoto(String foto) {
    final url = "http://3.144.90.4:3333/files/";
    return Image.network(
      url + foto,
      fit: BoxFit.fill,
    );
  }

  void setBarcos() {
    pBuild = [];
    List<dynamic> _barcos = _lista;

    for (int i = 0; i < _barcos.length; i++) {
      BarcosDTO barco = new BarcosDTO();
      barco.iDBarco = _barcos[i]["IDBarco"];
      barco.nomeBarco = _barcos[i]["nome"];
      barco.tamanho = _barcos[i]["tamanho"];
      barco.foto1 = _barcos[i]["foto1"];
      barco.foto2 = _barcos[i]["foto2"];
      barco.foto3 = _barcos[i]["foto3"];
      barco.foto4 = _barcos[i]["foto4"];
      barco.foto5 = _barcos[i]["foto5"];

      pBuild.add(barco);
      print(pBuild.length);
    }
  }

  // criacao do MAP para o grid
  void _addPosition(int x, int y) {
    setState(() {
      Map<String, dynamic> newPos = Map();
      newPos["linha"] = x;
      newPos["coluna"] = y;
      newPos["status"] = false;
      newPos["ataque"] = false;
      newPos["rotacao"] = false;
      newPos["image"] = "";

      _mCampo.add(newPos);
      Map<String, dynamic> newPos1 = Map();
      newPos1["linha"] = x;
      newPos1["coluna"] = y;
      newPos1["status"] = false;
      newPos1["ataque"] = false;
      newPos1["rotacao"] = false;
      newPos1["image"] = "";
      _aCampo.add(newPos1);
    });
  }

// funcao auxiliar de laco matriz
  void _laco(int x, int y, var func) {
    for (int i = 0; i < x; i++) {
      for (int j = 0; j < y; j++) {
        func(i, j);
      }
    }
  }

  // funcao auxiliar de laco simplez
  void _laco2(int x, var func) {
    for (int i = 0; i < x; i++) {
      func(i);
    }
  }

// mensagem de snackbar
  void msgSnack(String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

// inicio da tela
  @override
  void initState() {
    super.initState();
    carregarCenario().then((map) {});

    _laco(linhasColunas, linhasColunas, _addPosition);
    // startTimer();
    switch (linhasColunas) {
      case 8:
        gridSize = 0.10;
        gridSize1 = 0.0;
        break;
      case 10:
        gridSize = 0.08;
        break;
      case 12:
        gridSize = 0.06;
        break;
    }
  }

// funcao para posicionar barco
  void posicionaBarco(
      int index, String name, int n, String img, BarcosDTO barco) {
    BarcoPosicao posBarco = new BarcoPosicao(barco);
    bool save = true;

    if (_rotation == false) {
      for (int i = 0; i < n; i++) {
        if (_mCampo[index + i]["status"] == false &&
            _mCampo[index + i]["coluna"] != linhasColunas - 1) {
          _mCampo[index + i]["image"] = barco.returnFoto(i);
          _mCampo[index + i]["status"] = true;
          aux = i;
          Posicao eixos = new Posicao();
          eixos.foto = _mCampo[index + i]["image"];
          eixos.eixoX = _mCampo[index]["linha"];
          eixos.eixoY = _mCampo[index + i]["coluna"];

          posBarco.posicoes.add(eixos);
        } else {
          bool save = false;
          for (int j = aux; j >= 0; j--) {
            _mCampo[index + j]["image"] = "";
            _mCampo[index + j]["status"] = false;
            i = n;
          }
          msgSnack("Erro ao posicionar Barco, tente novamente");
          if (save == false) {
            barcosPosicoes.removeLast();
            barcosUsados.removeLast();
          }
        }
      }
    } else
      for (int i = 0; i < n; i++) {
        if (_mCampo[index + i * linhasColunas]["status"] == false &&
            _mCampo[index + i]["linha"] != 9) {
          _mCampo[index + i * linhasColunas]["image"] = barco.returnFoto(i);
          _mCampo[index + i * linhasColunas]["status"] = true;
          _mCampo[index + i * linhasColunas]["rotacao"] = true;
          aux = i;
          Posicao eixos = new Posicao();
          eixos.foto = _mCampo[index + i * linhasColunas]["image"];
          eixos.eixoX = _mCampo[index]["linha"];
          eixos.eixoY = _mCampo[index + i * linhasColunas]["coluna"];
        } else {
          bool save = false;
          for (int j = aux; j >= 0; j--) {
            _mCampo[index + j * linhasColunas]["image"] = "";
            _mCampo[index + j * linhasColunas]["status"] = false;
            _mCampo[index + j * linhasColunas]["rotacao"] = false;
            i = n;
          }
          msgSnack("Erro ao posicionar Barco, tente novamente");
          if (save == false) {
            barcosPosicoes.removeLast();
            barcosUsados.removeLast();
          }
        }
      }
    barcosPosicoes.add(posBarco);
    if (save == false) barcosPosicoes.removeLast();
  }

  // funcao para posicionar barco aleatorio
  void posicionaBarcoAlt(int index, int n, String img) {
    if (_rotation == false) {
      for (int i = 0; i < n; i++) {
        if (_mCampo[index + i]["status"] == false &&
            _mCampo[index + i]["coluna"] != 9) {
          _mCampo[index + i]["image"] = img + i.toString() + ".png";
          _mCampo[index + i]["status"] = true;
          aux = i;
        } else {
          for (int j = aux; j >= 0; j--) {
            _mCampo[index + j]["image"] = "";
            _mCampo[index + j]["status"] = false;
            i = n;
          }
          maxAlt++;
        }
      }
    } else
      for (int i = 0; i <= n; i++) {
        if (_mCampo[index + i * linhasColunas]["status"] == false &&
            _mCampo[index + i]["linha"] != 9) {
          _mCampo[index + i * linhasColunas]["image"] =
              img + i.toString() + ".png";
          _mCampo[index + i * linhasColunas]["status"] = true;
          _mCampo[index + i * linhasColunas]["rotacao"] = true;
          aux = i;
        } else {
          for (int j = aux; j >= 0; j--) {
            _mCampo[index + j * linhasColunas]["image"] = "";
            _mCampo[index + j * linhasColunas]["status"] = false;
            _mCampo[index + j * linhasColunas]["rotacao"] = false;
            i = n;
          }
          maxAlt++;
        }
      }
  }

  // funcao cria targets para o grid
  Widget buildTargets(BuildContext context, int index) {
    return DragTarget<int>(
        builder: (context, data, rejectData) => Container(
              child: _mCampo[index]["status"]
                  ? _mCampo[index]["rotacao"]
                      ? Transform.rotate(
                          angle: degress * pi / 180,
                          child: _mCampo[index]["status"]
                              ? getFoto(_mCampo[index]["image"])
                              : Image.asset(defaultImage),
                        )
                      : getFoto(_mCampo[index]["image"])
                  : Image.asset(defaultImage),
              color: Colors.blueAccent,
            ),
        onAccept: (data) {
          if (_mCampo[index]["status"] == false &&
              _mCampo[index]["linha"] != 9) {
            setState(() {
              print("data: $data");
              barcosUsados.add(data);
              String img = pBuild[data].foto1;
              String name = pBuild[data].nomeBarco;
              int n = pBuild[data].tamanho;
              posicionaBarco(index, name, n, img, pBuild[data]);
              if (barcosUsados.length == _lista.length)
                msgSnack("Barcos já posicionados... PRONTO PARA BATALHA!!");
            });
          } else {
            msgSnack("Erro ao posicionar Barco, tente novamente");
            barcosPosicoes.removeLast();
          }
        });
  }

// funcao para criar quadrados do grid
  Widget buildB(String foto, int index, int tamanho) {
    usado = false;
    if (barcosUsados.length > 0) {
      int i = 0;
      do {
        if (index == barcosUsados[i]) usado = true;
        i++;
      } while (i < barcosUsados.length && usado == false);
    }
    return usado
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Container(
                  height: 80,
                  width: 180,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xff3D5A80)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      getFoto(foto),
                      Text("$tamanho", style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
          );
  }

// funcao para limpar grid
  void resetGrid() {
    setState(() {
      _mCampo = [];
      barcosPosicoes = [];
      barcosUsados = [];
      _laco(linhasColunas, linhasColunas, _addPosition);
    });
  }

// funcoes para inciar barcos na pagina

  Widget barcosBotoes(BuildContext context, AsyncSnapshot snapshot) {
    _lista = snapshot.data[0]["barcos"];
    setBarcos();
    return ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: _getCount(snapshot.data[0]["barcos"]),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        print("barcosusados: ${barcosUsados.length}");
        return Draggable<int>(
          child: buildB(snapshot.data[0]["barcos"][index]["foto1"], index,
              snapshot.data[0]["barcos"][index]["tamanho"]),
          feedback: buildB(snapshot.data[0]["barcos"][index]["foto1"], index,
              snapshot.data[0]["barcos"][index]["tamanho"]),
          childWhenDragging: Container(),
          data: index,
        );
      },
    );
  }

  int _getCount(List data) {
    return data.length;
  }

// funcao aleatorio
  void aleatorio() {
    int rndIndex = 0;
    int rndBarco = 0;
    for (int i = 0; i <= maxAlt; i++) {
      rndIndex = random.nextInt(_mCampo.length);
      rndBarco = random.nextInt(2);
      posicionaBarcoAlt(
          rndIndex, pBuild[rndBarco].tamanho, pBuild[rndBarco].foto1);
      if (i / 2 == 0)
        _rotation = true;
      else
        _rotation = false;
    }
    maxAlt = 6;
    _rotation = false;
  }

//funcao para o Timer
  void startTimer() {
    time = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (mins == 0 && seconds == 0) {
          time?.cancel();
          print(barcosPosicoes);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BatlePage(_mCampo, _aCampo)));
          if (barcosPosicoes.isEmpty || barcosPosicoes.length < 5) aleatorio();
        } else if (seconds == 0) {
          mins--;
          seconds = maxSeconds;
        } else
          seconds--;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Batalha Naval, building tab"),
        centerTitle: true,
        backgroundColor: Color(0xff293241),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            time?.cancel();
            Navigator.pop(context, false);
            _mCampo = [];
            pBuild = [];
          },
        ),
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (_, constraints) {
          return Column(mainAxisAlignment: MainAxisAlignment.start, children: <
              Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Color(0xff293241),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              height: 50,
              width: constraints.maxWidth,
              child: Center(
                child: timer(),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      height: constraints.maxHeight * 0.50,
                      width: constraints.maxWidth * 0.76,
                      child: LayoutBuilder(builder: (_, constraints2) {
                        return GridView.builder(
                            itemCount: _mCampo.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent:
                                        constraints2.maxHeight * gridSize,
                                    mainAxisSpacing:
                                        constraints2.maxHeight * 0.003,
                                    crossAxisSpacing:
                                        constraints2.maxWidth * 0.003,
                                    crossAxisCount: linhasColunas),
                            itemBuilder: buildTargets);
                      })),
                  Container(
                    alignment: Alignment.center,
                    height: constraints.maxHeight * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: constraints.maxHeight * 0.08,
                          child: ElevatedButton(
                            onPressed: aleatorio,
                            child: Text("A"),
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xff3D5A80)),
                          ),
                        ),
                        Container(
                          height: constraints.maxHeight * 0.08,
                          child: ElevatedButton(
                            onPressed: _rotation
                                ? () {
                                    setState(() {
                                      _rotation = false;
                                      buttonColor = Color(0xff3D5A80);
                                    });
                                  }
                                : () {
                                    setState(() {
                                      _rotation = true;
                                      buttonColor = Colors.redAccent;
                                    });
                                  },
                            child: Icon(Icons.replay),
                            style: ElevatedButton.styleFrom(
                                primary: buttonColor,
                                onSurface: Color(0xff3D5A80)),
                          ),
                        ),
                        Container(
                          height: constraints.maxHeight * 0.08,
                          child: ElevatedButton(
                            onPressed: resetGrid,
                            child: Icon(Icons.delete_rounded),
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xff3D5A80)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight * 0.18,
              child: Expanded(
                child: FutureBuilder(
                    future: carregarCenario(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.black),
                              strokeWidth: 5.0,
                            ),
                          );
                        default:
                          if (snapshot.hasError)
                            return Container();
                          else
                            return barcosBotoes(context, snapshot);
                      }
                    }),
              ),
            ),
            Container(
              height: constraints.maxHeight * 0.10,
              width: constraints.maxWidth * 0.40,
              padding: EdgeInsets.only(top: 30),
              child: Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    time?.cancel();
                    // CreatePartida.create(idPartida, idJogador, barcoPosicao);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BatlePage(_mCampo, _aCampo)));
                  },
                  style: ElevatedButton.styleFrom(primary: Color(0xff3D5A80)),
                  child: const Text(
                    "Pronto!",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ]);
        },
      ),
    );
  }
}