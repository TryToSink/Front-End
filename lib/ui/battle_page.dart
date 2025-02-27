import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:proj0511/DTO/jogadaFimJogoDTO.dart';
import 'package:proj0511/DTO/posicoesDTO.dart';
import 'package:proj0511/posicao.dart';
import 'package:http/http.dart' as http;
import 'package:proj0511/rotas.dart';
import 'package:proj0511/ui/home.dart';
import 'package:proj0511/ui/derrota_page.dart';
import 'package:proj0511/ui/barcos_dto.dart';
import 'package:proj0511/ui/socket_connect.dart';
import 'package:proj0511/ui/vitoria_page.dart';
import '../timer.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';

class BatlePage extends StatefulWidget {
  Posicao posicao = Posicao();
  List _aCampo = [];
  List _mCampo = [];
  String idProximoPlayer;

  BatlePage(this._mCampo, this._aCampo, this.idProximoPlayer);

  @override
  _BatlePageState createState() => _BatlePageState();
}

class _BatlePageState extends State<BatlePage> {
  // declaracao das variaveis
  List _advCampo = [];
  List _meuCampo = [];
  String meuNome = "Meu nome";

  //  vvvvvvvvv Controle do grid
  bool _valid = false;

  Color corFundo = Color(0xff75CCFE);

  List currentUser = [];
  List advUser = [];
  final degress = 90.0;
  double gridSize = 0.0;
  double linhaColuna = 10;

  //inicio da pagina

