import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:proj0511/posicao.dart';

import '../timer.dart';

class BatlePage extends StatefulWidget {
  List _aCampo = [];
  List _mCampo = [];

  BatlePage(this._mCampo, this._aCampo);

  @override
  _BatlePageState createState() => _BatlePageState();
}

class _BatlePageState extends State<BatlePage> {
  // declaracao das variaveis
  List _advCampo = [];
  List _meuCampo = [];

  //  vvvvvvvvv Controle do grid
  bool _valid = true;

  List currentUser = [];
  List advUser = [];
  final degress = 90.0;
  double gridSize = 0.0;
  double linhaColuna = 0;

  //inicio da pagina

  @override
  void initState() {
    super.initState();

    _advCampo = widget._aCampo;
    _meuCampo = widget._mCampo;

    setCurrentUser(5649, "Ronaldo (321)", "");
    setAdvUser(5650, "Gabriel (565)", "");

    if (sqrt(_advCampo.length) == 8)
      gridSize = 0.10;
    else if (sqrt(_advCampo.length) == 10)
      gridSize = 0.08;
    else
      gridSize = 0.06;
    linhaColuna = sqrt(_advCampo.length);
    startTimer();
  }

  //auxiliar para usuário
  void setCurrentUser(int id, String name, String image) {
    setState(() {
      Map<String, dynamic> newUser = Map();
      newUser["id"] = id;
      newUser["name"] = name;
      newUser["image"] = image;

      currentUser.add(newUser);
    });
  }

  //auxiliar para usuário
  void setAdvUser(int id, String name, String image) {
    setState(() {
      Map<String, dynamic> newUser = Map();
      newUser["id"] = id;
      newUser["name"] = name;
      newUser["image"] = image;

      advUser.add(newUser);
    });
  }

  // montar grid usuario
  Widget buildFieldMeuCampo(BuildContext context, int index) {
    return Container(
        color: const Color(0xff75CCFE),
        child: _meuCampo[index]["status"]
            ? _meuCampo[index]["rotacao"]
                ? Transform.rotate(
                    angle: degress * pi / 180,
                    child: Image.asset(
                      "${_meuCampo[index]["image"]}",
                      fit: BoxFit.fill,
                    ),
                  )
                : Image.asset(
                    "${_meuCampo[index]["image"]}",
                    fit: BoxFit.fill,
                  )
            : null);
  }

  // montar grid de ataque
  Widget buildFieldAdvCampo(BuildContext context, int index) {
    return GestureDetector(
      onTap: _valid
          ? () {
              setState(() {
                _advCampo[index]["ataque"] = true;
                _advCampo[index]["image"] = "assets/fire.png";
              });
            }
          : null,
      child: Container(
          color: const Color(0xff75CCFE),
          child: _advCampo[index]["ataque"]
              ? _advCampo[index]["rotacao"]
                  ? Transform.rotate(
                      angle: degress * pi / 180,
                      child: Image.asset(
                        "${_advCampo[index]["image"]}",
                        fit: BoxFit.fill,
                      ),
                    )
                  : Image.asset(
                      "${_advCampo[index]["image"]}",
                      fit: BoxFit.fill,
                    )
              : null),
    );
  }

  //cronometro
  void startTimer() {
    time = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (mins == 0 && seconds == 0)
          time?.cancel();
        else if (seconds == 0) {
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
        backgroundColor: const Color(0xff293241),
        title: const Text("Batle Page"),
        centerTitle: true,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (_, constraint) {
          return Column(
            children: [
              Container(
                height: constraint.maxHeight * 0.15,
                width: constraint.maxWidth,
                decoration: const BoxDecoration(
                    color: Color(0xff293241),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: constraint.maxHeight * 0.1,
                      width: constraint.maxWidth * 0.1,
                      color: Colors.black,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${advUser[0]["name"]}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        const Divider(),
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 30,
                              color: Colors.green,
                            ),
                            const VerticalDivider(),
                            const Text("Brasil",
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 16))
                          ],
                        )
                      ],
                    ),
                    timer()
                  ],
                ),
              ),
              SizedBox(
                height: constraint.maxHeight * 0.7,
                width: constraint.maxWidth,
                child: LayoutBuilder(
                  builder: (_, constraint2) {
                    return Column(
                      children: [
                        SizedBox(
                          width: constraint2.maxWidth * 0.95,
                          height: constraint2.maxHeight * 0.4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: SizedBox(
                                    height: constraint2.maxHeight * 0.6,
                                    width: constraint2.maxWidth * 0.4,
                                    child: GridView.builder(
                                      itemCount: _meuCampo.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisExtent:
                                                  constraint2.maxHeight *
                                                      (gridSize / 2.7),
                                              mainAxisSpacing:
                                                  constraint2.maxHeight * 0.003,
                                              crossAxisSpacing:
                                                  constraint2.maxHeight * 0.003,
                                              crossAxisCount:
                                                  linhaColuna.toInt()),
                                      itemBuilder: buildFieldMeuCampo,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      height: constraint2.maxHeight * 0.07,
                                      width: constraint2.maxWidth * 0.25,
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text("Aleatório"),
                                          style: ElevatedButton.styleFrom(
                                              primary: Color(0xff3D5A80))),
                                    ),
                                    SizedBox(
                                      height: constraint2.maxHeight * 0.07,
                                      width: constraint2.maxWidth * 0.25,
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text("Configurações"),
                                          style: ElevatedButton.styleFrom(
                                              primary: Color(0xff3D5A80))),
                                    ),
                                    SizedBox(
                                      height: constraint2.maxHeight * 0.07,
                                      width: constraint2.maxWidth * 0.25,
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text("Desistir"),
                                          style: ElevatedButton.styleFrom(
                                              primary: Color(0xff3D5A80))),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: constraint2.maxWidth,
                          height: constraint2.maxHeight * 0.6,
                          child: LayoutBuilder(
                            builder: (_, constraint3) {
                              return Padding(
                                padding: const  EdgeInsets.only(
                                    top: 10, right: 20, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: constraint3.maxHeight,
                                      width: constraint3.maxWidth * 0.75,
                                      child: GridView.builder(
                                        itemCount: _advCampo.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisExtent:
                                                    constraint3.maxHeight *
                                                        gridSize,
                                                mainAxisSpacing: constraint3
                                                        .maxHeight *
                                                    0.005,
                                                crossAxisSpacing:
                                                    constraint3.maxHeight *
                                                        0.005,
                                                crossAxisCount:
                                                    linhaColuna.toInt()),
                                        itemBuilder: buildFieldAdvCampo,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              Container(
                height: constraint.maxHeight * 0.15,
                width: constraint.maxWidth,
                decoration: const BoxDecoration(
                    color: Color(0xff293241),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: constraint.maxHeight * 0.1,
                      width: constraint.maxHeight * 0.1,
                      color: Colors.black,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${advUser[0]["name"]}",
                            style:
                            const TextStyle(color: Colors.white, fontSize: 20)),
                        const Divider(),
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 30,
                              color: Colors.green,
                            ),
                            const VerticalDivider(),
                            const Text("Brasil",
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 16))
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 45,
                      width: 45,
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
