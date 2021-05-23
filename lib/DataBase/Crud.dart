import 'package:ListTodo/DataBase/connection.dart';
import 'package:sqflite/sqflite.dart';

class CrudBase {
  DataBaseConnection connection = DataBaseConnection();
  Database database;

  Future<Database> get data async {
    if (database != null) return database;
    database = await connection.setDataBase();
    return database;
  }

  readAll(table) async {
    var conection = await data;

    return await conection.query(table);
  }

  // delete(table, id) async {
  //   var conection = await data;

  //   return await conection.rawDelete("delete from $table where id=$id");
  // }

  insert(table, dados) async {
    var conection = await data;

    return await conection.insert(table, dados);
  }

  delete(table, dados) async {
    var connection = await data;
    return await connection.delete(
      table,
      where: "id=${dados.id} ",
    );
  }

  update(
    table,
    dados,
  ) async {
    var conection = await data;
    return await conection
        .update(table, dados, where: 'id=?', whereArgs: [dados['id']]);
  }

  deleteAll() async {
    var conection = await data;

    return await conection.execute("delete from todos");
  }

  insertName(dados) async {
    var connection = await data;
    await connection.execute("delete from  usuario");
    print("okayy");
    return await connection.insert("usuario", dados);
  }

  readName() async {
    var conection = await data;

    return await conection.query('usuario');
  }
}
