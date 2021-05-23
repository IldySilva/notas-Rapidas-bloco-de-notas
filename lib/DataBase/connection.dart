import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseConnection {
  setDataBase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, "Database");

    var dataBase = openDatabase(path, version: 1, onCreate: oncreate);
    debugPrint(
      "Base de Dados encontrada",
    );
    return dataBase;
  }

  oncreate(Database database, int version) async {
    await database.execute(
      "Create table todos(id integer primary key,nome Text,isDone text,desc Text,date Text);",
    );
    await database.execute(
        "Create table usuario(id integer primary key,nome Text,pin text)");

    debugPrint(
      "Base de Dados Criada",
    );
  }
}
