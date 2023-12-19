import 'dart:convert';
import 'dart:ffi';
import 'dart:html';

class Task {
  final int? id;
  late final int user_id;
  late final int board_id;
  late final String title;
  late final String note;
  late final DateTime date;
  late final DateTime startTime;
  late final DateTime endTime;
  final Bool isCompleted;

  Task(
      {this.id,
      required this.board_id,
      required this.title,
      required this.note,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.isCompleted});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": this.id,
      "board_id": this.board_id,
      "title": this.board_id,
      "note": this.note,
      "date": this.date,
      "startTime": this.startTime,
      "endTime": this.endTime,
      "isCompleted": this.isCompleted
    };
  }

  factory Task.fromMap(Map<String, dynamic> map){
    return Task(
      id: map["id"] ??= map["id"],
      board_id: map["board_id"] as int,
      title: map["title"] as String,
      note: map["note"] as String,
      date: map["date"] as DateTime,
      startTime: map["startTime"] as DateTime,
      endTime: map["endTime"] as DateTime,
      isCompleted: map["isCompleted"] as Bool
    );
  }

  String toJson() => jsonEncode(toMap());
  
  factory Task.fromJson(String source) => Task.fromMap(jsonDecode(source) as Map<String, dynamic>);

}
