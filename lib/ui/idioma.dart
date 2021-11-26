// @dart=2.9

import 'package:flutter/material.dart';

class PageIdioma extends StatefulWidget {
  PageIdioma({Key key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<PageIdioma> createState() => _IdiomaState();
}

class _IdiomaState extends State<PageIdioma> {
  bool value = false;
  bool value2 = false;
  bool value3 = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
//        brightness: Brightness.dark,
        primaryColor: Color(0xFF293241),
      ),
      home: Scaffold(
        backgroundColor: Color(0xFFDDDDDD),
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          toolbarHeight: 100,
          backgroundColor: Color(0xFF293241),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back)),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 170, 0)),
              Text('IDIOMA')
            ],
          ),
        ),
        body: Container(
          width: size.width,
          height: size.height,
          color: Color(0xFFDDDDDD),
          child: LayoutBuilder(
            builder: (_, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 30, 0),
                  ),
                  Container(
                    width: constraints.maxWidth * .80,
                    height: constraints.maxHeight * .15,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          //maximumSize: size,
                          fixedSize: size,
                          backgroundColor: Colors.white,
                          elevation: 15,
                          shadowColor: Colors.grey),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: NetworkImage('assets/portugues.png'),
                                    fit: BoxFit.cover,
                                  ))),
                          Text(
                            'Português',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            softWrap: true,
                          ),
                          Checkbox(
                            value: this.value,
                            onChanged: (value) {
                              setState(() {
                                this.value = value;
                              });
                            }, //Checkbox
                            activeColor: Colors.green,
                            checkColor: Colors.white,
                            tristate: false,
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 10)),
                  Container(
                    width: constraints.maxWidth * .80,
                    height: constraints.maxHeight * .15,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          //maximumSize: size,
                          fixedSize: size,
                          backgroundColor: Colors.white,
                          elevation: 15,
                          shadowColor: Colors.grey),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: NetworkImage('assets/ingles.png'),
                                    fit: BoxFit.cover,
                                  ))),
                          Text(
                            'English',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            softWrap: true,
                          ),
                          Checkbox(
                            value: this.value3,
                            onChanged: (value3) {
                              setState(() {
                                this.value3 = value3;
                              });
                            }, //Checkbox
                            activeColor: Colors.green,
                            checkColor: Colors.white,
                            tristate: false,
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 10)),
                  Container(
                    width: constraints.maxWidth * .80,
                    height: constraints.maxHeight * .15,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          //maximumSize: size,
                          fixedSize: size,
                          backgroundColor: Colors.white,
                          elevation: 15,
                          shadowColor: Colors.grey),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: NetworkImage('assets/espanhol.png'),
                                    fit: BoxFit.cover,
                                  ))),
                          Text(
                            'Español',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            softWrap: true,
                          ),
                          Checkbox(
                            value: this.value2,
                            onChanged: (value2) {
                              setState(() {
                                this.value2 = value2;
                              });
                            }, //Checkbox
                            activeColor: Colors.green,
                            checkColor: Colors.white,
                            tristate: false,
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 70, 0, 50)),
                  Container(
                    width: constraints.maxWidth * .70,
                    height: constraints.maxHeight * .10,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          //maximumSize: size,
                          fixedSize: size,
                          backgroundColor: Color(0xFF3D5AB0),
                          elevation: 15,
                          shadowColor: Colors.grey),
                      child: Text(
                        'OK',
                        style:
                            const TextStyle(fontSize: 25, color: Colors.white),
                        softWrap: true,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
