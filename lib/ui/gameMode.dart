import 'package:flutter/material.dart';
import 'package:front_main/ui/queue.dart';

class GameMode extends StatefulWidget {
  const GameMode({Key? key}) : super(key: key);

  @override
  _GameModeState createState() => _GameModeState();
}

class _GameModeState extends State<GameMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modo deJogo"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Selecione o modo de Jogo"),
            RaisedButton(
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QueuePage()));
              },
              child: Text("Jogar"),
            )
          ],
        ),
      )
    );
  }
}
