// ignore_for_file: no_logic_in_create_state, must_be_immutable, avoid_print, deprecated_member_use, unused_element, prefer_const_constructors, prefer_final_fields

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proj0511/ui/profile_page_edit.dart';
import '../rotas.dart';

class ProfilePage extends StatefulWidget {
  late String idUser;

  ProfilePage({
    Key? key,
    required this.idUser,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState(idUser: idUser);
}

class _ProfilePageState extends State<ProfilePage> {
  String idUser;

  _ProfilePageState({Key? key, required this.idUser});

  late String imageName = 'foto';
  late String _username = '';
  late List _amigos = [];
  late List _usernameAmigo = [];
  late List _partidasJogadas = [];
  late List _usernamePartidas = [];
  late Map _amigosMap = {};
  late int numeroPartidas = 0;
  late List _partidasVencidas = [];
  late int venceu = 0;

  late String urlProfile = url1 + '/usuarios/find';
  late String urlPhoto = url1 + '/usuarios/foto/' + imageName;
  late String urlFriends = url1 + '/usuarios/amigosOnline';
  late String urlAddFriends = url1 + '/usuarios/adicionaAmigo';
  late String urlUpdate = url1 + '/usuarios';
  late String urlHistorico = url1 + '/usuarios/historico';

  @override
  void initState() {
    super.initState();
    print('Entrou no initstate ' + idUser);
    getUser();
    getPartidas();
  }

  getUser() async {
    try {
      final response = await http.get(
        Uri.parse(urlProfile + "?id=" + idUser),
      );

      var jsonData = jsonDecode(response.body);
      setState(() {
        _username = jsonData['username'];
        _amigos = jsonData['amigos'];
        for (var element in _amigosMap.entries) {
          _amigos.add(element);
        }
        int counter = (_amigos.length.toInt());
        for (var i = 0; i < counter; i++) {
          _usernameAmigo.add(_amigos[i]['name']);
        }
      });
    } catch (error) {
      print(error);
    }

    setState(() {
      urlPhoto = 'http://201.42.59.203:3333/usuarios/foto/' + imageName;
      imageCache!.clear();
      imageCache!.clearLiveImages();
    });
    return;
  }

  getPartidas() async {
    try {
      final response =
          await http.get(Uri.parse(urlHistorico + '?id=' + idUser));
      print('BODY PARTIDAS: ' + response.body);

      final jsonData = jsonDecode(response.body) as Map;
      print('JSONDATA PARTIDAS: ' + jsonData.toString() + '\n');

      setState(() {
        _partidasJogadas = jsonData['oponentes'];
        print('PARTIDASJOGADAS: ' + _partidasJogadas.toString() + '\n');
        numeroPartidas = jsonData['oponentes'].length;
        print('NUMEROPARTIDAS: ' + numeroPartidas.toString() + '\n');
        int counter = (_partidasJogadas.length.toInt());
        print('COUNTER: ' + counter.toString() + '\n');
        for (var i = 0; i < counter; i++) {
          _usernamePartidas.add(_partidasJogadas[i]['nome']);
          if (_partidasJogadas[i]['venceu']) {
            print(
                'PARTIDASJOGADAS[i]: ' + _partidasJogadas[i].toString() + '\n');
            _partidasVencidas.add(_partidasJogadas[i]);
          }
        }
        venceu = _partidasVencidas.length;
      });

      //print('PARTIDAS JOGADAS: ' + _partidasJogadas.toString());
    } catch (error) {
      print(error);
    }
  }

  buildList(nPartidas, textColor, index) {
    Widget lista;
    if (nPartidas == 0) {
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
        padding:
            const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
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
                    _usernamePartidas[index],
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
                    child: Image.asset(getAssetResult(
                        _partidasJogadas[index]['venceu'], index)),
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

  buildFriendList(nPartidas, textColor, index) {
    Widget lista;
    bool vitoria = false;
    if (nPartidas == 0) {
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
        padding:
            const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
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
                    _usernamePartidas[index],
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

  getAssetResult(
    result,
    index,
  ) {
    if (result) {
      return 'assets/cubo-star.png';
    } else {
      return 'lib/assets/lose.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    late String gamesPlayed = numeroPartidas.toString();
    const String gamesWon = ' 45%';
    late String wins = venceu.toString();
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
        leading: const BackButton(
          color: Colors.white,
        ),
        elevation: 0,
        backgroundColor: appBarBGColor,
        toolbarHeight: 30,
      ),
      body: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (imageName == 'foto')
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 0.0, 24.0, 16.0),
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      urlPhoto,
                      width: 120.0,
                      height: 120.0,
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
                        Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  print('idUser: ' + idUser);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProfilePageEdit(
                                        idUser: idUser,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.edit),
                              )
                            ]),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 80,
                  width: 140,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        labelGamesPlayed,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 30.0,
                            height: 30.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('assets/Cópia de jostik.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Text(
                            gamesPlayed,
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  width: 140,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        labelGamesWon,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 30.0,
                            height: 30.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('assets/cubo-star.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const Text(
                            ' ' + gamesWon,
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  width: 140,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        labelWinStreak,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        '\u{1F525} $wins',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //Lista de Partidas
          Container(
            child: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 24.0,
              ),
              child: Text(
                labelMatches,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
            height: 40.0,
            width: double.infinity,
            decoration: const BoxDecoration(color: appBarBGColor),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: numeroPartidas,
              itemBuilder: (BuildContext context, int index) {
                return buildList(numeroPartidas, textColor, index);
              },
            ),
          ),
          //Lista de Amigos
          Container(
            child: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 24.0,
              ),
              child: Text(
                labelFriend,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
            height: 40.0,
            width: double.infinity,
            decoration: const BoxDecoration(color: appBarBGColor),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _amigos.length,
              itemBuilder: (BuildContext context, int index) {
                return buildFriendList(_amigos.length, textColor, index);
              },
            ),
          ),
        ],
      ),
    );
  } //Function GetUserName(),
}
