// @dart=2.9
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'cenariosclass.dart';

class LoadTela extends StatefulWidget {
  LoadTela({Key key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<LoadTela> createState() => _LoadCenarioState();
}

class _LoadCenarioState extends State<LoadTela> {
  //void getTest() async {
  //  try {
  //    final response = await http.get(Uri.parse(url));
  //    final jsonData = jsonDecode(response.body) as List;
  //    setState(() {
  //      _lista = jsonData;
  //    });
  //  } catch (error) {}
  //  ;
  //}

  //void getTest2() async {
  //  try {
  //    final response =
  //        await http.get(Uri.parse(url2 + '?idModoJogo=' + idmodojogo));
  //    setState(() {
  //      final PostDart returno = PostDart.fromJson(json.decode(response.body));
  //      final List<Cenarios> _returno2 = returno.cenarios;
  //      print(returno.cenarios.length);
  //      for (int i = 0; _returno2.length > i; i++) {
  //        _arraydeCenarios.add(_returno2[i].nome);
  //        print(_arraydeCenarios[i]);
  //        //if (_returno2[i].nome != _nomeCenarios) {
  //        //  _nomeCenarios = _returno2[i].nome;
  //        //} else if (_returno2[i].nome == _nomeCenarios2) {
  //         //  _nomeCenarios2 = _returno2[i].nome;
  //        //} else {
  //  _nomeCenarios3 = _returno2[i].nome;
  //        // }
  //      }
  //for (int j = 0; _returno2.length > j; j++){
  //  if (_lista[j].isEmpty){
  //    _lista[j]=_nomeCenarios;
  //  }
  //}
  //    });
  //  } catch (error) {
  //    print('ta errado, isso ai');
  //  }
//
  //  print('é treta');
  //}

  //@override
  //void initState() {
  //  super.initState();
  //  getTest2();
  //}

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
                            color: Colors.grey[350],
                            child: Stack(children: [
                              Container(
                                  width: constraints.maxWidth,
                                  height: constraints.maxHeight,
                                  color: Colors.grey[350],
                                  child: Column(children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                                    ),
                                    Container(
                                        width: constraints.maxWidth * .80,
                                        height: constraints.maxHeight * .60,
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
                                                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                                              fit: BoxFit.cover,
                                            ))),
                                    Container(
                                      width: constraints.maxWidth * .90,
                                      height: constraints.maxHeight * .15,
                                      color: Colors.grey[350],
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
