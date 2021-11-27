// @dart=2.9
class PostDart {
  String idModoJogo;
  String nome;
  String descricao;
  int duracao;
  bool ativo;
  Null foto;
  List<Cenarios> cenarios;
  PostDart(
      {this.idModoJogo,
      this.nome,
      this.descricao,
      this.duracao,
      this.ativo,
      this.foto,
      this.cenarios});

  PostDart.fromJson(Map<String, dynamic> json) {
    idModoJogo = json['idModoJogo'];
    nome = json['nome'];
    descricao = json['descricao'];
    duracao = json['duracao'];
    ativo = json['ativo'];
    foto = json['foto'];
    if (json['cenarios'] != null) {
      cenarios = new List<Cenarios>();
      json['cenarios'].forEach((v) {
        cenarios.add(new Cenarios.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idModoJogo'] = this.idModoJogo;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['duracao'] = duracao;
    data['ativo'] = ativo;
    data['foto'] = foto;
    if (this.cenarios != null) {
      data['cenarios'] = this.cenarios.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cenarios {
  String idCenario;
  String nome;
  String descricao;
  List<Barcos> barcos;
  String foto;

  Cenarios({this.idCenario, this.nome, this.descricao, this.barcos, this.foto});

  Cenarios.fromJson(Map<String, dynamic> json) {
    idCenario = json['idCenario'];
    nome = json['nome'];
    descricao = json['descricao'];
    if (json['barcos'] != null) {
      barcos = new List<Barcos>();
      json['barcos'].forEach((v) {
        barcos.add(new Barcos.fromJson(v));
      });
    }
    foto = json['foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idCenario'] = this.idCenario;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    if (this.barcos != null) {
      data['barcos'] = this.barcos.map((v) => v.toJson()).toList();
    }
    data['foto'] = this.foto;
    return data;
  }
}

class Barcos {
  String iDBarco;
  String nome;
  int tamanho;
  String foto;

  Barcos({this.iDBarco, this.nome, this.tamanho, this.foto});

  Barcos.fromJson(Map<String, dynamic> json) {
    iDBarco = json['IDBarco'];
    nome = json['nome'];
    tamanho = json['tamanho'];
    foto = json['foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IDBarco'] = this.iDBarco;
    data['nome'] = this.nome;
    data['tamanho'] = this.tamanho;
    data['foto'] = this.foto;
    return data;
  }
}
