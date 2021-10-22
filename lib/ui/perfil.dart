import 'package:flutter/material.dart';
import 'package:testeteste30_09/home.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  _MyPerfilPage createState() => _MyPerfilPage();
}

class _MyPerfilPage extends State<PerfilPage> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '',
        theme: ThemeData(
//        brightness: Brightness.dark,
          primaryColor: Colors.blueGrey[400],
        ),
        home: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("PERFIL PAGE"),
          ),
          body: Center(
              child: RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Retornar !'))),
        ));
  }
}
