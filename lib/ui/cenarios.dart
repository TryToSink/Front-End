// @dart=2.9
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proj0511/ui/loadgame.dart';

import 'cenariosclass.dart';

// ignore: must_be_immutable
class LoadCenario extends StatefulWidget {
  String idmodojogo;
  String idUser;
  LoadCenario({Key key, this.idmodojogo, this.idUser}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<LoadCenario> createState() =>
      _LoadCenarioState(idmodojogo: idmodojogo, idUser: idUser);
}

class _LoadCenarioState extends State<LoadCenario> {
  String idCenario;
  String idmodojogo;
  String idUser;
  _LoadCenarioState({this.idmodojogo, this.idUser});
  String url2 = 'http://3.144.90.4:3333/modoJogo/find';
  PostDart returno;
  List<Cenarios> _returno2 = [];
  List<String> _arraydeCenarios = [];
  List<String> _arraydeFotos = [];
  String fotoAtual;
  int i = 0;
  int a = 0;

  void getTest2() async {
    try {
      final response =
          await http.get(Uri.parse(url2 + '?idModoJogo=' + idmodojogo));
      setState(() {
        final PostDart returno = PostDart.fromJson(json.decode(response.body));
        final List<Cenarios> _returno2 = returno.cenarios;
        for (int i = 0; _returno2.length > i; i++) {
          _arraydeCenarios.add(_returno2[i].nome);
          _arraydeFotos.add(_returno2[i].foto);
          print(_arraydeFotos[i]);
        }
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    getTest2();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blueGrey[900],
        ),
        home: Scaffold(
          appBar: AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            backgroundColor: Colors.blueGrey[900],
            actionsIconTheme:
                const IconThemeData(size: 30.0, color: Colors.white),
            title: const Center(
              child: (Text('Escolha um Cenário')),
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
                      color: Colors.grey[350],
                      child: Stack(
                        children: [
                          Column(children: [
                            Container(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight,
                              color: Colors.grey[350],
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 1,
                                              childAspectRatio: 1.5),
                                      itemCount: _arraydeCenarios.length,
                                      itemBuilder: (context, index) {
                                        print('http://3.144.90.4:3333/files/' +
                                            _arraydeFotos[index]);
                                        return SizedBox(
                                            width: constraints.maxWidth * .90,
                                            height: constraints.maxHeight * .40,
                                            child: SizedBox(
                                                width:
                                                    constraints.maxWidth * .90,
                                                height:
                                                    constraints.maxHeight * .40,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.network(
                                                      'http://3.144.90.4:3333/files/' +
                                                          _arraydeFotos[index],
                                                      height: constraints
                                                              .maxHeight *
                                                          .30,
                                                      width:
                                                          constraints.maxWidth *
                                                              .40,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          constraints.maxWidth *
                                                              .40,
                                                      height: constraints
                                                              .maxHeight *
                                                          .30,
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
                                                              _arraydeCenarios[
                                                                  index],
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black),
                                                              softWrap: true,
                                                            ),
                                                          ],
                                                        ),
                                                        onPressed: () {
                                                          _arraydeCenarios[
                                                                  index] =
                                                              idCenario;
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => LoadTela(
                                                                      idCenario:
                                                                          'idCenario',
                                                                      idUser:
                                                                          'idUser')));
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
                  ]);
            }),
          ),
        ));
  }
}
