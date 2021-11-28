import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proj0511/DTO/barcosDTO.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'DTO/partidaAleatoriaDTO.dart';

class socketConnect {
  //IO.Socket socket = IO.io('http://3.144.90.4:3334', <String, dynamic>{
  IO.Socket socket = IO.io('http://localhost:3334', <String, dynamic>{
    'transport': ['websocket'],
    'autoConnect': false,
  });

  static partidaAleatoriaDTO partidaAleatoriaDados = new partidaAleatoriaDTO();

  static String userId = '';
  static String idCenario = '';
  static String idPartida = '';

  static String partidaLRecusadaDados = '';
  static String partidaLAceitaDados = '';
  static String conviteLDados = '';
  static String iniciarJogoDados = '';
  static String jogadaDados = '';
  static String exceptionDados = '';

  static void setpartidaLRecusadaDados(String d){
    partidaLRecusadaDados = d;
  }

  static String getpartidaLRecusadaDados(){
    return partidaLRecusadaDados;
  }

  static void setpartidaLAceitaDados(String d){
    partidaLAceitaDados = d;
  }

  static String getpartidaLAceitaDados(){
    return partidaLAceitaDados;
  }

  static void setconviteLDados(String d){
    conviteLDados = d;
  }

  static String getconviteLDados(){
    return conviteLDados;
  }

  static void setiniciarJogoDados(String d){
    iniciarJogoDados = d;
  }

  static String getiniciarJogoDados(){
    return iniciarJogoDados;
  }

  static void setjogadaDados(String d){
    jogadaDados = d;
  }

  static String getjogadaDados(){
    return jogadaDados;
  }

  static void setexceptionDados(String d){
    exceptionDados = d;
  }

  static String getexceptionDados(){
    return exceptionDados;
  }

  static void setuserId(String d){
    userId = d;
  }

  static String getuserId(){
    return userId;
  }

  static void setidCenario(String d){
    idCenario = d;
  }

  static String getidCenario(){
    return idCenario;
  }

  static void setidPartida(String d){
    idPartida = d;
  }

  static String getidPartida(){
    return idPartida;
  }

  static void setpartidaAleatoriaDados(Map d){
    Map adversario = new Map();
    Map cenario = new Map();
    d.forEach((key, value) {
      if(d != 'message'){
        adversario = d['data']['adversario'];
        cenario = d['data']['cenario'];
        partidaAleatoriaDados.idPartida = d['data']['idPartida'];
      }
    });
    partidaAleatoriaDados?.idAdversario = adversario['id'];
    partidaAleatoriaDados?.elo = adversario['elo'];
    partidaAleatoriaDados?.nacionalidade = adversario['nacionalidade'];
    partidaAleatoriaDados?.nomeAdversario = adversario['name'];
    partidaAleatoriaDados?.idCenario = cenario['idCenario'];
    partidaAleatoriaDados?.foto = cenario['foto'];
    partidaAleatoriaDados?.nomeCenario = cenario['nome'];
    partidaAleatoriaDados?.descricaoCenario = cenario['descricao'];
    List<dynamic> listaBarcos = cenario['barcos'];
    cenario['barcos'].forEach((barco2) {
      barcosDTO barco = new barcosDTO();
      barco.IDBarco = barco2['IDBarco'];
      barco.foto1 = barco2['foto1'];
      barco.foto2 = barco2['foto2'];
      barco.foto3 = barco2['foto3'];
      barco.foto4 = barco2['foto4'];
      barco.foto5 = barco2['foto5'];
      barco.nomeBarco = barco2['nome'];
      barco.tamanho = barco2['tamanho'];
      partidaAleatoriaDados.barcos.add(barco);
    });
  }

  static partidaAleatoriaDTO getpartidaAleatoriaDados(){
    return partidaAleatoriaDados;
  }

  void initSocket() {
    socket.on('event', (data) => print(data));
    socket.onConnect((data) => print('connected'));
    socket.connect();
  }

  void closeSocket() {
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  }

  void login(String userId) {
    socket.emit('user id', {'userId': userId});
    setuserId(userId);
  }

  void convidarAmigo(String idAmigo, String idCenario) {
    socket.emit('jogar com amigo', {
      'idAmigo': idAmigo,
      'idCenario': idCenario});
  }

  void responderConvite(bool aceite, String idAmigo, idCenario) {
    socket.emit('responder convite de partida', {
      'aceite': aceite,
      'idAmigo': idAmigo,
      'idCenario': idCenario});
  }

  void enviarDados(String userId, String idCenario, String idPartida, String gameStatus) {
    socket.emit('enviar dados', {
      'userId': userId,
      'idCenario': idCenario,
      'idPartida': idPartida});
  }

  void partidaAleatoria(String idCenario, String userId){
    socket.emit('procurar partida aleatoria', {
      'userId': userId,
      'idCenario': idCenario});
  }

  void partidaL(){
    print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA partidaL');
    socket.on('partida aleatoria encontrada', (dados)=> setpartidaAleatoriaDados(dados));
  }

  void partidaLRecusada(){
    socket.on('partida recusada', (dados)=> setpartidaLRecusadaDados(dados.toString()));
  }

  void partidaLAceita(){
    socket.on('partida aceita', (dados)=> setpartidaLAceitaDados(dados.toString()));
  }

  void conviteL(){
    socket.on('convite de partida', (dados)=> setconviteLDados(dados.toString()));
  }

  void iniciarJogo(){
    socket.on('iniciar jogo', (dados)=> setiniciarJogoDados(dados.toString()));
  }

  void jogada(){
    socket.on('jogada', (dados)=> setjogadaDados(dados.toString()));
  }

  void exception(){
    socket.on('exception', (dados)=> setexceptionDados(dados.toString()));
  }

  void reconnect(){
    socket.onReconnect((_){
      socket.emit("enviar dados", {
        'userId': userId,
        'idCenario': idCenario,
        'idPartida': idPartida});
    });
  }

  void home(){
    partidaL();
    partidaLRecusada();
    partidaLAceita();
    conviteL();
    iniciarJogo();
    reconnect();
    exception();
  }

}