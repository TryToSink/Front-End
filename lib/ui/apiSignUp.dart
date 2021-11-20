import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiSignUp {
  static Future<bool> signUp(String name, String user,String email, String password) async {
    var url = 'http://3.144.90.4:3333/usuarios';

    var header = {"Content-Type": "application/json"};

    Map params = {"name": name, "username": user,  "email": email,  "password": password};


    var _body = json.encode(params);
    print("json enviado : $_body");
    var response = await http.post(Uri.parse(url), headers: header, body: _body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map mapResponse = json.decode(response.body);




    if(response.statusCode == 200){
      return true;
    }
    else{
      return false;
    }

  }
}

