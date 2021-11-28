import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../barco_posicao.dart';
import '../posicao.dart';
import '../timer.dart';
import 'barcos_dto.dart';
import 'battle_page.dart';

class PositionBoat extends StatefulWidget {
  const PositionBoat({Key? key}) : super(key: key);

  @override
  _PositionBoatState createState() => _PositionBoatState();
}

class _PositionBoatState extends State<PositionBoat> {
  // Declarações de variaveis
  final linhasColunas = 10;
  List _mCampo = [];
  List _aCampo = [];
  bool _rotation = false;
  List<BarcosDTO> pBuild = [];
  List<BarcoPosicao> barcosPosicoes = [];
  Color buttonColor = Colors.blueAccent;
  final degress = 90.0;
  String defaultImage = "images/water.png";
  int aux = 0;
  Random random = new Random();
  int maxAlt = 6;
  var _jogo = [];
  double gridSize = 0.0;

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

  // funcao para receber jogo
  void getBoat() {
    /*final response = await http.get(Uri.parse(urlCriaJogo));
      print(response.body);*/
    final json =
        '{"jogadorPartida1":{"idPartida":"9af70417-3f0e-479d-8ec4-25579c5ed5b4","cenario":{"idCenario":"7a7ee764-bf9b-4fbc-916c-020568e8e032","nome":"Pearl Harbor","descricao":"Jogue neste cenário histórico.","barcos":[{"IDBarco":"d5a98f49-79de-4e8b-87f8-61ca9e806f9d","nome":"Destroier 2","tamanho":2,"foto1":"images/boat.png","foto2":null,"foto3":null,"foto4":null,"foto5":null},{"IDBarco":"c3d9e16c-33b2-420f-a3a5-ac8157b50d9d","nome":"Corveta","tamanho":3,"foto1":"images/baco.png","foto2":null,"foto3":null,"foto4":null,"foto5":null}],"foto":"573522fbfc3a0be11ef6-pearlharbor200000000000003393_widelg.jpg"},"adversario":{"id":"013291fa-dabc-4a9d-abdb-76d66521cde1","name":"Magaiver Braga","nacionalidade":null,"elo":null}}}';
    Map<String, dynamic> jsonData = jsonDecode(json);
    jsonData["jogadorPartida1"];
    setState(() {
      _jogo.add(jsonData);
      print(_jogo);
    });
    print(_jogo);
  }

