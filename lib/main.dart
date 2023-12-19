import 'package:flutter/material.dart';

import 'package:planner_tarefas/Login.dart';
import 'package:planner_tarefas/DashBoard.dart';
import 'Tasks.dart';
import 'Search.dart';
import 'RecentsTasks.dart';
import 'CompleteTasks.dart';

void main(){
  runApp(MaterialApp(
    title: "Planner",
    initialRoute: '/login',
    routes: {
      '/login': (context) => Login(),
      '/dashboard': (context) => DashBoard(),
      '/task': (context) => Tasks(),
      '/search': (context) => Search(),
      '/recentsTasks': (context) => RecentsTasks(),
      '/completeTasks': (context) => CompleteTasks(),
    }

  ));
}