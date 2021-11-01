import 'package:flutter/material.dart';
import 'package:front_main/ui/battlePage.dart';



class PositionBoat extends StatefulWidget {
  const PositionBoat({Key? key}) : super(key: key);

  @override
  _PositionBoatState createState() => _PositionBoatState();
}

class _PositionBoatState extends State<PositionBoat> {
  final linhasColunas = 5;
  List _campo = [];
  bool _valid = true;
  int _count = 0;
  List _ultPos = [];
  int _tamanho =0;
  late Map<String, dynamic> _lastSelected;

  void _addPosition(int x, int y) {
    setState(() {
      Map<String, dynamic> newPos = Map();
      newPos["linha"] = x;
      newPos["coluna"] = y;
      newPos["status"] = false;
      newPos["ataque"] = false;

      _campo.add(newPos);
    });
  }

  void _laco(int x, int y, var func) {
    for (int i = 0; i < x; i++) {
      for (int j = 0; j < y; j++) {
        func(i, j);
      }
    }
  }

  bool? posValida(int x, int y) {
    if (_ultPos[0] == null) return true;

    int l = _ultPos[0];
    int c = _ultPos[1];
    if (x != l && y != c)
      return false;
    else
      return true;
  }

  @override
  void initState() {
    super.initState();

    _laco(linhasColunas, linhasColunas, _addPosition);
  }


  Widget buildField(BuildContext context, int index) {
    return GestureDetector(
        onTap: _valid
            ? () {
          setState(() {
            if (_count > 0 ) {
              _count--;
              _campo[index]["status"] = true;
              print(_campo);
            } else
              _valid = false;
          });
        }
            : null,
        onDoubleTap: () {
          setState(() {
            _campo[index]["status"] = false;
            _count ++;
          });
        },
        child: Container(
          color: _campo[index]["status"] ? Colors.blueAccent : Colors.black26,
          child: null,
        ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Batalha Naval, building tab"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: LayoutBuilder(
        builder: (_,constraints){
          return Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _count = 2;
                              _valid = true;
                              print(_count);
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          child: Text("2"))),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _count = 3;
                              _valid = true;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          child: Text("3"))),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _count = 4;
                              _valid = true;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          child: Text("4")))
                ],
              ),
            ),
            Expanded(
                child: GridView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: _campo.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: constraints.maxWidth * 0.1,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                        crossAxisCount: linhasColunas),
                    itemBuilder: buildField))
          ]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder:
                  (context) => BatlePage(_campo,_campo)
              ));
        },
        tooltip: 'Increment Counter',
        child: const Icon(Icons.save),
      ),
    );
  }
}