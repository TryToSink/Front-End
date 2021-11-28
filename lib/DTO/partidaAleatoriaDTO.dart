import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:proj0511/DTO/barcosDTO.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class partidaAleatoriaDTO {
  String? elo;
  String? idAdversario;
  String? nacionalidade;
  String? nomeAdversario;
  List<barcosDTO> barcos = [];
  String idPartida = '';
  String? foto;
  String? idCenario;
  String? nomeCenario;
  String? descricaoCenario;
  String? message;
}