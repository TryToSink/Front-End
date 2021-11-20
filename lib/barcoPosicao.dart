import 'package:front_main/posicao.dart';

import 'barco.dart';

class BarcoPosicao {

  BarcoPosicao(this.barco);

  Barco barco;
  List<Posicao> posicoes = [];

  void printT(){
    print(barco);
    print(posicoes);
  }
}