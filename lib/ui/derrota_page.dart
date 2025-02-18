import 'package:flutter/material.dart';
import 'home.dart';

class Derrota extends StatefulWidget {
  Derrota({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<Derrota> createState() => _DerrotaState();
}

class _DerrotaState extends State<Derrota> {
  void AlteraTela() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      color: Color(0xFFDDDDDD),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Color(0xFFDDDDDD),
        primaryColor: Color(0xFFDDDDDD),
      ),
      home: Scaffold(
        backgroundColor: Color(0xFFDDDDDD),
        appBar: AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            backgroundColor: Color(0xFF293241),
            toolbarHeight: 100,
            actionsIconTheme:
                const IconThemeData(size: 30.0, color: Color(0xFFDDDDDD)),
            title: Row(mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'DERROTA',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.red),
                  )
                ])),
        body: Container(
          width: size.width,
          height: size.height,
          color: Colors.grey[350],
          child: LayoutBuilder(
            builder: (_, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Image.asset('assets/derrota.png'),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 10)),
                  Center(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: constraints.maxWidth * .11,
                        ),
                        Container(
                          width: constraints.maxWidth * .23,
                          height: constraints.maxHeight * .15,
                          child: RaisedButton(
                            color: Colors.white,
                            onPressed: () {},
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("300",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.black)),
                                Text("Rating atual",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black))
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        Container(
                          width: constraints.maxWidth * .05,
                          height: constraints.maxHeight * .05,
                        ),
                        Container(
                          width: constraints.maxWidth * .23,
                          height: constraints.maxHeight * .15,
                          child: RaisedButton(
                            color: Colors.white,
                            onPressed: () {},
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("-10",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.black)),
                                Text("Ranting perdido",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black))
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        Container(
                          width: constraints.maxWidth * .05,
                          height: constraints.maxHeight * .05,
                        ),
                        Container(
                          width: constraints.maxWidth * .23,
                          height: constraints.maxHeight * .15,
                          child: RaisedButton(
                            color: Colors.white,
                            onPressed: () {},
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("30%",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.black)),
                                Text("Taxa de acerto",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black))
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 05, 0, 50)),
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
                        'OK',
                        style:
                            const TextStyle(fontSize: 25, color: Colors.white),
                        softWrap: true,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                      idUser: '',
                                    )));
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
