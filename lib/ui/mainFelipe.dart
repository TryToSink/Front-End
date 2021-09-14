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
        body: CreateList(),
      ),
    );
  }
}

class CreateList extends StatefulWidget {
  final List<User> _user = [];

  @override
  _CreateListState createState() => _CreateListState();
}

class _CreateListState extends State<CreateList> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pswdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Formulário'), backgroundColor: Colors.blue[900]),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 160,
                    child: Padding(
                      padding: EdgeInsets.only(right: 5.0),
                      child: TextField(
                        controller: _nameController,
                        style: TextStyle(fontSize: 16.0),
                        decoration: InputDecoration(labelText: 'Nome'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 160,
                    child: Padding(
                      padding: EdgeInsets.only(right: 5.0),
                      child: TextField(
                          controller: _pswdController,
                          style: TextStyle(fontSize: 16.0),
                          decoration: InputDecoration(labelText: 'Senha'),
                          keyboardType: TextInputType.number),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: Icon(Icons.add_circle_outline),
                      onPressed: () => _addUser(context),
                    ),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget._user.length,
                itemBuilder: (context, index) {
                  final user = widget._user[index];
                  return NewUser(user);
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            tooltip: "Próxima página",
            backgroundColor: Colors.blue[900],
            child: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home_Gabriel()));
            }));
  }

  void _addUser(BuildContext context) {
    final String name = (_nameController.text);
    final int? pswd = int.tryParse(_pswdController.text);
    if (name != null && pswd != null) {
      setState(() {
        final newUser = User(name, pswd);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Usuário{nome: $name, pswd: $pswd}'),
          ),
        );
        widget._user.add(newUser);
      });
      _nameController.text = '';
      _pswdController.text = '';

    }
  }
}

class NewUser extends StatelessWidget {
  final User _user;

  NewUser(this._user);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          leading: Icon(Icons.account_box_outlined, color: Colors.grey),
          title: Text(this._user.name.toString()),
          subtitle: Text(this._user.pswd.toString())),
    );
  }
}

class User {
  final String name;
  final int pswd;

  User(this.name, this.pswd);

  @override
  String toString() {
    return 'Usuário{nome: $name, pswd: $pswd';
  }
}
