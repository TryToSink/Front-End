import 'dart:io';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:proj0511/ui/user.dart';
import 'globals.dart' as globals;

class ProfilePageEdit extends StatefulWidget {
  const ProfilePageEdit({Key? key}) : super(key: key);

  @override
  State<ProfilePageEdit> createState() => _ProfilePageEditState();
}

class _ProfilePageEditState extends State<ProfilePageEdit> {
  File? image;
  String? imageName;
  User currentUser = globals.globalUser;
  late String urlProfile = 'http://3.144.90.4:3333/usuarios/find';
  late String urlPhoto = 'http://3.144.90.4:3333/usuarios/foto/' + imageName!;
  late String urlFriends = 'http://3.144.90.4:3333/usuarios/amigosOnline';
  late String urlUpdate = 'http://3.144.90.4:3333/usuarios';

  selecionarImagemGaleria() async {
    try {
      final imagemBarcoGaleria =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagemBarcoGaleria == null) return;

      final imageTemporary = File(imagemBarcoGaleria.path);
      setState(() => this.image = imageTemporary);
    } catch (e) {
      print(e);
    }
  }

  uploadFile() async {
    final imagemBarcoGaleria =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagemBarcoGaleria == null) return;
    final imageTemporary = File(imagemBarcoGaleria.path);

    var stream =
        new http.ByteStream(DelegatingStream.typed(imageTemporary.openRead()));
    // get file length
    var length = await imageTemporary.length();

    // string to uri
    var uri = Uri.parse(urlPhoto);

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('foto', stream, length,
        filename: basename(imageTemporary.path));

    // add file to multipart
    request.fields['id'] = currentUser.id;
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    const appBarBGColor = Color(0xFF293241);
    const textColor = Color(0xFF3D5A80);
    const bGColor = Color(0xFFE0FBFC);
    late TextEditingController usernameController =
        TextEditingController(text: currentUser.username);
    late TextEditingController nameController =
        TextEditingController(text: currentUser.name);
    late TextEditingController emailController =
        TextEditingController(text: currentUser.email);

    return Scaffold(
      backgroundColor: bGColor,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Text('EDITAR PERFIL'),
        actions: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: appBarBGColor,
      ),
      body: Column(
        children: [
          Center(
              child: //if(imageName == 'foto')
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
              /*else
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    urlPhoto,
                    width: 120.0,
                    height: 120.0,
                ),
              ),*/
              ),
          Column(
            children: [
              Row(
                children: [
                  TextField(
                    controller: usernameController,
                    selectionWidthStyle: BoxWidthStyle.tight,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                  TextField(
                    controller: nameController,
                    selectionWidthStyle: BoxWidthStyle.tight,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    selectionWidthStyle: BoxWidthStyle.tight,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
