import 'package:flutter/material.dart';
import 'package:planner_tarefas/controller/TaskController.dart';
import 'package:planner_tarefas/model/Task.dart';


class Tasks extends StatefulWidget {
  
  late int usuarioId, taskBoardId;
  Tasks(id, tbId, {super.key}){
    usuarioId = id;
    taskBoardId = tbId;
  }
  @override
  State<Tasks> createState () => _Tasks(usuarioId, taskBoardId); 
}

class _Tasks extends State<Tasks>{
  late int usuarioId, taskBoardId;
  final TaskController taskController = TaskController();

  _Tasks(id, tbId){
    usuarioId = id;
    taskBoardId = tbId;
  }
  
  @override
  Widget build(BuildContext context){
    print("${usuarioId} ${taskBoardId}");
    return Scaffold(
      appBar: AppBar(title: Text("Tarefas"),),
      body: FutureBuilder<List<Task>>(
        future: taskController.getAllTaskOfTaskBoards(usuarioId, taskBoardId),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }else if(snapshot.hasError){
            return Text('Erro: ${snapshot.error}');
          }else{
            List<Task> tasks = snapshot.data!;
            
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index){
                print(tasks.length);
                
                return ListTile(
                  title: Text(tasks[index].title),
                  subtitle: Text(tasks[index].note),
                );
              },
            );
          }
        },
      ),
    );
  }
}