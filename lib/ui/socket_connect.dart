import 'package:proj0511/DTO/barcosDTO.dart';
import 'package:proj0511/DTO/barcosPerdedorDTO.dart';
import 'package:proj0511/DTO/posicoesDTO.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../DTO/partidaAleatoriaDTO.dart';
import '../../DTO/conviteDTO.dart';
import '../../DTO/partidaRecusadaDTO.dart';
import '../../DTO/exceptionDTO.dart';
import '../../DTO/jogadaTiroDTO.dart';
import '../../DTO/jogadaDestruidoDTO.dart';
import '../../DTO/jogadaFimJogoDTO.dart';
import '../../DTO/iniciar_jogo_dados_dto.dart';

class socketConnect {
  //IO.Socket socket = IO.io('http://201.42.59.203:3334:3334', <String, dynamic>{
  IO.Socket socket = IO.io('http://201.42.59.203:3334', <String, dynamic>{
    'transport': ['websocket'],
    'autoConnect': true,
  });

  static partidaAleatoriaDTO partidaAleatoriaDados = new partidaAleatoriaDTO();
  static conviteDTO conviteLDados = new conviteDTO();

  static String userId = '';
  static String idCenario = '';
  static String idPartida = '';
  static partidaRecusadaDTO partidaLRecusadaDados = new partidaRecusadaDTO();
  static partidaAleatoriaDTO partidaLAceitaDados = new partidaAleatoriaDTO();
  static iniciarJogoDadosDTO iniciarJogoDados = new iniciarJogoDadosDTO();
  static jogadaTiroDTO jogadaTiroDados = jogadaTiroDTO();
  static jogadaDestruidoDTO jogadaDestruidoDados = jogadaDestruidoDTO();
  static jogadaFimJogoDTO jogadaFimDados = jogadaFimJogoDTO();
  static exceptionDTO exceptionDados = new exceptionDTO();

  static void setconviteLDados(Map d){
    d.forEach((key, value) {
      if(d != 'message') {
        conviteLDados.idAmigo = d['data']['idAmigo'];
        conviteLDados.nome = d['data']['nome'];
        conviteLDados.idCenario = d['data']['idCenario'];
      }
    });
  }

  static conviteDTO getconviteLDados(){
    return conviteLDados;
  }

  static void setpartidaLRecusadaDados(Map d){
    d.forEach((key, value) {
      if(d != 'message') {
        partidaLRecusadaDados.idJogador = d['data']['idJogador'];
        partidaLRecusadaDados.nomeJogador = d['data']['nomeJogador'];
      }
    });
  }

  static partidaRecusadaDTO getpartidaLRecusadaDados(){
    return partidaLRecusadaDados;
  }

