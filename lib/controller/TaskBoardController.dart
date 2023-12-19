import 'package:planner_tarefas/helper/DataBaseHelper.dart';
import 'package:planner_tarefas/model/TaskBoard.dart';

class TaskBoardController{

  DatabaseHelper con = DatabaseHelper();
  int usuarioId = -1;
  
  Future<List<TaskBoard>> getTaskBoards() async{
    var db = await con.db;
    String sql = """SELECT * FROM task_board""";

    var res = await db.rawQuery(sql);

    List<TaskBoard> taskBoards = [];

    
    var r;
    for(r in res){
      taskBoards.add(TaskBoard.fromMap(r));
    }

    return taskBoards;
  }


}