

import 'dart:math';

import 'package:flutter/material.dart';


class BarcosDTO {

  String iDBarco = '';
  String foto1 = '';
  String foto2 = '';
  String foto3 = '';
  String foto4 = '';
  String foto5 = '';
  String nomeBarco = '';
  int tamanho = 0;

  String returnId() {
    return iDBarco;
  }

  String returnFoto(int i) {
    if (i == 0) {
      return foto1;
    } else if (i == 1) {
      return foto2;
    } else if (i == 2) {
      return foto3;
    } else if (i == 3) {
      return foto4;
    } else {
      return foto5;
    }
  }

  static Widget getFoto(String foto) {
    final url = "http://3.144.90.4:3333/files/";
    return Image.network(
      url + foto,
      fit: BoxFit.fill,
    );
  }

  static Widget getParteFoto(bool status,bool rotacao,String image,String defaultImage){
    return status
        ? rotacao
        ? Transform.rotate(
      angle: 90.0 * pi / 180,
      child: status
          ?getFoto(image)
          : Image.asset(defaultImage),
    )
        :getFoto(image  )
        : Image.asset(defaultImage);
  }
}