  static void setpartidaLAceitaDados(Map d){
    Map adversario = new Map();
    Map cenario = new Map();
    d.forEach((key, value) {
      if(d != 'message'){
        adversario = d['data']['adversario'];
        cenario = d['data']['cenario'];
        partidaAleatoriaDados.idPartida = d['data']['idPartida'];
        idPartida = partidaAleatoriaDados.idPartida = d['data']['idPartida'];
      }
    });
    partidaAleatoriaDados.idAdversario = adversario['id'];
    partidaAleatoriaDados.elo = adversario['elo'].toString();
    partidaAleatoriaDados.nacionalidade = adversario['nacionalidade'];
    partidaAleatoriaDados.nomeAdversario = adversario['name'];
    partidaAleatoriaDados.idCenario = cenario['idCenario'];
    partidaAleatoriaDados.foto = cenario['foto'];
    partidaAleatoriaDados.nomeCenario = cenario['nome'];
    partidaAleatoriaDados.descricaoCenario = cenario['descricao'];
    idCenario = partidaAleatoriaDados.idCenario = cenario['idCenario'];
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

  static partidaAleatoriaDTO getpartidaLAceitaDados(){
    return partidaLAceitaDados;
  }

  static void setiniciarJogoDados(Map d, iniciarJogoCallBack){
    iniciarJogoDados.proximoPlayer = d['proximoPlayer'];
    iniciarJogoCallBack(iniciarJogoDados);
  }

  void getiniciarJogoDados(){
    socket.emit("enviar dados", {
      'userId': '3d15f205-8d5e-4e41-a981-0090e345b68c',
      'idCenario': '7a7ee764-bf9b-4fbc-916c-020568e8e032',
      'idPartida': '5dba3c90-47aa-4c2a-8917-90d27279b987'});

  }

  static void setjogadaDados(Map d){
    Map posicoes = new Map();

    d.forEach((key, value) {
      if(d != 'message') {
        if (d.containsKey('status') == false) {
          jogadaFimDados.status = d['perdedor']['status'];
          jogadaFimDados.message = d['perdedor']['message'];
          jogadaFimDados.jogo.partida.idPartida = d['perdedor']['jogo']['partida']['idPartida'];
          jogadaFimDados.jogo.partida.vencedor.id = d['perdedor']['jogo']['partida']['vencedor']['id'];
          jogadaFimDados.jogo.partida.vencedor.nome = d['perdedor']['jogo']['partida']['vencedor']['nome'];
          jogadaFimDados.jogo.partida.vencedor.elo = d['perdedor']['jogo']['partida']['vencedor']['elo'].toString();
          jogadaFimDados.jogo.partida.vencedor.nacionalidade = d['perdedor']['jogo']['partida']['vencedor']['nacionalidade'];
          jogadaFimDados.jogo.partida.vencedor.cenario.idCenario = d['perdedor']['jogo']['partida']['vencedor']['cenario']['idCenario'];
          jogadaFimDados.jogo.partida.vencedor.cenario.nome = d['perdedor']['jogo']['partida']['vencedor']['cenario']['nome'];
          jogadaFimDados.jogo.partida.vencedor.cenario.descricao = d['perdedor']['jogo']['partida']['vencedor']['cenario']['descricao'];
          jogadaFimDados.jogo.partida.vencedor.cenario.foto = d['perdedor']['jogo']['partida']['vencedor']['cenario']['foto'];
          jogadaFimDados.jogo.adversario.jogador.id = d['perdedor']['jogo']['adversario']['jogador']['id'];
          jogadaFimDados.jogo.adversario.jogador.nome = d['perdedor']['jogo']['adversario']['jogador']['nome'];
          jogadaFimDados.jogo.adversario.jogador.elo = d['perdedor']['jogo']['adversario']['jogador']['elo'].toString();
          jogadaFimDados.jogo.adversario.jogador.nacionalidade = d['perdedor']['jogo']['adversario']['jogador']['nacionalidade'];
          jogadaFimDados.jogo.adversario.jogador.cenario.idCenario = d['perdedor']['jogo']['adversario']['jogador']['cenario']['idCenario'];
          jogadaFimDados.jogo.adversario.jogador.cenario.nome = d['perdedor']['jogo']['adversario']['jogador']['cenario']['nome'];
          jogadaFimDados.jogo.adversario.jogador.cenario.descricao = d['perdedor']['jogo']['adversario']['jogador']['cenario']['descricao'];
          jogadaFimDados.jogo.adversario.jogador.cenario.foto = d['perdedor']['jogo']['adversario']['jogador']['cenario']['foto'];
          d['perdedor']['jogo']['adversario']['barcos'].forEach((barc) {
            barcosPerdedorDTO barcoPerdedor = new barcosPerdedorDTO();
            barcoPerdedor.destruido = barc['destruido'];
            barcoPerdedor.barco.IDBarco = barc['barco']['IDBarco'];
            barcoPerdedor.barco.nomeBarco = barc['barco']['nome'];
            barcoPerdedor.barco.tamanho = barc['barco']['tamanho'];
            barcoPerdedor.barco.foto1 = barc['barco']['foto1'];
            barcoPerdedor.barco.foto2 = barc['barco']['foto2'];
            barcoPerdedor.barco.foto3 = barc['barco']['foto3'];
            barcoPerdedor.barco.foto4 = barc['barco']['foto4'];
            barcoPerdedor.barco.foto5 = barc['barco']['foto5'];
            barc['posicoes'].forEach((pos) {
              posicoesDTO posic = new posicoesDTO();
              posic.idPartesBarcoJogo = pos['idPartesBarcoJogo'];
              posic.idBarcoPartida = pos['idBarcoPartida'];
              posic.foto = pos['foto'];
              posic.eixoX = pos['eixoX'];
              posic.eixoY = pos['eixoY'];
              posic.atingido = pos['atingido'];
              barcoPerdedor.posicoes.add(posic);
            });
          });
          return;
        }
        if(d['status'] == '00' || d['status'] == '01'){
          jogadaTiroDados.status = d['status'];
          jogadaTiroDados.message = d['message'];
          jogadaTiroDados.eixox = d['eixoX'];
          jogadaTiroDados.eixoy = d['eixoY'];
        }
        if(d['status'] == '02'){
          jogadaDestruidoDados.status = d['status'];
          jogadaDestruidoDados.message = d['message'];
          jogadaDestruidoDados.barcoDestruido.destruido = d['barcoDestruido']['destruido'];
          jogadaDestruidoDados.barcoDestruido.barco.IDBarco = d['barcoDestruido']['barco']['IDBarco'];
          jogadaDestruidoDados.barcoDestruido.barco.nomeBarco = d['barcoDestruido']['barco']['nome'];
          jogadaDestruidoDados.barcoDestruido.barco.tamanho = d['barcoDestruido']['barco']['tamanho'];
          jogadaDestruidoDados.barcoDestruido.barco.foto1 = d['barcoDestruido']['barco']['foto1'];
          jogadaDestruidoDados.barcoDestruido.barco.foto2 = d['barcoDestruido']['barco']['foto2'];
          jogadaDestruidoDados.barcoDestruido.barco.foto3 = d['barcoDestruido']['barco']['foto3'];
          jogadaDestruidoDados.barcoDestruido.barco.foto4 = d['barcoDestruido']['barco']['foto4'];
          jogadaDestruidoDados.barcoDestruido.barco.foto5 = d['barcoDestruido']['barco']['foto5'];
          d['barcoDestruido']['posicoes'].forEach((posic) {
            posicoesDTO position = new posicoesDTO();
            position.idPartesBarcoJogo = posic['idPartesBarcoJogo'];
            position.idBarcoPartida = posic['idBarcoPartida'];
            position.foto = posic['foto'];
            position.eixoX = posic['eixoX'];
            position.eixoY = posic['eixoY'];
            position.atingido = posic['atingido'];
            jogadaDestruidoDados.barcoDestruido.posicoes.add(position);
          });
        }
      }
    });
  }

  static void setexceptionDados(Map d){
    d.forEach((key, value) {
      if(d != 'message') {
        exceptionDados.mensagem = d['mensagem'];
        exceptionDados.codigoStatus = d['codigoStatus'];
      }
    });
  }

  static exceptionDTO getexceptionDados(){
    return exceptionDados;
  }

  static void setpartidaAleatoriaDados(Map d, partidaLCallback){
    Map adversario = new Map();
    Map cenario = new Map();
    d.forEach((key, value) {
      if(d != 'message'){
        adversario = d['data']['adversario'];
        cenario = d['data']['cenario'];
        partidaAleatoriaDados.idPartida = d['data']['idPartida'];
        idPartida = partidaAleatoriaDados.idPartida = d['data']['idPartida'];
      }
    });
    partidaAleatoriaDados.idAdversario = adversario['id'];
    partidaAleatoriaDados.elo = adversario['elo'].toString();
    partidaAleatoriaDados.nacionalidade = adversario['nacionalidade'];
    partidaAleatoriaDados.nomeAdversario = adversario['name'];
    partidaAleatoriaDados.idCenario = cenario['idCenario'];
    partidaAleatoriaDados.foto = cenario['foto'];
    partidaAleatoriaDados.nomeCenario = cenario['nome'];
    partidaAleatoriaDados.descricaoCenario = cenario['descricao'];
    idCenario = partidaAleatoriaDados.idCenario = cenario['idCenario'];
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
    partidaLCallback(partidaAleatoriaDados);
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

  void login(String user) {
    socket.emit('user id', {'userId': user});
    userId = user;
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

  void partidaL(partidaLCallback){
    socket.on('partida aleatoria encontrada', (dados)=> setpartidaAleatoriaDados(dados, partidaLCallback));
  }

  void conviteL(){
    socket.on('convite de partida', (dados)=> setconviteLDados(dados));
  }

  void partidaLRecusada(){
    socket.on('partida recusada', (dados)=> setpartidaLRecusadaDados(dados));
  }

  void partidaLAceita(){
    socket.on('partida aceita', (dados)=> setpartidaLAceitaDados(dados));
  }

  void iniciarJogo(iniciarJogoCallBack){
    socket.on('iniciar jogo', (dados)=> setiniciarJogoDados(dados, iniciarJogoCallBack));
  }

  void jogada(){
    socket.on('jogada', (dados)=> setjogadaDados(dados));
  }

  void exception(){
    socket.on('exception', (dados)=> setexceptionDados(dados));
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
    partidaLRecusada();
    partidaLAceita();
    conviteL();
    reconnect();
    exception();
  }

}