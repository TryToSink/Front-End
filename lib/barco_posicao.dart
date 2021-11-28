import 'posicao.dart';

import 'package:proj0511/ui/barcos_dto.dart';

class BarcoPosicao {
  BarcoPosicao(this.barco);

  BarcosDTO barco;
  List<Posicao> posicoes = [];

  void printT() {
    print(barco);
    print(posicoes);
  }
}
