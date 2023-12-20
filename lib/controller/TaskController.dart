import 'package:planner_tarefas/helper/DataBaseHelper.dart';
import 'package:planner_tarefas/model/Task.dart';

class TaskController{
  DatabaseHelper con = DatabaseHelper();

  Future<int> addTask(Task task) async{
    var db = await con.db;
    int res = await db.insert('task', task.toMap());
    return res;
  }

  Future<int> deleteTask(Task task) async{
    var db = await con.db;
    int res = await db.delete("task", where: "id = ?", whereArgs: [task.id]);
    return res;
  }

  Future<Task> getTask(int id) async{
    var db = await con.db;
    String sql = """SELECT * FROM task WHERE id = ${id}""";
    var res = await db.rawQuery(sql);

    return Task.fromMap(res.first);
  }

  Future<void> markTaskAsComplete(Task task) async{
    var db = await con.db;
    var novoValor = task.isCompleted == 1? 0 : 1;

    
    await db.update('task', 
    {'isCompleted': novoValor},
    where: 'id = ?',
    whereArgs: [task.id]
    );
  }
  Future<List<Task>> getCompleteTasks(int usuarioId)async{
    var db = await con.db;
    String sql = """SELECT * FROM task WHERE user_id = ${usuarioId} AND isCompleted = 1""";
    var res = await db.rawQuery(sql);
    List<Task> list = res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }
  Future<void> updateTask(Task task, String newTitle, String newNote) async{
    var db = await con.db;
    await db.update(
        'task', 
        {'title': newTitle, 
        'note': newNote
        },
        where: 'id = ?',
        whereArgs: [task.id]
      );
  }
  Future<List<Task>> getAllTasksOfUser(int id) async {
    var db = await con.db;
    String sql = """SELECT * FROM task WHERE user_id = ${id}""";
    var res = await db.rawQuery(sql);
    List<Task> list = res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    
    return list;
  }

  Future<List<Task>> getAllTaskOfTaskBoards(int user_id, int board_id) async{
    var db = await con.db;
    String sql = """SELECT * FROM task WHERE user_id = ${user_id} AND board_id = ${board_id}""";
    var res = await db.rawQuery(sql);
    print(res.isNotEmpty);
    List<Task> list = res.isNotEmpty? res.map((c) {print(c); return Task.fromMap(c);}).toList() : [];
    print(list);
    return list;

  }

}