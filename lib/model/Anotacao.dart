class Anotacao {
  int? id;
  late String titulo;
  late String descricao;
  late String data;

  Anotacao({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.data,
  });

  Anotacao.fromMap(Map map) {
    this.id = map['id'];
    this.titulo = map['titulo'];
    this.descricao = map['descricao'];
    this.data = map['data'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'titulo': this.titulo,
      'descricao': this.descricao,
      'data': this.data,
    };

    if (this.id != null) {
      map['id'] = this.id;
    }

    return map;
  }
}
