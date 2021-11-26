import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flag/flag.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:proj0511/ui/profile_page_edit%20(1).dart';
import 'package:proj0511/ui/user.dart';
import 'package:proj0511/ui/apiSignUp.dart';

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

  late String urlProfile = 'http://3.144.90.4:3333/usuarios/find';
  late String urlPhoto = 'http://3.144.90.4:3333/usuarios/foto/' + imageName;
  late String urlFriends = 'http://3.144.90.4:3333/usuarios/amigosOnline';
  late String urlAddFriends = 'http://3.144.90.4:3333/usuarios/adicionaAmigo';
  late String urlUpdate = 'http://3.144.90.4:3333/usuarios';

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

    setState(() {
      urlPhoto = 'http://3.144.90.4:3333/usuarios/foto/' + imageName;
      imageCache!.clear();
      imageCache!.clearLiveImages();
    });

    return;
  }

  @override
  Widget build(BuildContext context) {
    const String gamesPlayed = ' 25';
    const String gamesWon = ' 45%';
    const String winStreak = '5';
    const String country = 'Brasil';
    const String labelMatches = 'Partidas Recentes';
    const String labelFriend = 'Amigos Online';
    const String labelGamesPlayed = 'Games Played';
    const String labelGamesWon = 'Games Won';
    const String labelWinStreak = 'Win Streak';
    const appBarBGColor = Color(0xFF293241);
    const textColor = Color(0xFF3D5A80);
    const bGColor = Color(0xFFE0FBFC);

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
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
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
                          const Text(
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
                            gamesWon,
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
                    children: const [
                      Text(
                        labelWinStreak,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        '\u{1F525} $winStreak',
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
                                Container(
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
                                Spacer(
                                  flex: 2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 24.0),
                                  child: Container(
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
          ),
        ],
      ),
    );
  } //Function GetUserName(),
}
