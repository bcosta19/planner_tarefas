import 'package:flutter/material.dart';

import 'package:planner_tarefas/pages/Login.dart';
import 'package:planner_tarefas/pages/DashBoard.dart';
import 'pages/Tasks.dart';
import 'pages/Search.dart';
import 'pages/RecentsTasks.dart';
import 'pages/CompleteTasks.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main(){
  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Planner",
    initialRoute: '/login',
    routes: {
      '/login': (context) => const Login(),
      '/dashboard': (context) => DashBoard(0),
      '/task': (context) => Tasks(0, 0),
      '/search': (context) => const Search(),
      '/recentsTasks': (context) => const RecentsTasks(),
      '/completeTasks': (context) => const CompleteTasks(),
    }

  ));
}