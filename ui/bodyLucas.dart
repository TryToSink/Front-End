// @dart=2.9
import 'package:app_teste/components/rounded_buttonLucas.dart';
import 'package:flutter/material.dart';
import 'package:app_teste/welcome_screenLucas.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
