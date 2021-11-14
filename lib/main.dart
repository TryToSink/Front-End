import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/profile_page.dart';

void main() {
  runApp(ProfilePageApp());
}

class ProfilePageApp extends StatelessWidget {
  const ProfilePageApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(idUser: "id", userName: "name", imageName: "foto"),
      theme: ThemeData(
        backgroundColor: Colors.blueAccent,
        primaryColor: Colors.blue[200],
      ),
    );
  }
}
