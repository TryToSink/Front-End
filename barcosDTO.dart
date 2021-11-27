import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class barcosDTO {
  String IDBarco = '';
  String foto1 = '';
  String foto2 = '';
  String foto3 = '';
  String foto4 = '';
  String foto5 = '';
  String nomeBarco = '';
  int tamanho = 0;
}
