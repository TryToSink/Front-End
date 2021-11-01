import 'package:flutter/material.dart';

class BatlePage extends StatefulWidget {
  List _aCampo = [];
  List _mCampo = [];

  BatlePage(this._aCampo, this._mCampo);

  @override
  _BatlePageState createState() => _BatlePageState();
}

class _BatlePageState extends State<BatlePage> {
  List _advCampo = [];
  List _meuCampo = [];
  bool _valid = true;

  @override
  void initState() {
    super.initState();

    _advCampo = widget._aCampo;
    _meuCampo = widget._mCampo;
  }

  Widget buildFieldMeuCampo(BuildContext context, int index) {
    return Container(
      color: _meuCampo[index]["status"] ? Colors.blueAccent : Colors.black26,
      child: null,
    );
  }

  Widget buildFieldAdvCampo(BuildContext context, int index) {
    return GestureDetector(
        onTap: _valid
            ? () {
                setState(() {
                  _advCampo[index]["status"]
                      ? _advCampo[index]["ataque"] = true
                      : null;
                });
              }
            : null,
        child: Container(
          color: _advCampo[index]["ataque"] ? Colors.red : Colors.blueAccent,
          child: null,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Batle Page"),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (_, constraints) {
          return Padding(
            padding: EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    width: constraints.maxWidth * 0.8,
                    height: constraints.maxHeight * 0.5,
                    child: LayoutBuilder(
                      builder: (_,constraints2){
                        return GridView.builder(
                            itemCount: _advCampo.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: constraints2.maxHeight / 5,
                                mainAxisSpacing: 1,
                                crossAxisSpacing: 1,
                                crossAxisCount: 5),
                            itemBuilder: buildFieldAdvCampo);
                      },
                    )
                ),
                Container(
                  width: constraints.maxWidth ,
                  height: constraints.maxHeight * 0.10,
                  color: Colors.red,
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  width: constraints.maxWidth * 0.7,
                  height: constraints.maxHeight * 0.3,
                  child: LayoutBuilder(
                    builder: (_,constraints3){
                      return  GridView.builder(
                          itemCount: _meuCampo.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: constraints3.maxHeight / 6,
                              mainAxisSpacing: 1,
                              crossAxisSpacing: 1,
                              crossAxisCount: 5),
                          itemBuilder: buildFieldMeuCampo
                      );
                    },
                  ),
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}
