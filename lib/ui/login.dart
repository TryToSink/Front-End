import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testeteste30_09/Signup.Page.dart';
import 'package:testeteste30_09/home.dart';
import 'package:testeteste30_09/reset-password.page.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _MyHomeLoginState();
}

class _MyHomeLoginState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              //                child: Image.asset("assets/logo.png"),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _emailController,
              // autofocus: true,
              keyboardType: TextInputType.emailAddress,
//                  validator: (email) {
//                    if (email == null || email.isEmpty) {
//                      return 'Digite seu e-mail';
//                    } else if (!RegExp(
//                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                        .hasMatch(_emailController.text)) {
//                      return 'E-mail incorreto';
//                    }
//                  },
              decoration: InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
//                  validator: (senha) {
//                    if (senha == null || senha.isEmpty) {
//                      return 'Digite sua senha';
//                    } else if (senha.length < 6) {
//                      return 'Digite uma senha maior que 6 caracteres';
//                    }
//                    return null;
//                  },
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            Container(
              height: 40,
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text(
                  "Recuperar Senha",
                  textAlign: TextAlign.right,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResetPasswordPage(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [
                    Color(0xFF42A1FF),
                    Color(0xFF22FFFF),
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  // onPressed: () {

                  onPressed: () async {
                    print("AQUI");
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    // bool loginOk = await login();
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    //if (loginOk) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                    // } else {
                    //  _passwordController.clear();
                    //  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    // }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              child: FlatButton(
                child: Text(
                  "Cadastre-se",
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

//  final snackBar = SnackBar(
//    content: Text(
//      'E-mail ou senha inválido!',
//      textAlign: TextAlign.center,
//    ),
//    backgroundColor: Colors.redAccent,
//  );

  // Future<bool> login() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   var url = Uri.parse('_baseUrl :333/login');
  //   var resposta = await http.post(
  //     url,
  //     body: {
  //       'username': _emailController.text,
  //       'password': _passwordController.text
  //     },
  //   );
  //  if (resposta.statusCode == 200) {
  //   print(jsonDecode(resposta.body)['token']);
  //  return true;
  //  } else {
  //    print(jsonDecode(resposta.body));
  //    return false;
  //  }
  // }
}
