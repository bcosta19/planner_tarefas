import 'dart:convert';
import 'package:planner_tarefas/controller/TaskController.dart';


class TaskBoard {
  final int? id;
  final String name;
  final int color;
  late int qtdTask = -1;

  TaskBoard({this.id, required this.name, required this.color});
  
  void setQtdTask(int userId) async{
    TaskController tc = TaskController();
    this.qtdTask = await tc.getAllTaskOfTaskBoards(userId, id!);
    
  }



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": this.id,
      "name": this.name,
      "color": this.color
    };
  }

  factory TaskBoard.fromMap(Map<String, dynamic> map) {
    return TaskBoard(
        id: map["id"] ??= map["id"],
        name: map["name"] as String,
        color: map["color"] as int,
        );
  }

  String toJson() => jsonEncode(toMap());

  factory TaskBoard.fromJson(String source) => TaskBoard.fromMap(jsonDecode(source) as Map<String, dynamic>);
 
}
