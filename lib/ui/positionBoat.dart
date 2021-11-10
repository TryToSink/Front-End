import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_main/ui/battlePage.dart';

class PositionBoat extends StatefulWidget {
  const PositionBoat({Key? key}) : super(key: key);

  @override
  _PositionBoatState createState() => _PositionBoatState();
}

class _PositionBoatState extends State<PositionBoat> {
  final linhasColunas = 10;
  List _campo = [];
  bool _rotation = false;
  List pBuild = [];
  Color buttonColor = Colors.blueAccent;
  final degress = 90.0;
  String defaultImage = "images/water.png";
  static const maxSeconds = 59;
  static const maxMins = 1;
  int seconds = maxSeconds;
  int mins = maxMins;
  Timer? time;
  int aux = 0;
  Random random = new Random();
  int maxAlt = 6;

  void _addPosition(int x, int y) {
    setState(() {
      Map<String, dynamic> newPos = Map();
      newPos["linha"] = x;
      newPos["coluna"] = y;
      newPos["status"] = false;
      newPos["ataque"] = false;
      newPos["rotacao"] = false;
      newPos["image"] = "";

      _campo.add(newPos);
    });
  }

  void _laco(int x, int y, var func) {
    for (int i = 0; i < x; i++) {
      for (int j = 0; j < y; j++) {
        func(i, j);
      }
    }
  }

  void msgSnack(String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();

    _laco(linhasColunas, linhasColunas, _addPosition);
    startTimer();
    setBarcos("images/boat.png", 1);
    setBarcos("images/baco.png", 2);
    setBarcos("images/veio.png", 3);
  }

  void posicionaBarco(int index, int n, String img) {
    String imgUse = img.substring(0, 11);
    if (_rotation == false) {
      for (int i = 0; i <= n; i++) {
        if (_campo[index + i]["status"] == false &&
            _campo[index + i]["coluna"] != 9) {
          _campo[index + i]["image"] = imgUse + i.toString() + ".png";
          _campo[index + i]["status"] = true;
          aux = i;
        } else {
          for (int j = aux; j >= 0; j--) {
            _campo[index + j]["image"] = "";
            _campo[index + j]["status"] = false;
            i = n;
          }
          msgSnack("Erro ao posicionar Barco, tente novamente");
          maxAlt++;
        }
      }
    } else
      for (int i = 0; i <= n; i++) {
        if (_campo[index + i * linhasColunas]["status"] == false &&
            _campo[index + i]["linha"] != 9) {
          _campo[index + i * linhasColunas]["image"] =
              imgUse + i.toString() + ".png";
          _campo[index + i * linhasColunas]["status"] = true;
          _campo[index + i * linhasColunas]["rotacao"] = true;
          aux = i;
        } else {
          for (int j = aux; j >= 0; j--) {
            _campo[index + j * linhasColunas]["image"] = "";
            _campo[index + j * linhasColunas]["status"] = false;
            _campo[index + j * linhasColunas]["rotacao"] = false;
            i = n;
          }
          msgSnack("Erro ao posicionar Barco, tente novamente");
          maxAlt++;
        }
      }
  }
  void posicionaBarcoAlt(int index, int n, String img) {
    String imgUse = img.substring(0, 11);
    if (_rotation == false) {
      for (int i = 0; i <= n; i++) {
        if (_campo[index + i]["status"] == false &&
            _campo[index + i]["coluna"] != 9) {
          _campo[index + i]["image"] = imgUse + i.toString() + ".png";
          _campo[index + i]["status"] = true;
          aux = i;
        } else {
          for (int j = aux; j >= 0; j--) {
            _campo[index + j]["image"] = "";
            _campo[index + j]["status"] = false;
            i = n;
          }
          maxAlt++;
        }
      }
    } else
      for (int i = 0; i <= n; i++) {
        if (_campo[index + i * linhasColunas]["status"] == false &&
            _campo[index + i]["linha"] != 9) {
          _campo[index + i * linhasColunas]["image"] =
              imgUse + i.toString() + ".png";
          _campo[index + i * linhasColunas]["status"] = true;
          _campo[index + i * linhasColunas]["rotacao"] = true;
          aux = i;
        } else {
          for (int j = aux; j >= 0; j--) {
            _campo[index + j * linhasColunas]["image"] = "";
            _campo[index + j * linhasColunas]["status"] = false;
            _campo[index + j * linhasColunas]["rotacao"] = false;
            i = n;
          }
          maxAlt++;
        }
      }
  }

