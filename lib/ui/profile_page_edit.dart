// ignore_for_file: no_logic_in_create_state, must_be_immutable, avoid_print, deprecated_member_use, unused_element

import 'dart:io';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

import '../rotas.dart';
import 'profile_page.dart';

class ProfilePageEdit extends StatefulWidget {
  String idUser;

  ProfilePageEdit({Key? key, required this.idUser}) : super(key: key);

  @override
  State<ProfilePageEdit> createState() => _ProfilePageEditState(idUser: idUser);
}

class _ProfilePageEditState extends State<ProfilePageEdit> {
  String idUser;

  _ProfilePageEditState({Key? key, required this.idUser});

  File? image;
  String? imageName = 'null';
  late String _username = '';
  late String _name = '';
  late String _email = '';

  late String urlProfile = url1 + '/usuarios/find';
  late String urlPhoto = url1 + '/files/' + imageName!;
  late String urlFriends = url1 + '/usuarios/amigosOnline';
  late String urlUpdate = url1 + '/usuarios';

  @override
  void initState() {
    super.initState();
    print('Entrou no initstate');
    getUser();
  }

  getUser() async {
    try {
      final response = await http.get(
        Uri.parse(urlProfile + "?id=" + idUser),
      );

      final jsonData = await jsonDecode(response.body) as Map;
      setState(() {
        _name = jsonData['name'];
        _username = jsonData['username'];
        _email = jsonData['email'];
        imageName = jsonData['foto'];
        imageName ??= 'null';
      });
    } catch (error) {
      print(error);
    }
  }

  void updateUser(idUser, String name, String username, String email) async {
    getUser();

    try {
      final response = await http.put(
        Uri.parse(urlUpdate),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(
            {'id': idUser, 'name': name, 'username': username, 'email': email}),
      );
      print(response.body);
    } catch (error) {
      print('$idUser, $name, $username, $email, $urlUpdate');
      print('Deu erro no updateBoat');
    }
  }

  selecionarImagemGaleria() async {
    try {
      final imagemUser =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagemUser == null) return;

      final imageTemporary = File(imagemUser.path);
      setState(() => image = imageTemporary);
    } catch (e) {
      print(e);
    }
  }

  uploadFile() async {
    final imagemUser =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagemUser == null) return;
    final imageTemporary = File(imagemUser.path);

    var stream =
        http.ByteStream(DelegatingStream.typed(imageTemporary.openRead()));
    // get file length
    var length = await imageTemporary.length();

    // string to uri
    var uri = Uri.parse(urlPhoto);

    // create multipart request
    var request = http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = http.MultipartFile('foto', stream, length,
        filename: basename(imageTemporary.path));

    // add file to multipart
    request.fields['id'] = idUser;
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  Widget buildEditButton(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: const Color(0xFF3D5A80),
          all: 8,
          child: const Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  @override
  Widget build(BuildContext context) {
    const appBarBGColor = Color(0xFF293241);
    const textColor = Color(0xFF3D5A80);
    const bGColor = Color(0xFFDDDDDD);
    late TextEditingController usernameController =
        TextEditingController(text: _username);
    late TextEditingController nameController =
        TextEditingController(text: _name);
    late TextEditingController emailController =
        TextEditingController(text: _email);

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
            height: 50,
            decoration: const BoxDecoration(
              color: appBarBGColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              verticalDirection: VerticalDirection.up,
              children: const <Widget>[
                Text(
                  'Editar Perfil',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.0,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32.0, 16.0, 24.0, 16.0),
              child: Positioned(
                top: 110,
                child: Stack(
                  children: [
                    if (imageName == 'null')
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 0.0, 48.0, 16.0),
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
                        padding:
                            const EdgeInsets.fromLTRB(32.0, 0.0, 24.0, 16.0),
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
                    InkWell(
                      onTap: uploadFile,
                      child: Positioned(
                        bottom: 4,
                        right: 4,
                        child: buildEditButton(textColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: appBarBGColor,
                          width: 2.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: appBarBGColor,
                          width: 2.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                          width: 2.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2.5,
                        ),
                      ),
                      fillColor: Colors.white,
                    ),
                    controller: usernameController,
                    selectionWidthStyle: BoxWidthStyle.max,
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: appBarBGColor,
                          width: 2.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: appBarBGColor,
                          width: 2.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                          width: 2.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2.5,
                        ),
                      ),
                    ),
                    controller: nameController,
                    selectionWidthStyle: BoxWidthStyle.max,
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: appBarBGColor,
                          width: 2.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: appBarBGColor,
                          width: 2.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                          width: 2.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2.5,
                        ),
                      ),
                    ),
                    controller: emailController,
                    selectionWidthStyle: BoxWidthStyle.max,
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: textColor,
                    ),
                    width: 140,
                    height: 60,
                    child: ElevatedButton(
                      child: const Text('Salvar'),
                      onPressed: () {
                        setState(() {
                          updateUser(idUser, nameController.text,
                              usernameController.text, emailController.text);
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
