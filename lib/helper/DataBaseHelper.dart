import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  static Database? _db;

  factory DatabaseHelper() => _instance;

  DatabaseHelper.internal();

  Future<Database> get db async {
    return _db ??= await initDb();
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, "data.db");

    Database db =
        await openDatabase(path, version: 1, onCreate: (db, version) async {
      String sql = """
            CREATE TABLE user( 
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              username VARCHAR,
              email varchar, 
              password VARCHAR
            );
            
            CREATE TABLE task_board(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name VARCHAR NOT NULL,
	            color INTEGER NOT NULL
            );
            CREATE TABLE task(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
	            user_id INTEGER NOT NULL,
	            board_id INTEGER NOT NULL,
              title VARCHAR NOT NULL,
              note TEXT NOT NULL,
              date VARCHAR NOT NULL,
              startTime VARCHAR NOT NULL,
	            endTime VARCHAR NOT NULL,
	            isCompleted INTEGER,
	            FOREIGN KEY(user_id) REFERENCES user(id),
	            FOREIGN KEY(board_id) REFERENCES task_board(id)
              );
              INSERT INTO user(username, email, password) VALUES('teste1', 'teste1@teste', '123456');
              INSERT INTO user(username, email, password) VALUES('teste2', 'teste2@teste', '123456');
              INSERT INTO user(username, email, password) VALUES('teste3', 'teste3@teste', '123456');
              INSERT INTO user(username, email, password) VALUES('teste4', 'teste4@teste', '123456');
              INSERT INTO user(username, email, password) VALUES('teste5', 'teste5@teste', '123456');
              INSERT INTO task_board(name, color) VALUES('Trabalho', 1);
              INSERT INTO task_board(name, color) VALUES('Saúde', 2);
              INSERT INTO task_board(name, color) VALUES('Estudo', 3);
              INSERT INTO task_board(name, color) VALUES('Flutter', 4);
              INSERT INTO task_board(name, color) VALUES('Academia', 5);
              INSERT INTO task(user_id, board_id, title, note, date, startTime, endTime, isCompleted) VALUES(1, 1, 'Criar Projeto', 'Definir a estrutura do projeto indicando a linguagem de programação e dados necessários.', '2023-12-01', '2024-01-01', '2024-01-02', 0);
              INSERT INTO task(user_id, board_id, title, note, date, startTime, endTime, isCompleted) VALUES(1, 2, 'Comprar Frutas', 'Comprar maça, banana e abacaxi.', '2023-12-01', '2024-01-01', '2024-01-02', 0);
              INSERT INTO task(user_id, board_id, title, note, date, startTime, endTime, isCompleted) VALUES(2, 3, 'Estudar P2 de Sistemas Operacionais', 'Fazer resumo de Gerência de Memória focando em Paginação.', '2023-12-01', '2024-01-01', '2024-01-02', 0);
              INSERT INTO task(user_id, board_id, title, note, date, startTime, endTime, isCompleted) VALUES(3, 4, 'Projeto Planner de Tarefas', 'Organizar tarefas com o grupo e definir a estrutura do projeto.', '2023-12-01', '2023-12-01', '2022-12-20', 0);
              INSERT INTO task(user_id, board_id, title, note, date, startTime, endTime, isCompleted) VALUES(3, 5, 'Correr no Campus da UFF', 'Alcançar a meta de 5KM.', '2023-12-01', '2024-01-01', '2024-01-02', 0);


            
            """;
      await db.execute(sql);
    });

    return db;
  }


}
