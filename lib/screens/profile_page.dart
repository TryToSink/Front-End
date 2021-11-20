import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flag/flag.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:profile_try_to_sink/main.dart';
import 'package:profile_try_to_sink/model/boat.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ProfilePage extends StatefulWidget {
  String idUser;
  String userName;
  String imageName;

  ProfilePage(
      {Key? key,
      required this.idUser,
      required this.userName,
      required this.imageName})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState(
        idUser: idUser,
        userName: userName,
        imageName: imageName,
      );
}

class _ProfilePageState extends State<ProfilePage> {
  String userName;
  String idUser;
  String imageName = 'placeholder';
  File? image;

  _ProfilePageState({
    Key? key,
    required this.idUser,
    required this.userName,
    required this.imageName,
  });

  var _list = [];

  late String urlProfile = 'http://3.144.90.4:3333/usuarios/find';
  late String urlPhoto = 'http://3.144.90.4:3333/usuarios/foto' + imageName;
  late String urlFriends = 'http://3.144.90.4:3333/usuarios/amigosOnline';
  late String urlUpdate = 'http://3.144.90.4:3333/usuarios';

  Future getUser(String idUser) async {
    var user = {
      "id": "",
      "name": "",
      "username": "",
      "email": "",
      "amigos": []
    };
    try {
      final response = await http.get(
        Uri.parse(urlProfile + "?id=" + idUser),
      );
      final jsonData = jsonDecode(response.body) as List;
      setState(() {
        _list = jsonData;
      });
    } catch (error) {}

    setState(() {
      urlPhoto = 'http://3.144.90.4:3333/usuarios/foto' + imageName;
      imageCache!.clear();
      imageCache!.clearLiveImages();
    });

    return;
  }

  @override
  void initState() {
    super.initState();
    getUser(idUser);
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
              children: [
                if (imageName == 'placeholder')
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 0.0, 16.0, 16.0),
                    child: Container(
                      width: 120.0,
                      height: 120.0,
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
                      children: const [
                        Text(
                          //userName,
                          'Felipe',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          //idUser,
                          '#00001',
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
            padding: const EdgeInsets.fromLTRB(32.0, 24.0, 32.0, 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 60,
                  width: 120,
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
                  height: 60,
                  width: 120,
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
                  height: 60,
                  width: 120,
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
            decoration: BoxDecoration(color: appBarBGColor),
          ),
          Expanded(
            child: ListView(
              children: const [
                Card(
                  child: ListTile(
                    title: Text('Player'),
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
            decoration: BoxDecoration(color: appBarBGColor),
          ),
        ],
      ),
    );
  }

  //Function GetUserName(),
}
