// @dart=2.9
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proj0511/ui/socketConnect%20(1).dart';

import 'cenariosclass.dart';

class LoadTela extends StatefulWidget {
  String idCenario;
  String idUser;
  LoadTela({Key key, this.idCenario, this.idUser}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<LoadTela> createState() =>
      _LoadCenarioState(idCenario: idCenario, idUser: idUser);
}

class _LoadCenarioState extends State<LoadTela> {
  String idCenario;
  String idUser;
  _LoadCenarioState({Key key, this.idCenario, this.idUser});

  @override
  void initState() {
    super.initState();
    socketConnect().partidaAleatoria(idCenario, idUser);
    socketConnect()
        .partidaAleatoria(idCenario, '04be7cad-70aa-4921-98da-3b3c2b806b61');
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              backgroundColor: Colors.blueGrey[900],
              actionsIconTheme:
                  const IconThemeData(size: 30.0, color: Colors.white),
              title: const Center(
                child: (Text('LOADING')),
              ),
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
                            height: constraints.maxHeight,
                            color: Colors.white,
                            child: Stack(children: [
                              Container(
                                  width: constraints.maxWidth,
                                  height: constraints.maxHeight,
                                  color: Colors.white,
                                  child: Column(children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                                    ),
                                    Container(
                                        width: constraints.maxWidth * .90,
                                        height: constraints.maxHeight * .50,
                                        //color: Colors.black,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                            color: Colors.white,
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  'assets/espera.png'),
                                              fit: BoxFit.cover,
                                            ))),
                                    Container(
                                      width: constraints.maxWidth * .90,
                                      height: constraints.maxHeight * .15,
                                      color: Colors.white,
                                      child: Center(
                                          child: Text(
                                        'Procurando  Oponente',
                                        style: const TextStyle(
                                          fontSize: 30,
                                          color: Colors.black,
                                        ),
                                        softWrap: true,
                                      )),
                                    ),
                                    Container(
                                      width: constraints.maxWidth * .70,
                                      height: constraints.maxHeight * .10,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            //maximumSize: size,
                                            fixedSize: size,
                                            backgroundColor: Color(0xFF3D5AB0),
                                            elevation: 15,
                                            shadowColor: Colors.grey),
                                        child: Text(
                                          'Desistir',
                                          style: const TextStyle(
                                              fontSize: 30,
                                              color: Colors.white),
                                          softWrap: true,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    )
                                  ]))
                            ]))
                      ]);
                }))));
  }
}
