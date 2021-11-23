import 'package:flutter/material.dart';

class PageIdioma extends StatefulWidget {
  PageIdioma({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<PageIdioma> createState() => _IdiomaState();
}

class _IdiomaState extends State<PageIdioma> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
//        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey[900],
      ),
      home: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.blueGrey[900],
          actionsIconTheme:
              const IconThemeData(size: 30.0, color: Colors.white),
          title: const Center(
            child: (Text('IDIOMA')),
          ),
        ),
        body: Container(
          width: size.width,
          height: size.height,
          color: Colors.white,
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
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 50, 50, 0),
                          ),
                          Text(
                            'Português',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            softWrap: true,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 100, 0),
                          ),
                          Checkbox(
                            value: true,
                            onChanged: (value) {
                              toggleCheckbox(value);
                            },
                            activeColor: Colors.green,
                            checkColor: Colors.white,
                            tristate: false,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
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
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 50, 50, 0),
                          ),
                          Text(
                            'English',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            softWrap: true,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 130, 0),
                          ),
                          Checkbox(
                            value: false,
                            onChanged: (value) {
                              toggleCheckbox(value);
                            },
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
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 50, 50, 0),
                          ),
                          Text(
                            'Español',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            softWrap: true,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 125, 0),
                          ),
                          Checkbox(
                            value: false,
                            onChanged: (value) {
                              toggleCheckbox(value);
                            },
                            activeColor: Colors.green,
                            checkColor: Colors.white,
                            tristate: false,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 40, 30, 0),
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

  void toggleCheckbox(bool? value) {
    var isChecked = false;
    if (isChecked == false) {
      // Put your code here which you want to execute on CheckBox Checked event.
      setState(() {
        isChecked = true;
        var checkedResult = 'Checkbox is CHECKED';
      });
    } else {
      // Put your code here which you want to execute on CheckBox Un-Checked event.
      setState(() {
        isChecked = false;
        var checkedResult = 'Checkbox is UN-CHECKED';
      });
    }
  }
}
