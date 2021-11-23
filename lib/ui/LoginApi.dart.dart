import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<Object> login(String username, String password) async {
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
    print("iduser : $_iduser");
    print("token : $token");
    if (response.statusCode == 200) {
      return _iduser;
    } else {
      return false;
    }
  }
}
