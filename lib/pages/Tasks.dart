import 'package:flutter/material.dart';
import 'package:planner_tarefas/controller/TaskController.dart';
import 'package:planner_tarefas/model/Task.dart';
import 'package:intl/intl.dart' ;
import 'package:shared_preferences/shared_preferences.dart'; 

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


void _addNewTask(Task task) async{
    // Adicione a lógica para criar a nova tarefa
    
    await taskController.addTask(task);
    setState(() {
      
    }); 
   
  }
void _showAddTaskDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController noteController = TextEditingController();
    TextEditingController dateTimeStartController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adicionar Nova Tarefa'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Título:'),
              TextField(controller: titleController),
              SizedBox(height: 8),
              Text('Nota:'),
              TextField(controller: noteController),
              Text('Data de início:'),
              TextField(
                controller: dateTimeStartController
                )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Task newTask = Task(user_id: usuarioId, board_id: taskBoardId, title: titleController.text, note: noteController.text, date: DateTime.now().toString(), startTime: dateTimeStartController.text, endTime: '', isCompleted: 0);
                _addNewTask(newTask);
                Navigator.pop(context); // Fechar o diálogo
              },
              child: Text('Adicionar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fechar o diálogo
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
  void _editTask(Task task) {
    TextEditingController titleController = TextEditingController(text: task.title);
    TextEditingController noteController = TextEditingController(text: task.note);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Editar Tarefa'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Novo Título:'),
            TextField(controller: titleController),
            SizedBox(height: 8),
            Text('Nova Nota:'),
            TextField(controller: noteController),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              taskController.updateTask(task, titleController.text, noteController.text);
              Navigator.pop(context); // Fechar o diálogo
              setState(() {
                
              });
            },
            child: Text('Salvar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Fechar o diálogo
            },
            child: Text('Cancelar'),
          ),
        ],
      );
    },
  );
}
  @override
  Widget build(BuildContext context){
    print("${usuarioId} ${taskBoardId}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Tarefas"),
        actions: [
          IconButton(onPressed: (){_showAddTaskDialog(context);}, icon: Icon(Icons.add))
        ],
        ),
      body: FutureBuilder<List<Task>>(
        future: taskController.getAllTaskOfTaskBoards(usuarioId, taskBoardId),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }else if(snapshot.hasError){
            return Text('Erro: ${snapshot.error.toString()}');
          }else{
            List<Task> tasks = snapshot.data!;
            
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index){
                print(tasks.length);
                
                return ListTile(
                  title: Text(tasks[index].title),
                  subtitle: Text(tasks[index].note),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Início: ${tasks[index].startTime}   |    "
                      ),
                      Text("Término: ${tasks[index].endTime}    "),
                      Checkbox(
                        value: tasks[index].isCompleted == 1 ? true : false,
                        onChanged: (value) async{
                          
                          await taskController.markTaskAsComplete(tasks[index]);
                          setState(() {
                            
                          });
                        },
                        ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _editTask(tasks[index]);
                        }
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