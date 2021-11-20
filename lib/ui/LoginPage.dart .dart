import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proj0511/ui/LoginApi.dart.dart';
import 'package:proj0511/ui/home.dart';
import 'package:proj0511/ui/resetPasswordPage.dart';
import 'SignUpPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget{

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xDFFFFFFF),

      appBar: AppBar(

        backgroundColor: Color(0xff3D5A80),

        title: const Text('Login'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Idioma()));
            },
            textColor: Colors.white,
            child: const Text(
              'Criar conta',
              style: TextStyle(fontSize: 10),
            ),
          )
        ],

      ),

      body: new ListView(
        children: [
          Container(
           height: 350, width: 30,
            child: Image.asset('assets/logo.png'),

      ),
      Center(


        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(


              key: formKey,

          child: ListView(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            children: <Widget>[

              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'E-mail',
                  prefixIcon: const Icon(
                    Icons.email,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,

              ),

              const SizedBox(height: 16,),
              TextFormField(
                controller: passController,
                decoration: const InputDecoration(hintText: 'Senha',
                  prefixIcon: const Icon(
                  Icons.lock_outline,

                ),

                ),

                autocorrect: false,
                obscureText: true,

                validator: (pass){
                  if(pass!.isEmpty || pass.length < 6)
                    return 'Senha inválida!';
                  return null;
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: (){

                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => ResetPasswordPage()));
                  },
                  padding: EdgeInsets.zero,
                  child: const Text(
                    'Esqueci minha senha'
                  ),
                ),
              ),

              const SizedBox(height: 16,),
              SizedBox(
                height: 44,


              child: RaisedButton(
                  onPressed: () async {

                    if(formKey.currentState!.validate()){
                      String username = emailController.text;
                      String password = passController.text;
                      print("Login: $username , Senha: $password ");
                      Map params = {"username": username, "password": password};
                      var header = {"Content-Type": "application/json"};
                      var url = 'http://3.144.90.4:3333/login';
                      var _body = json.encode(params);
                      print("json enviado : $_body");
                      var response = await http.post(Uri.parse(url), headers: header, body: _body);
                      Map mapResponse = json.decode(response.body);

                      var token = mapResponse["token"];
                      print("token : $token");

                      if(response.statusCode == 200) {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => HomePage(token)));
                      }
                      else {
                            showDialog(
                            context: context,
                            builder: (context) {
                            return AlertDialog(
                                title: Text("Erro"),
                                content: Text("Login e/ou Senha inválido(s)"),
                                actions: <Widget>[
                                FlatButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => LoginPage()));
                                })
                              ]);
                              },
                            );
                      }
                    }
              },
                color: Color(0xff3D5A80),
                textColor: Colors.white,

                child: const Text(
                  'Entrar',
                  style: TextStyle(
                    fontSize: 18
                  )
                ),
              )
              )
            ],
          )
        ),
      ),
    ),
    ],
      ),
    );

  }


}
