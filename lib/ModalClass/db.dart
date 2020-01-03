import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:login_flutter_app/ModalClass/todo_model.dart';


const rTodosStatusActive = 0;
const rTodosStatusDone = 1;

const rDatabaseName = 'todos.db';
const rDatabaseVersion = 1;
const rSQLCreateStatement = '''
CREATE TABLE "todos"(
   "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "title" TEXT NOT NULL,
	 "created" text NOT NULL,
	 "updated" TEXT NOT NULL,
	 "status" integer DEFAULT $rTodosStatusActive
 );
''';

const rTableTodos = 'todos';

class DB {
  DB._();
  static final DB sharedInstance = DB._();

  Database _database;
  Future<Database> get database async {
    return _database ?? await initDB();
  }

  Future<Database> initDB() async {
    Directory docsDirectory = await getApplicationDocumentsDirectory();
    String path = join(docsDirectory.path, rDatabaseName);

    return await openDatabase(path, version: rDatabaseVersion,
        onCreate: (Database db, int version) async{
      await db.execute(rSQLCreateStatement);
        });
  }
  
  void createTodo(Todo todo) async {
    final db = await database;
    await db.insert(rTableTodos, todo.toMapAutoID());
  }
  
  void updateTodo(Todo todo) async {
    final db  = await database;
    await db.update(rTableTodos, todo.toMap(), where: 'id=?', whereArgs: [todo.id]);
  }
  
  void deleteTodo(Todo todo) async {
    final db = await database;
    await db.delete(rTableTodos, where: 'id=?', whereArgs: [todo.id]);
  }
  
  void deleteAllTodo({int status = rTodosStatusDone}) async {
    final db = await database;
    await db.delete(rTableTodos, where: 'status=?', whereArgs: [status]);
  }
  
  Future<List<Todo>> retrieveTodos(
  {TodoStatus status = TodoStatus.active}) async {
    
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(rTableTodos, where: 'status=?', whereArgs: [status.index], orderBy: 'updated ASC');

    return List.generate(maps.length, (i){
      return Todo(
        id: maps[i]['id'],
        title: maps[i]['title'],
        created: DateTime.parse(maps[i]['created']),
        updated: DateTime.parse(maps[i]['updated']),
        status: maps[i]['status'],
      );
    });
  }
  
}