  // funcao para enviar para o back os barcos posicionados
  void sendBoats(int index) async {
    /*try {
      final response = await http.post(
        Uri.parse(urlPost),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode({
          'nome': name,
          'foto': '1234',
          'tamanho': size,
        }),
      );
      print(response.body);
    } catch (error) {
      print(error);
    }*/
  }

// mensagem de snackbar
  void msgSnack(String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

// inicio da tela
  @override
  void initState() {
    super.initState();

    _laco(linhasColunas, linhasColunas, _addPosition);
    startTimer();
    getBoat();
    setBarcos();
    switch (linhasColunas) {
      case 8:
        gridSize = 0.10;
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
    String imgUse = img.substring(0, 11);
    BarcoPosicao posBarco = new BarcoPosicao(barco);
    bool save = true;

    if (_rotation == false) {
      for (int i = 0; i < n; i++) {
        if (_mCampo[index + i]["status"] == false &&
            _mCampo[index + i]["coluna"] != 9) {
          _mCampo[index + i]["image"] = imgUse + i.toString() + ".png";
          _mCampo[index + i]["status"] = true;
          aux = i;
          Posicao eixos = new Posicao();
          print("i: $i");
          print("coluna: ${_mCampo[index + i]["coluna"]}");
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
          if (save == false) barcosPosicoes.removeLast();
        }
      }
    } else
      for (int i = 0; i < n; i++) {
        if (_mCampo[index + i * linhasColunas]["status"] == false &&
            _mCampo[index + i]["linha"] != 9) {
          _mCampo[index + i * linhasColunas]["image"] =
              imgUse + i.toString() + ".png";
          _mCampo[index + i * linhasColunas]["status"] = true;
          _mCampo[index + i * linhasColunas]["rotacao"] = true;
          aux = i;
        } else {
          bool save = false;
          for (int j = aux; j >= 0; j--) {
            _mCampo[index + j * linhasColunas]["image"] = "";
            _mCampo[index + j * linhasColunas]["status"] = false;
            _mCampo[index + j * linhasColunas]["rotacao"] = false;
            i = n;
          }
          msgSnack("Erro ao posicionar Barco, tente novamente");
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
                              ? Image.asset(
                                  "${_mCampo[index]["image"]}",
                                  fit: BoxFit.fill,
                                )
                              : Image.asset(defaultImage),
                        )
                      : Image.asset(
                          "${_mCampo[index]["image"]}",
                          fit: BoxFit.fill,
                        )
                  : Image.asset(defaultImage),
              color: Colors.blueAccent,
            ),
        onAccept: (data) {
          if (_mCampo[index]["status"] == false &&
              _mCampo[index]["linha"] != 9) {
            setState(() {
              print("data: $data");
              String img = pBuild[data].foto1;
              String name = pBuild[data].nomeBarco;
              int n = pBuild[data].tamanho;
              posicionaBarco(index, name, n, img, pBuild[data]);
            });
          } else {
            msgSnack("Erro ao posicionar Barco, tente novamente");
            barcosPosicoes.removeLast();
          }
        });
  }

// funcao para criar quadrados do grid
  Widget buildB(String a) {
    return Container(
      height: 50,
      width: 90,
      decoration: BoxDecoration(
          color: Color(0xff3D5A80),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      alignment: Alignment.center,
      child: Image.asset(
        a,
        fit: BoxFit.cover,
      ),
    );
  }

// funcao para criar Bota Drag
  Widget buildB2(int index, String a) {
    return Draggable<int>(
      child: buildB(a),
      feedback: buildB(a),
      data: index,
    );
  }

// funcao para limpar grid
  void resetGrid() {
    setState(() {
      _mCampo = [];
      _laco(linhasColunas, linhasColunas, _addPosition);
    });
  }

// funcao para inciar barcos na pagina
  void setBarcos() {
    List<dynamic> _Barcos = _jogo[0]["jogadorPartida1"]["cenario"]["barcos"];

    for (int i = 0; i < _Barcos.length; i++) {
      BarcosDTO barco = new BarcosDTO();
      barco.iDBarco = _Barcos[i]["idBarco"];
      barco.nomeBarco = _Barcos[i]["nome"];
      barco.tamanho = _Barcos[i]["tamanho"];
      barco.foto1 = _Barcos[i]["foto1"];
      barco.foto2 = _Barcos[i]["foto2"];
      barco.foto3 = _Barcos[i]["foto3"];
      barco.foto4 = _Barcos[i]["foto4"];
      barco.foto5 = _Barcos[i]["foto5"];

      pBuild.add(barco);
      print(pBuild.length);
    }
    print(pBuild[0].foto1);
    print(pBuild[1].foto1);
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
    time = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (mins == 0 && seconds == 0) {
          time?.cancel();
          print(barcosPosicoes);
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
          return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
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
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          height: constraints.maxHeight * 0.50,
                          width: constraints.maxWidth * 0.7,
                          child: LayoutBuilder(builder: (_, constraints2) {
                            return GridView.builder(
                                itemCount: _mCampo.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisExtent:
                                            constraints2.maxHeight * gridSize,
                                        mainAxisSpacing:
                                            constraints2.maxHeight * 0.001,
                                        crossAxisSpacing:
                                            constraints2.maxWidth * 0.001,
                                        crossAxisCount: linhasColunas),
                                itemBuilder: buildTargets);
                          })),
                      Container(
                        alignment: Alignment.center,
                        height: constraints.maxHeight * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                onPressed: () {
                                  print(barcosPosicoes.length);
                                  print(barcosPosicoes[0].barco.nomeBarco);
                                  print(barcosPosicoes[1].barco.nomeBarco);
                                  print(barcosPosicoes.length);
                                  print(
                                      barcosPosicoes[0].posicoes[1].retorno());
                                },
                                child: Icon(Icons.replay),
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xff3D5A80)),
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
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buildB2(0, pBuild[0].foto1),
                      buildB2(1, pBuild[1].foto1),
                      buildB2(1, pBuild[1].foto1),
                      IconButton(
                        onPressed: _rotation
                            ? () {
                                setState(() {
                                  _rotation = false;
                                  buttonColor = Colors.blueAccent;
                                });
                              }
                            : () {
                                setState(() {
                                  _rotation = true;
                                  buttonColor = Colors.redAccent;
                                });
                              },
                        icon: Icon(Icons.refresh),
                        color: buttonColor,
                        hoverColor: Color(0xff3D5A80),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Container(
                    height: constraints.maxHeight * 0.08,
                    width: constraints.maxWidth * 0.25,
                    child: ElevatedButton(
                      onPressed: () {
                        time?.cancel();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BatlePage(_mCampo, _aCampo)));
                      },
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xff3D5A80)),
                      child: Text(
                        "Pronto!",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                )
              ]);
        },
      ),
    );
  }
}
