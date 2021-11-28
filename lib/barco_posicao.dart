import 'posicao.dart';

import 'package:proj0511/ui/barcos_dto.dart';

class BarcoPosicao {
  BarcoPosicao(this.barco);

  BarcosDTO barco;
  List<Posicao> posicoes = [];

  void printT(int i) {
    print(barco);
    print(posicoes);
  }

  String setPosicoes() {
    String compose = "";
    for (int i = 0; i < posicoes.length; i++) {
      if (i == posicoes.length - 1) {
        String aux =
            '{"foto": "${posicoes[i].foto}", "eixoX": "${posicoes[i].eixoX}", "eixoY": "${posicoes[i].eixoY}"}';
        compose = compose + aux;
      } else {
        String aux =
            '{"foto": "${posicoes[i].foto}", "eixoX": "${posicoes[i].eixoX}", "eixoY": "${posicoes[i].eixoY}"},';
        compose = compose + aux;
      }
    }
    return compose;
  }

  String returnBarcoPosicao() {
    return '{"idBarco": "${this.barco.iDBarco}", "posicoes: [${setPosicoes()}]}';
  }
}