  Widget buildTargets(BuildContext context, int index) {
    return DragTarget<int>(
        builder: (context, data, rejectData) => Container(
              child: _campo[index]["status"]
                  ? _campo[index]["rotacao"]
                      ? Transform.rotate(
                          angle: degress * pi / 180,
                          child: _campo[index]["status"]
                              ? Image.asset(
                                  "${_campo[index]["image"]}",
                                  fit: BoxFit.fill,
                                )
                              : Image.asset(defaultImage),
                        )
                      : Image.asset(
                          "${_campo[index]["image"]}",
                          fit: BoxFit.fill,
                        )
                  : Image.asset(defaultImage),
              color: Colors.blueAccent,
            ),
        onAccept: (data) {
          if (_campo[index]["status"] == false && _campo[index]["linha"] != 9) {
            setState(() {
              print(pBuild);
              String img = pBuild[data]["image"];
              int n = pBuild[data]["size"];
              posicionaBarco(index, n, img);
              print(_campo);
              print(pBuild);
            });
          } else
            msgSnack("Erro ao posicionar Barco, tente novamente");
        });
  }

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

  Widget buildB2(int index, String a, int b) {
    return Draggable<int>(
      child: buildB(a),
      feedback: buildB(a),
      data: index,
    );
  }

  void resetGrid() {
    setState(() {
      _campo = [];
      _laco(linhasColunas, linhasColunas, _addPosition);
    });
  }

  Widget timer() {
    if (seconds < 10) {
      return Text(
        "0$mins : 0$seconds",
        style: TextStyle(color: Colors.white, fontSize: 20),
      );
    } else {
      return Text(
        "0$mins : $seconds",
        style: TextStyle(color: Colors.white, fontSize: 20),
      );
    }
  }

  void startTimer() {
    time = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (mins == 0 && seconds == 0)
          time?.cancel();
        else if (seconds == 0) {
          mins--;
          seconds = maxSeconds;
        } else
          seconds--;
      });
      ;
    });
  }

  void setBarcos(String a, int b) {
    Map<String, dynamic> newBoat = Map();
    newBoat["image"] = a;
    newBoat["size"] = b;

    pBuild.add(newBoat);
    print(pBuild.length);
  }

  void aleatorio() {
    int rndIndex = 0;
    int rndBarco = 0;
    for (int i = 0; i <= maxAlt; i++) {
      rndIndex = random.nextInt(100);
      rndBarco = random.nextInt(3);
      posicionaBarcoAlt(
          rndIndex, pBuild[rndBarco]["size"], pBuild[rndBarco]["image"]);
      print(rndBarco);
      print(pBuild[rndBarco]);
      if (i / 2 == 0)
        _rotation = true;
      else
        _rotation = false;
    }
    maxAlt = 6;
    _rotation = false;
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
            _campo = [];
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
                          height: constraints.maxHeight * 0.5,
                          width: constraints.maxWidth * 0.7,
                          child: LayoutBuilder(builder: (_, constraints2) {
                            return GridView.builder(
                                itemCount: _campo.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisExtent:
                                            constraints2.maxHeight * 0.09,
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
                                onPressed: () {},
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
                      buildB2(0, "images/boat.png", 1),
                      buildB2(1, "images/baco.png", 2),
                      buildB2(2, "images/veio.png", 3),
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
                                builder: (context) => BatlePage(_campo, _campo)));
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
