import 'package:flutter/material.dart';
import 'package:planner_tarefas/controller/TaskController.dart';
import 'package:planner_tarefas/model/Task.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState () => _DashBoard(); 
}

class _DashBoard extends State<Search>{
  TaskController taskController = TaskController();
  @override
  Widget build(BuildContext context){
    return Placeholder();
  }
}