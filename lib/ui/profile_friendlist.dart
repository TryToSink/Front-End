// ignore_for_file: avoid_print, prefer_final_fields, unused_field, unused_element, no_logic_in_create_state, must_be_immutable, unused_import, unused_local_variable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proj0511/ui/home.dart';
import 'package:proj0511/ui/profile_friendlist.dart';
import 'package:proj0511/ui/profile_page.dart';
import 'package:proj0511/ui/profile_page_edit.dart';
import '../rotas.dart';

class FriendsList extends StatefulWidget {
  late String idUser;
  FriendsList({Key? key, required this.idUser}) : super(key: key);

  @override
  _FriendsListState createState() => _FriendsListState(idUser: idUser);
}

class _FriendsListState extends State<FriendsList> {
  late String idUser;

  _FriendsListState({Key? key, required this.idUser});

  late String? imageName = 'null';
  late String _username = '';
  late List _amigos = [];
  late List _usernameAmigo = [];
  late Map _amigosMap = {};
  late List _fotoAmigo = [];

  late String urlProfile = url1 + '/usuarios/find';
  late String urlPhoto = url1 + '/files/' + imageName!;
  late String urlFriends = url1 + '/usuarios/amigosOnline';
  late String urlAddFriends = url1 + '/usuarios/adicionaAmigo';
  late String urlUpdate = url1 + '/usuarios';
  late String urlHistorico = url1 + '/usuarios/historico';

  @override
  void initState() {
    super.initState();
    print('Entrou no initstate ' + idUser);
    getUser();
  }

  getFotoLink(imageName) {
    print('URL: ' + url1 + '/files/' + imageName!);
    return url1 + '/files/' + imageName!;
  }

  getUser() async {
    try {
      final response = await http.get(
        Uri.parse(urlProfile + "?id=" + idUser),
      );

      var jsonData = await jsonDecode(response.body);
      setState(() {
        _username = jsonData['username'];
        _amigos = jsonData['amigos'];
        imageName = jsonData['foto'];
        imageName ??= 'null';
        for (var element in _amigosMap.entries) {
          _amigos.add(element);
        }
        int counter = (_amigos.length.toInt());
        for (var i = 0; i < counter; i++) {
          if (_amigos[i]['foto'] == null) {
            _amigos[i]['foto'] = 'null';
          }
          _usernameAmigo.add(_amigos[i]['name']);
          _fotoAmigo.add(_amigos[i]['foto']);
        }
        print('AMIGOS: ' + _amigos.length.toString());
      });
    } catch (error) {
      print(error);
    }
  }

  buildList(nAmigo, textColor, index) {
    Widget lista;
    if (nAmigo == 0) {
      index = 1;
      lista = Center(
        child: Column(
          children: [
            Image.asset(
              'sleepy_pirate.png',
              height: 100,
              width: 100,
            ),
            Text(
              'Tá meio vazio por aqui!',
              style: TextStyle(color: textColor),
            ),
          ],
        ),
      );
    } else {
      lista = Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
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
                if (_fotoAmigo[index] == 'null')
                  SizedBox(
                    height: 65,
                    width: 65,
                    child: Image.asset('assets/empty-person.png'),
                  )
                else
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      width: 65.0,
                      height: 65.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            getFotoLink(_fotoAmigo[index]),
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _usernameAmigo[index],
                    style: TextStyle(
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
    }
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    const String country = 'Brasil';
    const String labelMatches = 'Partidas Recentes';
    const String labelFriend = 'Amigos Online';
    const String labelGamesPlayed = 'Partidas Jogadas';
    const String labelGamesWon = 'Partidas Vencidas';
    const String labelWinStreak = 'Vitórias';
    //bool temPartidas = _partidasJogadas.isEmpty;
    const appBarBGColor = Color(0xFF293241);
    const textColor = Color(0xFF3D5A80);
    const bGColor = Color(0xFFDDDDDD);

    return Scaffold(
      backgroundColor: bGColor,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(idUser: idUser),
              ),
            );
          },
        ),
        elevation: 0,
        backgroundColor: appBarBGColor,
        toolbarHeight: 30,
      ),
      body: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (imageName == 'null')
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 48.0, 16.0),
                    child: Container(
                      width: 140.0,
                      height: 140.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/carra.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 0.0, 24.0, 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        width: 120.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              urlPhoto,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          _username,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '#' +
                              idUser.toString().split('-').first.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                          child: Container(
                            width: 20.0,
                            height: 20.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('assets/band-bras.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
                          child: Text(
                            country,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            decoration: const BoxDecoration(
                color: appBarBGColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                )),
          ),
          //Lista de Amigos
          Expanded(
            child: ListView.builder(
              itemCount: _amigos.length,
              itemBuilder: (BuildContext context, int index) {
                return buildList(_amigos.length, textColor, index);
              },
            ),
          ),
        ],
      ),
    );
  } //Function GetUserName(),
}
