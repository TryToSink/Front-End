import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proj0511/ui/apiResetPassword.dart';
import 'package:proj0511/ui/home.dart';
import 'LoginPage.dart .dart';

class ResetPasswordPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xDFFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xff3D5A80),
        title: const Text('Esqueci a Senha'),
        centerTitle: true,
      ),
      body: new ListView(
        children: [
          Container(
            height: 200,
            width: 30,
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
                        decoration: const InputDecoration(hintText: 'Usuário'),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                          height: 44,
                          child: RaisedButton(
                            onPressed: () async {
                              String username = emailController.text;

                              print("User: $username");

                              var User = await ResetApi.reset(username);

                              if (User) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                        title: Text("Aviso:"),
                                        content: Text(
                                            "Pedido de recuperação concluído com sucesso. Se você for um usuário do sistema, aguarde nosso email."),
                                        actions: <Widget>[
                                          FlatButton(
                                              child: Text("OK"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              })
                                        ]);
                                  },
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                        title: Text("Aviso:"),
                                        content:
                                            Text("Usuário não encontrado."),
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
                            },
                            color: Color(0xff3D5A80),
                            textColor: Colors.white,
                            child: const Text('Enviar',
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

_navegaHomepage(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => HomePage(idUser: '')));
}
