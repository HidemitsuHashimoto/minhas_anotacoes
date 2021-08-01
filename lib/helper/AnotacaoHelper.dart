import 'package:minhas_anotacoes/model/Anotacao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AnotacaoHelper {
  static AnotacaoHelper _anotacaoHelper = AnotacaoHelper._();
  Database? _db;
  final String nomeTabela = 'anotacao';

  AnotacaoHelper._();

  static AnotacaoHelper get instance {
    return _anotacaoHelper;
  }

  Future<Database> get db async {
    if (_db == null) {
      _db = await _inicializarDB();
    }
    return _db!;
  }

  _onCreate(Database db, int version) async {
    String sql =
        'CREATE TABLE $nomeTabela (id INTEGER PRIMARY KEY AUTOINCREMENT, titulo VARCHAR, descricao TEXT, data DATETIME)';
    await db.execute(sql);
  }

  _inicializarDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados =
        join(caminhoBancoDados, 'banco_minhas_anotacoes.db');

    return await openDatabase(localBancoDados, version: 1, onCreate: _onCreate);
  }

  Future<int> salvarAnotacao(Anotacao anotacao) async {
    var bancoDados = await db;
    return await bancoDados.insert(nomeTabela, anotacao.toMap());
  }

  Future<List> recuperarAnotacoes() async {
    var bancoDados = await db;
    String sql = 'SELECT * FROM $nomeTabela ORDER BY data DESC';
    List anotacoes = await bancoDados.rawQuery(sql);
    return anotacoes;
  }

  Future<int> autalizarAnotacao(Anotacao anotacao) async {
    var bancoDados = await db;
    return await bancoDados.update(
      nomeTabela,
      anotacao.toMap(),
      where: 'id = ?',
      whereArgs: [anotacao.id],
    );
  }

  Future<int> removerAnotacao(int id) async {
    var bancoDados = await db;
    return await bancoDados.delete(
      nomeTabela,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
