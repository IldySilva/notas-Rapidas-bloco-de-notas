import 'package:ListTodo/DataBase/todosModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Crud extends GetxController {
  RxInt totalCriado = 0.obs;
  List<Todos> allTodos;
  var usuario;
  String nome = "";

  TodosService service = TodosService();
  Todos todos = Todos();
  List<Todos> todosFeitos;
  RxInt totalFeitos = 0.obs;
  User user = User();
  getAll() async {
    allTodos = List<Todos>();
    todosFeitos = List<Todos>();
    var todos = await service.readAll();

    todos.forEach((todo) {
      var todoAll = Todos();

      todoAll.id = todo["id"];
      todoAll.nome = todo['nome'];
      todoAll.isDone = todo['isDone'];
      todoAll.desc = todo["desc"];
      todoAll.date = todo["date"];
      if (todoAll.isDone == "sim") {
        todosFeitos.add(todoAll);
      }

      allTodos.add(todoAll);
    });
    totalCriado.value = allTodos.length;
    totalFeitos.value = todosFeitos.length;
    up();

    debugPrint("Lista de Todos Encontrados");
  }

  up() {
    Get.forceAppUpdate();
  }

  updating() async {
    await getAll();
  }

  getUser() async {
    var users = await service.readAllUser();

    users.forEach((user1) {
      var usuario = User();
      usuario.nome = user1['nome'];
      nome = usuario.nome;
    });

    print(user.nome);
  }

  Future<User> get getUsuario async {
    usuario = await service.crudBase.database.query("usuario");
    return usuario;
  }
}
