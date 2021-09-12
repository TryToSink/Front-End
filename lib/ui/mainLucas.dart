// @dart=2.9
import 'package:flutter/material.dart';

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

//import 'package:app_teste/Screens/components/bodyLucas.dart';
//import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

//import 'package:app_teste/components/rounded_buttonLucas.dart';
//import 'package:flutter/material.dart';
//import 'package:app_teste/welcome_screenLucas.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'dart:convert';

class Body extends StatefulWidget {
  @override
  _Homepagestate createState() => _Homepagestate();
}

class _Homepagestate extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextFormField(
              onChanged: (text) {},
              keyboardType: TextInputType.text,
              style: TextStyle(fontWeight: FontWeight.bold, height: 5),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(),
                labelText: "Digite seu usuario",
                labelStyle: TextStyle(color: Colors.blue),
              ),
            ),
            SizedBox(height: 7),
            TextFormField(
              onChanged: (text) {},
              obscureText: true,
              keyboardType: TextInputType.text,
              style: TextStyle(fontWeight: FontWeight.bold, height: 5),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(),
                labelText: "Senha",
                labelStyle: TextStyle(color: Colors.blue),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                ),
                RoundedButton(
                  text: "Acessar",
                  press: () {},
                ),
                RoundedButton(
                  text: "Cadastrar",
                  press: () {},
                ),
                SizedBox(
                  height: size.height * 0.35,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {},
                  child: Icon(Icons.arrow_back),
                  backgroundColor: Colors.blue,
                ),
                FloatingActionButton(
                  onPressed: () {},
                  child: Icon(Icons.arrow_forward),
                  backgroundColor: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//import 'package:app_teste/Screens/constantsLucas.dart';
//import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(),
      ),
    );
  }

  //Used:ElevatedButton as FlatButton is deprecated.
  //Here we have to apply customizations to Button by inheriting the styleFrom

  Widget newElevatedButton() {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      onPressed: press,
      style: ElevatedButton.styleFrom(
          primary: color,
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 30),
          textStyle: TextStyle(
              color: textColor, fontSize: 14, fontWeight: FontWeight.w500)),
    );
  }
}

//import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
