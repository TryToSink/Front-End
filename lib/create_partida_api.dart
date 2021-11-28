import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proj0511/barco_posicao.dart';

class CreatePartida {
  static Future<bool> create(String idPartida, String idJogador,
      List<BarcoPosicao> barcoPosicao) async {
    var url = 'http://3.144.90.4:3333/carregaJogo';
    var header = {"Content-Type": "application/json"};
    Map params = {
      "idPartida": idPartida,
      "idJogador": idJogador,
      "barcosPosicoes": "[${composeEnvio(barcoPosicao)}]"
    };
    var _body = json.encode(params);
    print("json enviado : $_body");
    var response =
        await http.post(Uri.parse(url), headers: header, body: _body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      print('Partida Criada');
      return true;
    } else {
      return false;
    }
  }

  static String composeEnvio(List<BarcoPosicao> barcoPosicao) {
    String compose = "";
    for (int i = 0; i < barcoPosicao.length; i++) {
      if (i == barcoPosicao.length) {
        String aux = barcoPosicao[i].returnBarcoPosicao();
        compose = compose + aux;
      } else {
        String aux = barcoPosicao[i].returnBarcoPosicao()+",";
        compose = compose + aux;
      }
    }
    return compose;
  }
}
