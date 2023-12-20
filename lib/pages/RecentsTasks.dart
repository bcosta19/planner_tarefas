import 'package:flutter/material.dart';
import 'package:planner_tarefas/controller/TaskController.dart';

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
    return Placeholder();
  }
}