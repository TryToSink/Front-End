// ignore_for_file: avoid_print
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:proj0511/rotas.dart';

class ApiSignUp {
  static Future<bool> signUp(
      String name, String user, String email, String password) async {
    var url = url1 + '/usuarios';

    var header = {"Content-Type": "application/json"};

    Map params = {
      "name": name,
      "username": user,
      "email": email,
      "password": password
    };

    var _body = json.encode(params);
    print("json enviado : $_body");
    var response =
        await http.post(Uri.parse(url), headers: header, body: _body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map mapResponse = json.decode(response.body);
    var id = mapResponse["id"];
    var nome = mapResponse["nome"];
    var emails = mapResponse["email"];
    var username = mapResponse["username"];
    var status = mapResponse["status"];
    var message = mapResponse["message"];

    print("status : $status");
    print("message : $message");

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
