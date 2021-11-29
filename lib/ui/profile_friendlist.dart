// ignore_for_file: avoid_print, prefer_final_fields, unused_field, unused_element, no_logic_in_create_state, must_be_immutable, unused_import, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FriendsList extends StatefulWidget {
  late String idUser;
  FriendsList({Key? key, required this.idUser}) : super(key: key);

  @override
  _FriendsListState createState() => _FriendsListState(idUser: idUser);
}

class _FriendsListState extends State<FriendsList> {
  late String idUser;

  _FriendsListState({Key? key, required this.idUser});
  late String _username = '';
  late List _amigos = [];
  late List _usernameAmigo = [];

  late String urlProfile = 'http://201.42.59.203:3333/usuarios/find';
  late String urlFriends = 'http://201.42.59.203:3333/usuarios/amigosOnline';

  @override
  void initState() {
    super.initState();
    print('Entrou no initstate');
    getUser();
  }

  getUser() async {
    print('object');
    print(urlProfile + "?id=" + idUser);
    try {
      final response = await http.get(
        Uri.parse(urlProfile + "?id=" + idUser),
      );
      print('BODY: ' + response.body);

      final jsonData = jsonDecode(response.body) as Map;
      print('JSONDATA:' + jsonData.toString());
      setState(() {
        _username = jsonData['username'];
        _amigos = jsonData['amigos'];

        print('amigos: ' + _amigos.toString());
        for (int i = 0; i <= jsonData['amigos'].length; i++) {
          _amigos[i] = jsonData['amigos'][i];
          _usernameAmigo[i] = jsonData['amigos'][i]['name'];
        }
        print('amigo[0]: ' + _amigos[0]);
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    const appBarBGColor = Color(0xFF293241);
    const textColor = Color(0xFF3D5A80);
    const bGColor = Color(0xFFDDDDDD);

    return Scaffold(
      backgroundColor: bGColor,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: appBarBGColor,
        title: const Text("Amigos"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _amigos.length,
        itemBuilder: (BuildContext context, int index) {
          print(_amigos.isEmpty);
          return _amigos.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'sleepy_pirate.png',
                        height: 100,
                        width: 100,
                      ),
                      const Text(
                        'Tá meio vazio por aqui!',
                        style: TextStyle(color: textColor),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(
                      top: 16, bottom: 16, left: 16, right: 16),
                  child: Container(
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 0.5,
                            spreadRadius: 0.5,
                            offset: Offset(1.5, 1.5))
                      ],
                    ),
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 65,
                            width: 65,
                            child: Image.asset('assets/empty-person.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              _amigos[index]['name'],
                              style: const TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Spacer(
                            flex: 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 24.0),
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: Image.asset('assets/green-dot.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
