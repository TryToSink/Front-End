// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use

import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'LoginPage.dart.dart';
import 'apiSignUp.dart';

class SignUpPage extends StatelessWidget{

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xDFFFFFFF),

      appBar: AppBar(

        backgroundColor: Color(0xff3D5A80),

        title: const Text('Registre-se'),
        centerTitle: true,


      ),

      body: new ListView(
        children: [
          Container(
            height: 50, width: 20,


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
                        controller: _nameController,
                        decoration: const InputDecoration(hintText: 'Nome Completo'),
                          validator: (name){
                            if(name!.isEmpty)
                              return 'Campo obrigatÃ³rio';
                            else if(name.trim().split(' ').length <= 1)
                              return 'Preencha seu Nome completo';
                            return null;
                          }

                      ),

                      const SizedBox(height: 16,),
                      TextFormField(
                        controller: _userController,
                          decoration: const InputDecoration(
                              hintText: 'UsuÃ¡rio'),
                          validator: (usuario) {
                            if (usuario!.isEmpty)
                              return 'Campo obrigatÃ³rio';
                          }
                      ),
                      const SizedBox(height: 16,),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(hintText: 'E-mail'),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (email){
                          if(!emailValid(email!))
                            return 'E-mail InvÃ¡lido';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16,),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(hintText: 'Senha'),
                        autocorrect: false,
                        obscureText: true,
                        validator: (pass){
                          if(pass!.isEmpty)
                            return 'Campo obrigatÃ³rio';
                          else if(pass.length < 6 )
                            return 'A senha precisa ter 6 caracteres ou mais';
                          else if(!passValid(pass))
                            return 'A senha deve possuir pelo menos uma letra maiuscula, um numero e um caracter especial';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16,),
                      TextFormField(
                        controller: _password2Controller,
                          decoration: const InputDecoration(hintText: 'Repita a Senha'),
                          obscureText: true,
                      ),

                      const SizedBox(height: 16,),
                      SizedBox(
                          height: 44,
                          child: RaisedButton(
                            onPressed: () async {
                              if(formKey.currentState!.validate()) {

                                String name = _nameController.text;
                                String username = _userController.text;
                                String email = _emailController.text;
                                String password = _passwordController.text;
                                String password2 = _password2Controller.text;

                                print("User: $name");

                                var User = await ApiSignUp.signUp(name,username,email, password);

                                    if (User) {
                                    _navegaHomepage(context);
                                    }

                                    }

                                    if(_passwordController.text != _password2Controller.text){
                                      showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                            title: Text("Erro"),
                                            content: Text("As senhas nÃ£o coincidem"),
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
                              },
                            color: Color(0xff3D5A80),
                            textColor: Colors.white,

                            child: const Text(
                                'Registrar',
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

_navegaHomepage(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => LoginPage()));
}
