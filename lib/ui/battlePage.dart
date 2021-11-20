import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../timer.dart';

class BatlePage extends StatefulWidget {
  List _aCampo = [];
  List _mCampo = [];

  BatlePage(this._mCampo, this._aCampo);

  @override
  _BatlePageState createState() => _BatlePageState();
}

class _BatlePageState extends State<BatlePage> {
  List _advCampo = [];
  List _meuCampo = [];
  bool _valid = true;

  List currentUser = [];
  List advUser = [];
  final degress = 90.0;

  @override
  void initState() {
    super.initState();

    _advCampo = widget._aCampo;
    _meuCampo = widget._mCampo;
    setCurrentUser(5649, "Ronaldo (321)", "");
    setAdvUser(5650, "Gabriel (565)", "");

    startTimer();
  }

  void setCurrentUser(int id, String name, String image) {
    setState(() {
      Map<String, dynamic> newUser = Map();
      newUser["id"] = id;
      newUser["name"] = name;
      newUser["image"] = image;

      currentUser.add(newUser);
    });
  }

  void setAdvUser(int id, String name, String image) {
    setState(() {
      Map<String, dynamic> newUser = Map();
      newUser["id"] = id;
      newUser["name"] = name;
      newUser["image"] = image;

      advUser.add(newUser);
    });
  }

  Widget buildFieldMeuCampo(BuildContext context, int index) {
    return Container(
        color: Color(0xff75CCFE),
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

  Widget buildFieldAdvCampo(BuildContext context, int index) {
    return Container(
        color: Color(0xff75CCFE),
        child: _advCampo[index]["status"]
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
            : null);
  }

  Widget buildFakeAdvCampo(BuildContext context, int index) {
    return Visibility(
        visible: !_advCampo[index]["afundou"],
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: GestureDetector(
            onTap: _advCampo[index]["status"]
                ? () {}
                : () {
                    setState(() {
                      _advCampo[index]["afundou"] = true;
                    });
                  },
            child: Container(
              color: Color(0xff75CCFE),
              child: null,
            )));
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff293241),
        title: Text("Batle Page"),
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
                decoration: BoxDecoration(
                    color: Color(0xff293241),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
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
                                TextStyle(color: Colors.white, fontSize: 20)),
                        Divider(),
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 30,
                              color: Colors.green,
                            ),
                            Text("     Brasil",
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
              Container(
                height: constraint.maxHeight * 0.7,
                width: constraint.maxWidth,
                child: LayoutBuilder(
                  builder: (_, constraint2) {
                    return Column(
                      children: [
                        Container(
                          width: constraint2.maxWidth * 0.95,
                          height: constraint2.maxHeight * 0.4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Container(
                                    height: constraint2.maxHeight * 0.6,
                                    width: constraint2.maxWidth * 0.4,
                                    child: GridView.builder(
                                      itemCount: _meuCampo.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisExtent:
                                                  constraint2.maxHeight * 0.035,
                                              mainAxisSpacing:
                                                  constraint2.maxHeight * 0.001,
                                              crossAxisSpacing:
                                                  constraint2.maxHeight * 0.001,
                                              crossAxisCount: 10),
                                      itemBuilder: buildFieldMeuCampo,
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: constraint2.maxHeight * 0.07,
                                      width: constraint2.maxWidth * 0.25,
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text("Aleatório"),
                                          style: ElevatedButton.styleFrom(
                                              primary: Color(0xff3D5A80))),
                                    ),
                                    Container(
                                      height: constraint2.maxHeight * 0.07,
                                      width: constraint2.maxWidth * 0.25,
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text("Configurações"),
                                          style: ElevatedButton.styleFrom(
                                              primary: Color(0xff3D5A80))),
                                    ),
                                    Container(
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
                        Container(
                          width: constraint2.maxWidth,
                          height: constraint2.maxHeight * 0.6,
                          child: LayoutBuilder(
                            builder: (_, constraint3) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    top: 10, right: 20, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: constraint3.maxHeight,
                                          width: constraint3.maxWidth * 0.75,
                                          child: GridView.builder(
                                            itemCount: _advCampo.length,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    mainAxisExtent:
                                                        constraint3.maxHeight *
                                                            0.09,
                                                    mainAxisSpacing:
                                                        constraint3.maxHeight *
                                                            0.004,
                                                    crossAxisSpacing:
                                                        constraint3.maxHeight *
                                                            0.004,
                                                    crossAxisCount: 10),
                                            itemBuilder: buildFieldAdvCampo,
                                          ),
                                        ),
                                        Container(
                                          height: constraint3.maxHeight,
                                          width: constraint3.maxWidth * 0.75,
                                          child: GridView.builder(
                                            itemCount: _advCampo.length,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    mainAxisExtent:
                                                        constraint3.maxHeight *
                                                            0.09,
                                                    mainAxisSpacing:
                                                        constraint3.maxHeight *
                                                            0.004,
                                                    crossAxisSpacing:
                                                        constraint3.maxHeight *
                                                            0.004,
                                                    crossAxisCount: 10),
                                            itemBuilder: buildFakeAdvCampo,
                                          ),
                                        )
                                      ],
                                    )
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
                decoration: BoxDecoration(
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
                                TextStyle(color: Colors.white, fontSize: 20)),
                        Divider(),
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 30,
                              color: Colors.green,
                            ),
                            Text("     Brasil",
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 16))
                          ],
                        ),
                      ],
                    ),
                    Container(
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
