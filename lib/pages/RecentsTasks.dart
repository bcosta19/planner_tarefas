import 'package:flutter/material.dart';
import 'package:planner_tarefas/controller/TaskController.dart';
import 'package:planner_tarefas/model/Task.dart';

class RecentsTasks extends StatefulWidget {
  late int usuarioId;
  
  RecentsTasks(int id, {super.key}){
    usuarioId = id;
  }



  @override
  State<RecentsTasks> createState () => _RecentsTasks(usuarioId); 
}

class _RecentsTasks extends State<RecentsTasks>{
  late int usuarioId;
  final TaskController _taskController = TaskController();
  _RecentsTasks(int id){
    usuarioId = id;
  }

  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Tarefas recentes"),
      ),
      body: FutureBuilder<List<Task>>(
        future: _taskController.getRecentsTasks(usuarioId),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }else if(snapshot.hasError){
            return Text('Erro: ${snapshot.error.toString()}');
          }else{
            List<Task> tasks = snapshot.data!;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index){
                print(tasks[index]);
                return ListTile(
                  title: Text(tasks[index].title),
                  subtitle: Text("${tasks[index].note}   |  Data de início: ${tasks[index].startTime}"),
                
                  
                );
              }
            );
          }
        },
      ),
    );
  }
}