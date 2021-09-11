// @dart=2.9
import 'package:flutter/material.dart';
import 'Screens/constantsLucas.dart';
import 'welcome_screenLucas.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  //raiz da aplicação.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Batalha naval',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}
