import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<bool> login(String username, String password) async {
    var url = 'http://3.144.90.4:3333/login';
    var header = {"Content-Type": "application/json"};
    Map params = {"username": username, "password": password};
    var _body = json.encode(params);
    print("json enviado : $_body");
    var response =
        await http.post(Uri.parse(url), headers: header, body: _body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Map mapResponse = json.decode(response.body);
    var token = mapResponse["token"];
    final _iduser = mapResponse["id"];
    if (response.statusCode == 200) {
      print('Logon ok');
      return true;
    } else {
      return false;
    }
  }

  static Future<Object> get(String username, String password) async {
    var url = 'http://3.144.90.4:3333/login';
    var header = {"Content-Type": "application/json"};
    Map params = {"username": username, "password": password};
    var _body = json.encode(params);
    print("json enviado : $_body");
    var response =
        await http.post(Uri.parse(url), headers: header, body: _body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Map mapResponse = json.decode(response.body);
    var token = mapResponse["token"];
    final _iduser = mapResponse["id"];
    if (response.statusCode == 200) {
      print(_iduser);
      return _iduser;
    } else {
      return false;
    }
  }
}
