import 'package:flutter/material.dart';
import 'package:planner_tarefas/Login.dart';

void main(){
  runApp(MaterialApp(
    title: "Planner",
    initialRoute: '/',
    routes: {
      Login.get (context) => Login(),
    }

  ));
}