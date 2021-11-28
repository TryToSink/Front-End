// @dart=2.9
import 'dart:convert';
import 'package:flutter/material.dart';
import 'cenariosclass.dart';
import 'loadgame.dart';
import 'package:http/http.dart' as http;

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
          primaryColor: Color(0xFF293241),
        ),
        home: Scaffold(
          backgroundColor: Color(0xFFDDDDDD),
          appBar: AppBar(
            centerTitle: true,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            toolbarHeight: 100,
            title: const Text('ESCOLHA UM CENÁRIO'),
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back)),
            backgroundColor: Color(0xFF293241),
          ),
          body: Container(
            width: size.width,
            height: size.height,
            color: Color(0xFFDDDDDD),
            child: LayoutBuilder(builder: (_, constraints) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      color: Color(0xFFDDDDDD),
                      child: Stack(
                        children: [
                          Column(children: [
                            Container(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight,
                              color: Color(0xFFDDDDDD),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 1,
                                              childAspectRatio: 2.5),
                                      itemCount: _arraydeCenarios.length,
                                      itemBuilder: (context, index) {
                                        return SizedBox(
                                            width: constraints.maxWidth * .90,
                                            height: constraints.maxHeight * .20,
                                            child: SizedBox(
                                                width:
                                                    constraints.maxWidth * .90,
                                                height:
                                                    constraints.maxHeight * .20,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.network(
                                                      'http://3.144.90.4:3333/files/' +
                                                          _arraydeFotos[index],
                                                      height: constraints
                                                              .maxHeight *
                                                          .20,
                                                      width:
                                                          constraints.maxWidth *
                                                              .45,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          constraints.maxWidth *
                                                              .45,
                                                      height: constraints
                                                              .maxHeight *
                                                          .20,
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
                                                          idCenario =
                                                              _arraydeCenarios[
                                                                  index];
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => LoadTela(
                                                                      idCenario:
                                                                          idCenario,
                                                                      idUser:
                                                                          idUser)));
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
