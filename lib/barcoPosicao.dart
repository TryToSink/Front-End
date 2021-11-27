import 'posicao.dart';

import 'package:proj0511/ui/barcosDTO.dart';

class BarcoPosicao {

  BarcoPosicao(this.barco);

  barcosDTO barco;
  List<Posicao> posicoes = [];

  void printT(){
    print(barco);
    print(posicoes);
  }
}