import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:proj0511/DTO/barcosDTO.dart';
import 'package:proj0511/DTO/barcosDestruidoDTO.dart';
import 'package:proj0511/DTO/cenarioDTO.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class vencedorDTO {
  String id = '';
  String nome = '';
  String elo = '';
  String nacionalidade = '';
  cenarioDTO cenario = new cenarioDTO();
}