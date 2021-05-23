import 'package:ListTodo/DataBase/Crud.dart';

class Todos {
  int id;
  String nome;
  String isDone;
  String desc;
  String date;

  map() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['nome'] = nome;
    mapping["isDone"] = isDone;
    mapping['desc'] = desc;
    mapping['date'] = date;
    return mapping;
  }
}

class TodosService {
  CrudBase crudBase = CrudBase();

  insert(Todos todos) async {
    print("inserido");
    return await crudBase.insert("todos", todos.map());
  }

  readAll() async {
    return await crudBase.readAll("todos");
  }

  readAllUser() async {
    return await crudBase.readAll("usuario");
  }

  deleteTodo(dado) async {
    return await crudBase.delete("todos", dado);
  }

  update(
    todos,
  ) async {
    return await crudBase.update("todos", todos.map());
  }

  deleteAll() async {
    return await crudBase.deleteAll();
  }
}

class User {
  String nome;
  String pin;

  mapUser() {
    var mapping = Map<String, dynamic>();

    mapping['nome'] = nome;

    mapping['pin'] = pin;
    return mapping;
  }
}
