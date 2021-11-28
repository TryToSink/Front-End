import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:proj0511/DTO/barcosDTO.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class conviteDTO {
  String? idAmigo;
  String? nome;
  String? idCenario;
}