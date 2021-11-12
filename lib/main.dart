import 'package:flutter/material.dart';
import 'package:front_main/ui/battlePage.dart';
import 'package:front_main/ui/login.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

//  final _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'todo app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: LoginPage());
  }
}
