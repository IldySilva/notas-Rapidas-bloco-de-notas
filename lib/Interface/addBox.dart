import 'package:ListTodo/DataBase/todosModel.dart';
import 'package:ListTodo/controller/Service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

TextEditingController nomeEditingController = TextEditingController();
TextEditingController descEditingController = TextEditingController();
Crud crud = Get.put(Crud());
TextEditingController nomePessoa = TextEditingController();
TextEditingController pinController = TextEditingController();
update() {
  crud.up();
}

addTodo(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(40)),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Nova Tarefa"),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(hintText: "Tarefa"),
                  controller: nomeEditingController,
                ),
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(hintText: "Descrição"),
                  controller: descEditingController,
                ),
                Container(
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: () async {
                      if (nomeEditingController.text.isNullOrBlank) {
                        Get.rawSnackbar(
                            message: "Preencha o Campo com Titulo da Tarefa",
                            duration: Duration(seconds: 1));
                      } else {
                        crud.todos.nome = nomeEditingController.text;
                        crud.todos.desc = descEditingController.text;

                        await crud.service.insert(crud.todos);

                        crud.todos = Todos();

                        await crud.updating();

                        nomeEditingController = TextEditingController();
                        descEditingController = TextEditingController();
                        Navigator.pop(context);
                        Get.rawSnackbar(
                            message: "Anotado", duration: Duration(seconds: 1));
                      }
                    },
                    child: Text(
                      "Guardar",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.green,
                  ),
                ),
                Container(
                    width: double.infinity,
                    child: FlatButton(
                        onPressed: () {
                          nomeEditingController = TextEditingController();
                          descEditingController = TextEditingController();
                          Navigator.pop(context);
                        },
                        child: Text("Cancelar"),
                        color: Colors.grey[400])),
              ],
            ),
          ),
        );
      });
}

showInfo(
  context,
  Todos dado,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: Align(
              alignment: Alignment.topCenter,
              child: Text(dado.nome != null ? dado.nome : "")),
          content: Text(dado.desc.isNullOrBlank ? "Sem descrição" : dado.desc),
          actions: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                height: Get.height / 20,
                child: FlatButton(
                  onPressed: () async {
                    dado.isDone = "sim";

                    await crud.service.update(dado);
                    dado = Todos();
                    await crud.updating();

                    Navigator.pop(context);
                  },
                  child: Text("Definir como Feito"),
                  color: Colors.green,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                height: Get.height / 20,
                child: FlatButton(
                  onPressed: () async {
                    await crud.updating();
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Ok",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.grey[400],
                ),
              ),
            ),
          ],
        );
      });
}

deleteBox(context, dados) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("Deseja Apagar esta nota da Lista?"),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancelar",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.grey[400],
            ),
            FlatButton(
              onPressed: () {
                crud.service.deleteTodo(dados);

                crud.updating();
                Navigator.pop(context);
                Get.rawSnackbar(
                    message: "Nota Apagada", duration: Duration(seconds: 1));
              },
              child: Text(
                "Apagar",
              ),
              color: Colors.green,
            ),
          ],
        );
      });
}

deleteAll(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("Deseja Deixar a Lista vazia?"),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancelar",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.grey[400],
            ),
            FlatButton(
              onPressed: () {
                crud.service.deleteAll();

                crud.updating();
                Navigator.pop(context);
                Get.rawSnackbar(
                    message: "Lista Esvaziada", duration: Duration(seconds: 1));
              },
              child: Text(
                "Apagar",
              ),
              color: Colors.green,
            ),
          ],
        );
      });
}

about(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AboutDialog(
          applicationName: "Faça-o",
        );
      });
}
