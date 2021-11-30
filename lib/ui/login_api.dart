import 'dart:convert';
import 'package:http/http.dart' as http;

import '../rotas.dart';

class LoginApi {
  static Future<bool> login(String username, String password) async {
    var url = url1 + '/login';
    var header = {"Content-Type": "application/json"};
    Map params = {"username": username, "password": password};
    var _body = json.encode(params);
    var response =
        await http.post(Uri.parse(url), headers: header, body: _body);
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
    var url = 'http://201.42.59.203:3333/login';
    var header = {"Content-Type": "application/json"};
    Map params = {"username": username, "password": password};
    var _body = json.encode(params);
    var response =
        await http.post(Uri.parse(url), headers: header, body: _body);
    Map mapResponse = json.decode(response.body);
    var token = mapResponse["token"];
    final _iduser = mapResponse["id"];
    if (response.statusCode == 200) {
      return _iduser;
    } else {
      return false;
    }
  }
}
