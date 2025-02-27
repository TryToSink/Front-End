import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'login_api.dart';
import 'reset_password_page.dart';
import 'sign_up_page.dart';
import 'socket_connect.dart';

class LoginPage extends StatelessWidget {
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
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpPage()));
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
            height: 350,
            width: 30,
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
                        decoration: const InputDecoration(
                          hintText: 'Usuário',
                          prefixIcon: const Icon(
                            Icons.email,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: passController,
                        decoration: const InputDecoration(
                          hintText: 'Senha',
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                          ),
                        ),
                        autocorrect: false,
                        obscureText: true,
                        validator: (pass) {
                          if (pass!.isEmpty || pass.length < 6)
                            return 'Senha inválida!';
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResetPasswordPage()));
                          },
                          padding: EdgeInsets.zero,
                          child: const Text('Esqueci minha senha'),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                          height: 44,
                          child: RaisedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                String username = emailController.text;
                                String password = passController.text;

                                var User =
                                    await LoginApi.login(username, password);
                                var ID = await LoginApi.get(username, password);

                                if (User) {
                                  _navegaHomepage(context, ID.toString());
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          title: Text("Erro"),
                                          content: Text(
                                              "Login e/ou Senha inválido(s)"),
                                          actions: <Widget>[
                                            FlatButton(
                                                child: Text("OK"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                })
                                          ]);
                                    },
                                  );
                                }
                              }
                            },
                            color: Color(0xff3D5A80),
                            textColor: Colors.white,
                            child: const Text('Entrar',
                                style: TextStyle(fontSize: 18)),
                          ))
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

_navegaHomepage(BuildContext context, String userId) {
  try {
    socketConnect().initSocket();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomePage(idUser: userId)));
  } catch (e) {
    print(e.toString());
  }
}