  @override
  void initState() {
    super.initState();

    _advCampo = widget._aCampo;
    _meuCampo = widget._mCampo;

    getName().then((nome) {
      meuNome = nome;
    });

    print("meu nome: ${meuNome}");
    setCurrentUser(5649, "${meuNome} (321)", "");
    setAdvUser(
        5650,
        "${socketConnect.partidaAleatoriaDados.nomeAdversario} (${socketConnect.partidaAleatoriaDados.elo})",
        "");

    if (sqrt(_advCampo.length) == 8)
      gridSize = 0.10;
    else if (sqrt(_advCampo.length) == 10)
      gridSize = 0.08;
    else
      gridSize = 0.06;
    linhaColuna = sqrt(_advCampo.length);
    startTimer();

    _valid = false;

    if (socketConnect.userId == widget.idProximoPlayer) {
      Future<Null>.delayed(Duration.zero, () {
        msgSnack("Você começa", 4);
      });

      _valid = true;
    }

    socketConnect().jogada((jogadaOponente) {
      int eixox;
      int eixoy;
      if (jogadaOponente is jogadaFimJogoDTO) {
        print("Fim de jogo");
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Derrota(),
            ));
      } else if (jogadaOponente.status == '00' ||
          jogadaOponente.status == '01') {
        eixox = jogadaOponente.eixox;
        eixoy = jogadaOponente.eixoy;
        receberAtaque(eixox, eixoy, jogadaOponente.status);
      } else if (jogadaOponente.status == '02') {
        for (posicoesDTO x in jogadaOponente.barcoDestruido.posicoes) {
          msgSnack("Você Afundou Um Navio", 4);
          eixox = x.eixoX;
          eixoy = x.eixoY;
          receberAtaque(eixox, eixoy, jogadaOponente.status);
        }
      }

      print("oponente jogou");
      if (jogadaOponente.status == "00") meuTurno();
    });
  }

  void receberAtaque(int eixoX, int eixoY, String ataque) {
    for (int i = 0; i < _meuCampo.length; i++) {
      if (_meuCampo[i]["linha"] == eixoX && _meuCampo[i]["coluna"] == eixoY) {
        print("receber ataque: $ataque");
        print("eixox: $eixoX");
        print(_meuCampo[i]["status"]);
        if (ataque == "00") {
          setState(() {
            _meuCampo[i]["image"] = "assets/water.png";
            _meuCampo[i]["ataque"] = ataque;
          });
        } else if (ataque == "01" || ataque == "02") {
          setState(() {
            _meuCampo[i]["image"] = "assets/explosion.png";
            _meuCampo[i]["ataque"] = ataque;
          });
        }
      }
    }
  }

  Future<String> getName() async {
    var url = url1 + '/usuarios/find?id=' + socketConnect.userId;
    var header = {"Content-Type": "application/json"};
    var response = await http.get(Uri.parse(url), headers: header);
    List jsonData = json.decode("[" + response.body + "]");
    print("Retorno getNema: ${jsonData[0]["name"]}");
    return jsonData[0]["name"];
  }

  Future<String> enviarJogada(String idPart, String idAdv, Posicao pos) async {
    var url = url1 + '/jogada';
    var header = {"Content-Type": "application/json"};
    Map params = {
      "idPartida": idPart,
      "idAdversario": idAdv,
      "eixoX": pos.eixoX,
      "eixoY": pos.eixoY
    };

    var _body = json.encode(params);
    var respon = await http.post(Uri.parse(url), headers: header, body: _body);
    print(respon);
    List jsonData = json.decode("[" + respon.body + "]");
    print('Response: ');
    print(jsonData);
    try {
      if (jsonData[0].containsKey('status') == true) {
        return jsonData[0]["status"];
      } else {
        return jsonData[0]["vencedor"]["status"];
      }
    } catch (error) {
      print(error);
      return "00";
    }
  }

  void jogada(
      int index, String idPartida, String idAdversario, Posicao pos) async {
    String result = await enviarJogada(idPartida, idAdversario, pos);
    print("Result 2p:" + result);
    if (result == '00') {
      setState(() {
        _advCampo[index]["image"] = "assets/water.png";
      });
      oponenteTurno();
    } else if (result == '01' || result == '02') {
      setState(() {
        _advCampo[index]["image"] = "assets/fire.png";
      });
      meuTurno();
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Vitoria(),
          ));
    }
  }

  void meuTurno() {
    setState(() {
      _valid = true;
    });
    msgSnack("Seu turno", 1);
  }

  void oponenteTurno() async {
    setState(() {
      _valid = false;
    });

    msgSnack("Turno do oponente", 1);
  }

  void msgSnack(String msg, int temp) {
    final snackBar = SnackBar(
      content: Text(msg),
      duration: Duration(seconds: temp),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //auxiliar para usuário
  void setCurrentUser(int id, String name, String image) {
    setState(() {
      Map<String, dynamic> newUser = Map();
      newUser["id"] = id;
      newUser["name"] = name;
      newUser["image"] = image;

      currentUser.add(newUser);
    });
  }

  //auxiliar para usuário
  void setAdvUser(int id, String name, String image) {
    setState(() {
      Map<String, dynamic> newUser = Map();
      newUser["id"] = id;
      newUser["name"] = name;
      newUser["image"] = image;

      advUser.add(newUser);
    });
  }

  // montar grid usuario
  Widget buildFieldMeuCampo(BuildContext context, int index) {
    return Container(
        color: corFundo,
        child: _meuCampo[index]["rotacao"]
            ? Transform.rotate(
                angle: degress * pi / 180,
                child: BarcosDTO.getFotoBattle(
                    _meuCampo[index]["ataque"], _meuCampo[index]["image"]))
            : BarcosDTO.getFotoBattle(
                _meuCampo[index]["ataque"], _meuCampo[index]["image"]));
  }

  // montar grid de ataque
  Widget buildFieldAdvCampo(BuildContext context, int index) {
    return GestureDetector(
      onTap: _valid
          ? () {
              setState(() {
                //
                Posicao ataq = Posicao();
                ataq.eixoY = _advCampo[index]["coluna"];
                ataq.eixoX = _advCampo[index]["linha"];
                _advCampo[index]["status"] = true;
                print(
                    "Cordenadas a enviar: Eixo x = ${ataq.eixoX} e Eixo Y = ${ataq.eixoY}");
                jogada(index, socketConnect.idPartida,
                    socketConnect.partidaAleatoriaDados.idAdversario, ataq);
              });
            }
          : null,
      child: Container(
          color: const Color(0xff75CCFE),
          child: _advCampo[index]["status"]
              ? _advCampo[index]["rotacao"]
                  ? Transform.rotate(
                      angle: degress * pi / 180,
                      child: Image.asset(
                        "${_advCampo[index]["image"]}",
                        fit: BoxFit.fill,
                      ),
                    )
                  : Image.asset(
                      "${_advCampo[index]["image"]}",
                      fit: BoxFit.fill,
                    )
              : null),
    );
  }

  //cronometro
  void startTimer() {
    time = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (mins == 0 && seconds == 0)
          time?.cancel();
        else if (seconds == 0) {
          mins--;
          seconds = maxSeconds;
        } else
          seconds--;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff293241),
        title: const Text("Batle Page"),
        centerTitle: true,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (_, constraint) {
          return Column(
            children: [
              Container(
                height: constraint.maxHeight * 0.15,
                width: constraint.maxWidth,
                decoration: const BoxDecoration(
                    color: Color(0xff293241),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: constraint.maxHeight * 0.1,
                      width: constraint.maxWidth * 0.1,
                      color: Colors.black,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(meuNome,
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        const Divider(),
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 30,
                              color: Colors.green,
                            ),
                            const VerticalDivider(),
                            const Text("Brasil",
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 16))
                          ],
                        )
                      ],
                    ),
                    timer()
                  ],
                ),
              ),
              SizedBox(
                height: constraint.maxHeight * 0.7,
                width: constraint.maxWidth,
                child: LayoutBuilder(
                  builder: (_, constraint2) {
                    return Column(
                      children: [
                        SizedBox(
                          width: constraint2.maxWidth * 0.95,
                          height: constraint2.maxHeight * 0.4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: SizedBox(
                                    height: constraint2.maxHeight * 0.6,
                                    width: constraint2.maxWidth * 0.4,
                                    child: GridView.builder(
                                      itemCount: _meuCampo.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisExtent:
                                                  constraint2.maxHeight *
                                                      (gridSize / 2.7),
                                              mainAxisSpacing:
                                                  constraint2.maxHeight * 0.003,
                                              crossAxisSpacing:
                                                  constraint2.maxHeight * 0.003,
                                              crossAxisCount:
                                                  linhaColuna.toInt()),
                                      itemBuilder: buildFieldMeuCampo,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      height: constraint2.maxHeight * 0.07,
                                      width: constraint2.maxWidth * 0.4,
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text("Aleatório"),
                                          style: ElevatedButton.styleFrom(
                                              primary: Color(0xff3D5A80))),
                                    ),
                                    SizedBox(
                                      height: constraint2.maxHeight * 0.07,
                                      width: constraint2.maxWidth * 0.4,
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text("Configurações"),
                                          style: ElevatedButton.styleFrom(
                                              primary: Color(0xff3D5A80))),
                                    ),
                                    SizedBox(
                                      height: constraint2.maxHeight * 0.07,
                                      width: constraint2.maxWidth * 0.4,
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text("Desistir"),
                                          style: ElevatedButton.styleFrom(
                                              primary: Color(0xff3D5A80))),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: constraint2.maxWidth,
                          height: constraint2.maxHeight * 0.6,
                          child: LayoutBuilder(
                            builder: (_, constraint3) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, right: 20, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: constraint3.maxHeight,
                                      width: constraint3.maxWidth * 0.75,
                                      child: GridView.builder(
                                        itemCount: _advCampo.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisExtent:
                                                    constraint3.maxHeight *
                                                        gridSize,
                                                mainAxisSpacing: constraint3
                                                        .maxHeight *
                                                    0.005,
                                                crossAxisSpacing:
                                                    constraint3.maxHeight *
                                                        0.005,
                                                crossAxisCount:
                                                    linhaColuna.toInt()),
                                        itemBuilder: buildFieldAdvCampo,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              Container(
                height: constraint.maxHeight * 0.15,
                width: constraint.maxWidth,
                decoration: const BoxDecoration(
                    color: Color(0xff293241),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: constraint.maxHeight * 0.1,
                      width: constraint.maxHeight * 0.1,
                      color: Colors.black,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${advUser[0]["name"]}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20)),
                        const Divider(),
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 30,
                              color: Colors.green,
                            ),
                            const VerticalDivider(),
                            const Text("Brasil",
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 16))
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 45,
                      width: 45,
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
