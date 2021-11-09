
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:front_main/ui/battlePage.dart';

class PositionBoat extends StatefulWidget {
  const PositionBoat({Key? key}) : super(key: key);

  @override
  _PositionBoatState createState() => _PositionBoatState();
}

class _PositionBoatState extends State<PositionBoat> {
  final linhasColunas = 8;
  List _campo = [];
  bool _rotation = false;
  bool _rotationImage = false;
  List _ultPos = [];
  List pBuild = [];
  Color buttonColor = Colors.blueAccent;
  final degress = 90.0;
  String defaultImage = "images/water.png";

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

  bool? posValida(int x, int y) {
    if (_ultPos[0] == null) return true;

    int l = _ultPos[0];
    int c = _ultPos[1];
    if (x != l && y != c)
      return false;
    else
      return true;
  }

  @override
  void initState() {
    super.initState();

    _laco(linhasColunas, linhasColunas, _addPosition);
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
      onAccept: _rotation
          ? (data) {
              setState(() {
                print(pBuild);
                String img = pBuild[data]["image"];
                String imgUse = img.substring(0, 11);
                int n = pBuild[data]["size"];
                for (int i = 0; i <= n; i++) {
                  _campo[index + i * 8]["image"] =
                      imgUse + i.toString() + ".png";
                  _campo[index + i * 8]["status"] = true;
                  _campo[index + i * 8]["rotacao"] = true;
                }

                print(_campo);
                pBuild = [];
              });
            }
          : (data) {
              setState(() {
                print(pBuild);
                String img = pBuild[data]["image"];
                String imgUse = img.substring(0, 11);
                int n = pBuild[data]["size"];
                for (int i = 0; i <= n; i++) {
                  _campo[index + i]["image"] = imgUse + i.toString() + ".png";
                  _campo[index + i]["status"] = true;
                }

                pBuild = [];
                print(_campo);
              });
            },
    );
  }

  Widget buildB(String a) {
    return Container(
      height: 50,
      width: 90,
      color: Colors.blueAccent,
      alignment: Alignment.center,
      child: Image.asset(
        a,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildB2(int index, String a, int b) {
    Map<String, dynamic> newBoat = Map();
    newBoat["image"] = a;
    newBoat["size"] = b;

    pBuild.add(newBoat);
    print(pBuild.length);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Batalha Naval, building tab"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: LayoutBuilder(
        builder: (_, constraints) {
          return Column(children: <Widget>[
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
                  ),
                  IconButton(onPressed: resetGrid,
                      icon: Icon(Icons.delete_rounded))
                ],
              ),
            ),
            Container(
                height: constraints.maxHeight * 0.7,
                width: constraints.maxWidth * 0.9,
                child: LayoutBuilder(builder: (_, constraints2) {
                  return GridView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: _campo.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: constraints2.maxWidth * 0.08,
                          mainAxisSpacing: constraints2.maxHeight * 0.001,
                          crossAxisSpacing: constraints2.maxWidth * 0.001,
                          crossAxisCount: linhasColunas),
                      itemBuilder: buildTargets);
                }))
          ]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BatlePage(_campo, _campo)));
        },
        tooltip: 'Increment Counter',
        child: const Icon(Icons.save),
      ),
    );
  }
}
