import 'package:flutter/material.dart';
import 'package:front_main/ui/mainGabriel.dart';

void main() {
  runApp(MaterialApp(
    home: HomeMain()
  ));
}

class HomeMain extends StatefulWidget {
  const HomeMain({Key? key}) : super(key: key);

  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela Principal"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(child:Text("Avance para próxima tela"),),
      floatingActionButton:  FloatingActionButton(
        tooltip: "Next Page",
        backgroundColor: Colors.blue,
        child: const Icon(Icons.navigate_next),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Home_Gabriel())

          );
        },
      ),
    );
  }
}


