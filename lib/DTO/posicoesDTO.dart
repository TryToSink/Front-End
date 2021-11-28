import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class posicoesDTO {
  String idPartesBarcoJogo = '';
  String idBarcoPartida = '';
  String foto = '';
  int eixoX = 0;
  int eixoY = 0;
  bool atingido = false;
}