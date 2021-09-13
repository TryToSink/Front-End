import 'package:flutter/material.dart';
import 'mainGabriel.dart';

void main() {
  runApp(PageApp());
}

class PageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: NewPage(),
      ),
    );
  }
}

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Formulário'), backgroundColor: Colors.blue[900]),
      body: Column(
        children: <Widget>[
          Text('Pressione o botão para acessar a próxima página'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Próxima página",
        backgroundColor: Colors.blue[900],
        child: Icon(Icons.arrow_forward_ios),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Home_Gabriel()));
        }
      )
    );
  }
}
