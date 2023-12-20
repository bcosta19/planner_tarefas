import 'package:flutter/material.dart';
import 'package:planner_tarefas/controller/TaskController.dart';
import 'package:planner_tarefas/model/Task.dart';

class CompleteTasks extends StatefulWidget {
  CompleteTasks(int id, {super.key}){
    usuarioId = id;
  }

  late int usuarioId, taskBoardId;
  @override
  State<CompleteTasks> createState () => _CompleteTasks(usuarioId); 
}

class _CompleteTasks extends State<CompleteTasks>{
  
  late int usuarioId, taskBoardId;
  TaskController taskController = TaskController();
  _CompleteTasks(int id){
    usuarioId = id;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Tarefas concluídas"),
      ),
      body: FutureBuilder<List<Task>>(
        future: taskController.getCompleteTasks(usuarioId),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }else if (snapshot.hasError){
            return Text('Erro: ${snapshot.error.toString()}');
          }else{
            List<Task> tasks = snapshot.data!;

            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index].title),
                  subtitle: Text(tasks[index].note),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: tasks[index].isCompleted == 1 ? true : false,
                        onChanged: (value) async{
                          await taskController.markTaskAsComplete(tasks[index]);
                          setState(() {
                            
                          });
                        },
                        ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async { 
                          await taskController.deleteTask(tasks[index]);
                          setState(() {
                            tasks.remove(tasks[index]);
                          });
                          },)
                    ],
                  ),
                );
              },
            );
          }

        },
      ),
    );
  }
}