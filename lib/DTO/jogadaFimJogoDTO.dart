import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:proj0511/DTO/barcosDTO.dart';
import 'package:proj0511/DTO/barcosDestruidoDTO.dart';
import 'package:proj0511/DTO/jogoDTO.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class jogadaFimJogoDTO {
  String status = '';
  String message = '';
  jogoDTO jogo = new jogoDTO();
}