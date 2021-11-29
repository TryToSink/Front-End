// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class ResetApi {
  static Future<bool> reset(String username) async {
    var url = 'http://201.42.59.203:3333/password/forgot';

    var header = {"Content-Type": "application/json"};

    Map params = {"username": username};

    var _body = json.encode(params);
    print("json enviado : $_body");
    var response =
        await http.post(Uri.parse(url), headers: header, body: _body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map mapResponse = json.decode(response.body);

    var mensagem = mapResponse["message"];

    print("message : $mensagem");

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
