import 'package:flutter/material.dart';
// import 'package:testeteste30_09/home.dart';

class LoadPage extends StatefulWidget {
  const LoadPage({Key? key}) : super(key: key);

  @override
  _MyLoadPage createState() => _MyLoadPage();
}

class _MyLoadPage extends State<LoadPage> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '',
        theme: ThemeData(
//        brightness: Brightness.dark,
          primaryColor: Colors.blueGrey[400],
        ),
        home: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("LOAD PAGE"),
          ),
          body: Center(
              child: RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Retornar !'))),
        ));
  }
}
