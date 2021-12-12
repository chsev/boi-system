import 'package:boi_system/model/boi.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class BoiDAO {
  Database database;
  BoiDAO(this.database);

  Future<void> inserir(Boi boi) async {
    await database.insert(
      "tb_boi",
      boi.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Boi>> obterTodos() async {
    final List<Map<String, dynamic>> maps = await database.query("tb_boi");
    return Boi.fromMaps(maps);
  }

  Future<Boi?> obterPorId(int id) async {
    final List<Map<String, dynamic>> maps =
        await database.query("tb_boi", where: "boi_id = ?", whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Boi.fromMap(maps.first);
    }
    return null;
  }

  Future<void> atualizar(Boi boi) async {
    await database.update("tb_boi", boi.toMap(),
        where: "boi_id = ?", whereArgs: [boi.id]);
  }

  Future<void> remover(int id) async {
    await database.delete("tb_boi", where: "boi_id = ?", whereArgs: [id]);
  }
}
