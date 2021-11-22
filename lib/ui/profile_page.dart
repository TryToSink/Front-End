import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flag/flag.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:proj0511/ui/profile_page_edit.dart';
import 'package:proj0511/ui/user.dart';
import 'package:proj0511/ui/apiSignUp.dart';
import 'globals.dart' as globals;

class ProfilePage extends StatefulWidget {
  ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  _ProfilePageState();
  late User user = globals.globalUser;
  late String imageName = 'foto';

  late String urlProfile = 'http://3.144.90.4:3333/usuarios/find';
  late String urlPhoto = 'http://3.144.90.4:3333/usuarios/foto/' + imageName;
  late String urlFriends = 'http://3.144.90.4:3333/usuarios/amigosOnline';
  late String urlAddFriends = 'http://3.144.90.4:3333/usuarios/adicionaAmigo';
  late String urlUpdate = 'http://3.144.90.4:3333/usuarios';

  @override
  void initState() {
    super.initState();
    getUser(user.id);
  }

  Future getUser(String idUser) async {
    try {
      final response = await http.get(
        Uri.parse(urlProfile + "?id=" + idUser),
      );

      setState(() {
        user = globals.globalUser;
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
    const String gamesPlayed = '25';
    const String gamesWon = '25%';
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
                          image: AssetImage('images/profile_pic.jpg'),
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
                      children: [
                        Text(
                          user.username,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          user.id,
                          style: const TextStyle(
                            fontSize: 32.0,
                            color: Colors.grey,
                          ),
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProfilePageEdit(),
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
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                          child: Flag.fromString(
                            'BR',
                            height: 40,
                            width: 40,
                          ),
                        ),
                        Padding(
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
                    children: const [
                      Text(
                        labelGamesPlayed,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        '\u{1F3AE} ${gamesPlayed}',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
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
                        labelGamesWon,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        '\u{1F451} ${gamesWon}',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
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
                        '\u{1F525} ${winStreak}',
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
          // Container(
          //   child: const Padding(
          //     padding: EdgeInsets.symmetric(
          //       vertical: 8.0,
          //       horizontal: 24.0,
          //     ),
          //     child: Text(
          //       labelMatches,
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 18.0,
          //       ),
          //     ),
          //   ),
          //   height: 40.0,
          //   width: double.infinity,
          //   decoration: BoxDecoration(color: appBarBGColor),
          // ),
          // Expanded(
          //   child: ListView(
          //     children: const [
          //       Card(
          //         child: ListTile(
          //           title: Text('Player'),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
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
              itemCount: user.amigos.length,
              itemBuilder: (BuildContext context, int index) {
                return user.amigos.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            Image.asset('sleepy_pirate.png'),
                            Text('Tá meio vazio por aqui!'),
                          ],
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          print("tamanho da lista " +
                              user.amigos.length.toString());
                        },
                        child: ListTile(
                          leading: Icon(Icons.person_pin),
                          title: Text(user.amigos[index].friendUsername),
                          subtitle: Text(user.amigos[index].online.toString()),
                          key: Key((user.amigos[index].friendId).toString()),
                          trailing: Container(
                            width: 50,
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.add),
                                  color: Colors.black,
                                  onPressed: () {},
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
