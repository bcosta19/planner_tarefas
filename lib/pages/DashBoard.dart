import 'package:flutter/material.dart';
import 'package:planner_tarefas/controller/TaskController.dart';

import 'package:planner_tarefas/model/TaskBoard.dart';
import 'package:planner_tarefas/controller/TaskBoardController.dart';

class DashBoard extends StatefulWidget {
 

  late int usuarioId;

  DashBoard(int id, {super.key}){
    this.usuarioId = id; 
  }
  
  @override
  State<DashBoard> createState () => _DashBoard(usuarioId); 
}

class _DashBoard extends State<DashBoard>{
  final TaskBoardController _taskBoardController = TaskBoardController();
  late TaskController _taskController;
  late int usuarioId; 
  _DashBoard(int id){
    this.usuarioId = id;
    _taskController = TaskController();
  }
  
  

  //final LoginController loginController = LoginContro();
  
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Aqui você pode adicionar lógica para cada opção do menu
              if (value == 'Deslogar') {

                // Implemente a lógica de deslogar aqui
              } else if (value == 'Pesquisar') {
                // Implemente a lógica de pesquisa aqui
              } else if (value == 'Tarefas Recentes') {
                // Implemente a lógica de tarefas recentes aqui
              } else if (value == 'Tarefas Concluídas') {
                // Implemente a lógica de tarefas concluídas aqui
              }
            },
            itemBuilder: (BuildContext context) {
              return ['Deslogar', 'Pesquisar', 'Tarefas Recentes', 'Tarefas Concluídas']
                  .map<PopupMenuItem<String>>((String value) {
                return PopupMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<TaskBoard>>(
        // Substitua com a lógica apropriada para obter a lista de quadros de tarefas
        future: _taskBoardController.getTaskBoards(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Erro ao carregar quadros de tarefas\n' + snapshot.error.toString());
          } else {
            List<TaskBoard> taskBoards = snapshot.data ?? [];
            
            
        
            return ListView.builder(
              itemCount: taskBoards.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(taskBoards[index].name),
                  subtitle: Text('Quantidade de Tarefas:${taskBoards[index].qtdTask}'),
                  onTap: () {
                    // Implemente a lógica para navegar para a tela de tarefas do quadro selecionado
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}