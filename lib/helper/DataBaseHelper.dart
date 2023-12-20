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

            
            """;
      await db.execute(sql);
    });

    return db;
  }


}
