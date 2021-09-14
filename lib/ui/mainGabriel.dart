import 'dart:convert';
import 'dart:io';


import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


class Home_Gabriel extends StatefulWidget {
  const Home_Gabriel({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home_Gabriel> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _pwdController = TextEditingController();

  List _userList = [];
  late Map<String, dynamic> _lastRemoved;
  late int _lastRemovedPos;


  @override
  void initState() {
    super.initState();

    _readData().then((data){
      setState(() {
        _userList = json.decode(data!);
      });
    });
  }

  void _addUser() {
    setState(() {
      Map<String, dynamic> newUser = Map();
      newUser["name"] = _nameController.text;
      newUser["pwd"] = _pwdController.text;
      _nameController.text = "";
      _pwdController.text = "";
      newUser["ride"] = false;

      _userList.add(newUser);

      _saveData();
    });
  }

  String _pwdRide(String s){
    int n = s.length;
    String pwd ="";
    for(int i = 0; i<n;i++){
      pwd += "*";
    }
    return pwd;
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(milliseconds: 700));
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Listar Usuários"),
          backgroundColor: Colors.deepOrangeAccent,
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
                child: Row(
                  children: <Widget>[
                    Expanded(child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _nameController,
                      decoration: InputDecoration(
                          labelText: "Nome",
                          labelStyle: TextStyle(
                            color: Colors.deepOrangeAccent,
                          )
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Insira seu nome!";
                        }
                      },
                    )),
                    SizedBox(width: 10,),
                    Expanded(child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _pwdController,
                      decoration: InputDecoration(
                          labelText: "Senha",
                          labelStyle: TextStyle(
                            color: Colors.deepOrangeAccent,
                          )
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Insira sua Senha!";
                        }
                      },
                    )),
                    RaisedButton(
                      color: Colors.deepOrangeAccent,
                      child: FittedBox(child: Icon((Icons.person_add),) ,),
                      textColor: Colors.white,
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          _addUser();
                        }
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.only(top: 10.0),
                      itemCount: _userList.length,
                      itemBuilder: buildItem))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home_Gabriel()));
          },
          tooltip: 'Next Page',
          child: const Icon(Icons.navigate_next),
          backgroundColor: Colors.deepOrangeAccent,
        )
    );
  }

  Widget buildItem(BuildContext context, int index){
    String s = _userList[index]["pwd"];
    String ss = _pwdRide(s);
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(Icons.delete, color: Colors.white,),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(_userList[index]["name"]),
        subtitle: Text(_userList[index]["ride"] ? s:ss),
        value: _userList[index]["ride"],
        onChanged: (c){
          setState(() {
            _userList[index]["ride"] = c;
            _saveData();
          });
        },
      ),
      onDismissed: (direction){
        setState(() {
          _lastRemoved = Map.from(_userList[index]);
          _lastRemovedPos = index;
          _userList.removeAt(index);

          _saveData();

          final snack = SnackBar(
            content: Text("Usuário \"${_lastRemoved["name"]}\" removido!"),
            action: SnackBarAction(label: "Desfazer",
                onPressed: () {
                  setState(() {
                    _userList.insert(_lastRemovedPos, _lastRemoved);
                    _saveData();
                  });
                }),
            duration: Duration(seconds: 2),
          );

          Scaffold.of(context).removeCurrentSnackBar();
          Scaffold.of(context).showSnackBar(snack);

        });
      },
    );
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_userList);

    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String?> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }


}