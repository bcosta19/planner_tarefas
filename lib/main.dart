import 'package:flutter/material.dart';

import 'package:planner_tarefas/pages/Login.dart';
import 'package:planner_tarefas/pages/DashBoard.dart';
import 'pages/Tasks.dart';
import 'pages/Search.dart';
import 'pages/RecentsTasks.dart';
import 'pages/CompleteTasks.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main(){
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
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